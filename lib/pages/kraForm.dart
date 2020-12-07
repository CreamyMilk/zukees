import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/services.dart';

class BaseForm extends StatefulWidget {
  BaseForm({Key key}) : super(key: key);

  @override
  _BaseFormState createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  List<Widget> pages = [
    NameForm(),
    BirthForm(),
    NumberForm(
      name: "Oliver Ndegwa",
    ),
    IDForm(),
    DoubleCheckPage(),
  ];

  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: activePage == 0 ? Icon(Icons.home) : Icon(Icons.arrow_back),
              onPressed: () {
                if (activePage != 0) {
                  setState(() {
                    activePage = activePage - 1;
                  });
                } else {
                  Navigator.of(context).pop();
                }
              }),
          backgroundColor: Colors.teal[400],
          title: Transform.translate(
              offset: Offset(30, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: LinearProgressIndicator(
                      backgroundColor: Colors.teal[600],
                      value: 0.20 * (activePage + 1))))),
      body: pages[activePage],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          setState(() {
            if (activePage != pages.length - 1) {
              activePage = activePage + 1;
            }
          });
        },
        icon: activePage == pages.length - 1
            ? Icon(Icons.check_circle_outline, color: Colors.white)
            : null,
        label: Text(
            (activePage != pages.length - 1
                ? "       NEXT        "
                : "       Pay Now        "),
            style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }
}

class NameForm extends StatelessWidget {
  const NameForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Text("Lets Register for you automated tax filing",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.teal[400])),
        SizedBox(height: 15),
        Text("Whats is your name ?",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        SizedBox(height: 15),
        Text("Just as it appears on your National ID",
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'First Name',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              focusColor: Colors.teal,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              labelText: 'Last Name',
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class BirthForm extends StatelessWidget {
  const BirthForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 30),
      Text("Whats is your date of birth?",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
      SizedBox(height: 15),
      Text("Just as it appears on your National ID",
          style: TextStyle(fontSize: 12, color: Colors.grey)),
      SizedBox(height: 50),
      Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(width: 5),
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Year',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(width: 25),
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Month',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(width: 25),
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Day',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(width: 5),
        ]),
      )
    ]);
  }
}

class NumberForm extends StatelessWidget {
  final String name;
  const NumberForm({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Text("Ok $name !",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.teal[400])),
        SizedBox(height: 15),
        Text("Whats is your Phone Number ?",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        SizedBox(height: 15),
        Text("Recommeded to use Safaricom number",
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(width: 5),
            Flexible(
              flex: 2,
              child: TextFormField(
                initialValue: "+254",
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Country',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(width: 25),
            Flexible(
              flex: 10,
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Phone number',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(width: 5),
          ]),
        )
      ],
    );
  }
}

class IDForm extends StatelessWidget {
  const IDForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 30),
      Text("Almost there!",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.teal[400])),
      SizedBox(height: 5),
      Text("Final personal check",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 19,
              color: Colors.teal[400])),
      SizedBox(height: 15),
      Text("Enter your KRA PIN",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
      SizedBox(height: 15),
      Text("Pin of the registerd property",
          style: TextStyle(fontSize: 12, color: Colors.grey)),
      SizedBox(height: 30),
      Container(
        padding: EdgeInsets.only(left: 100, right: 100),
        child: OTPTextField(
          keyboardType: TextInputType.text,
          length: 11,
          width: MediaQuery.of(context).size.width,
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldWidth: 15,
          fieldStyle: FieldStyle.underline,
          style: TextStyle(fontSize: 14),
          onCompleted: (pin) {
            print("Completed: " + pin);
          },
        ),
      )
    ]);
  }
}

class DoubleCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Text("Double-check your information just to be sure",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.teal[400])),
        SizedBox(height: 40),
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'First Name',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              focusColor: Colors.teal,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              labelText: 'Last Name',
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(width: 5),
            Flexible(
              flex: 2,
              child: TextFormField(
                initialValue: "+254",
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Country',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(width: 25),
            Flexible(
              flex: 10,
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Phone number',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(width: 5),
          ]),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              focusColor: Colors.teal,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              labelText: 'KRA PIN',
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(height: 30),
        Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                    activeColor: Colors.teal,
                    value: true,
                    onChanged: (v) {
                      print(v);
                    }),
                Text("By proceeding you agree to our Terms and Conditions")
              ],
            )),
      ],
    );
  }
}
