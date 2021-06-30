import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:vector_cg/services/database.dart';

class ActivityForm extends StatefulWidget {
  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();
  var txt = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString());

  late DateTime date;
  late String zipCode;
  late String selectedState;
  late String selectedCity;

  List states = ['Gujarat', 'Maharashtra'];

  List cities = [''];

  void getCityList() async {
    try {
      for (var state in states) {
        Response response = await get(Uri.parse(
            'https://api.promptapi.com/geo/country/cities/IN/$state?apikey=s0oMpM4uCthSfh9AvRXYnKfsCBOIgYuA'));
        List data = json.decode(response.body);

        for (var city in data) {
          cities.add(
              "${state.toString().toUpperCase().substring(0, 3)}: ${city['name']}");
        }
        cities.sort();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  @override
  void initState() {
    super.initState();
    getCityList();
  }

  @override
  Widget build(BuildContext context) {
    //get list of all documents from the stream passed to this route as an arguement
    List activity = ModalRoute.of(context)!.settings.arguments as List;

    final user = Provider.of<User?>(context);

    //check who is currently logged in
    List activityData = [];

    String getData(List data) {
      for (var act in activity) {
        //if the user is the owner of the document only then we will list it
        if (user!.uid.substring(0, 28) == act['docId'].substring(0, 28)) {
          data.add(act.data());
        }
      }
      int num = data.length;
      return num.toString();
    }

    String docNumber = getData(activityData);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Activity"),
        centerTitle: true,
        backgroundColor: Color(0xFF262626),
      ),
      body: ListView(children: [
        Container(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      //onChanged: (val) => date = DateTime.parse(val.toString()),
                      readOnly: true,
                      validator: (val) =>
                          val!.isNotEmpty ? null : "Select a date",
                      controller: txt,
                      decoration: InputDecoration(
                        suffix: IconButton(
                          onPressed: () async {
                            DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100));

                            setState(() {
                              if (selectedDate != null) {
                                date = DateTime.parse(DateFormat('yyyyMMdd')
                                    .format(selectedDate));

                                txt.text = DateFormat('dd-MM-yyyy')
                                    .format(date)
                                    .toString();
                              }
                            });
                          },
                          icon: Icon(Icons.calendar_today_sharp),
                        ),
                        border: UnderlineInputBorder(),
                        labelText: 'Date',
                      ),
                    ),
                    SizedBox(height: 32),
                    DropdownButtonFormField(
                      onChanged: (val) {
                        setState(() {
                          selectedState = val.toString();
                        });
                      },
                      hint: Text("State"),
                      items: states
                          .map((state) => DropdownMenuItem(
                                value: state,
                                child: Text("$state"),
                              ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    DropdownButtonFormField(
                      onChanged: (val) {
                        selectedCity = val.toString();
                      },
                      hint: Text("City"),
                      items: cities
                          .map((city) => DropdownMenuItem(
                                value: city,
                                child: Text("$city"),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 32),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Please enter the zip code" : null,
                      onChanged: (val) {
                        setState(() {
                          zipCode = val;
                        });
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Zip code',
                      ),
                    ),
                    SizedBox(height: 32),
                    TextButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          DataBaseService(uid: user!.uid + '-$docNumber')
                              .newUserActivity(user.uid, date, selectedState,
                                  selectedCity.substring(5), zipCode);
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(Icons.save_alt_sharp),
                      label: Text(
                        "Save",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF72BF44))),
                    )
                  ],
                ),
              )),
        ),
      ]),
    );
  }
}
