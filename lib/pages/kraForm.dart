import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zukes/providers/kra_fromProvide.dart';
import 'package:zukes/widgets/otp_field_package.dart';

class BaseForm extends StatefulWidget {
  BaseForm({Key key}) : super(key: key);

  @override
  _BaseFormState createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  List<Widget> pages = [
    NameForm(),
    BirthForm(),
    NumberForm(),
    IDForm(),
    DoubleCheckPage(),
  ];

  int activePage;

  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<KraFormProvider>(context);
    final activePage = hbox.activePage;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: activePage == 0 ? Icon(Icons.home) : Icon(Icons.arrow_back),
              onPressed: () {
                if (activePage != 0) {
                  hbox.decrement();
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
          if (activePage == 0) {
            hbox.nfSubmit();
          } else if (activePage == 1) {
            hbox.bfSubmit();
          } else if (activePage == 2) {
            hbox.phSubmit();
          } else if (activePage == 3) {
            hbox.krSubmit();
          } else {
            if (activePage != pages.length - 1) {
              hbox.increment();
              print("okokok");
            }
          }
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
  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<KraFormProvider>(context);
    return Form(
      key: hbox.nameKey,
      child: Column(
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
              controller: hbox.fnController,
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
              controller: hbox.lnController,
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
      ),
    );
  }
}

class BirthForm extends StatelessWidget {
  const BirthForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<KraFormProvider>(context);

    // Show the modal that contains the CupertinoDatePicker
    void _showDatePicker(ctx) {
      // showCupertinoModalPopup is a built-in function of the cupertino library
      showCupertinoModalPopup(
          context: ctx,
          builder: (_) => Container(
                height: 300,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (val) {
                            // print(val);
                          }),
                    ),

                    // Close the modal
                    CupertinoButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(ctx).pop(),
                    )
                  ],
                ),
              ));
    }

    return Form(
      key: hbox.birthKey,
      child: Column(children: [
        SizedBox(height: 30),
        Text("Whats is your date of birth?",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        SizedBox(height: 15),
        Text("Just as it appears on your National ID",
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 50),
        CupertinoButton(
          child: Text("From Calender"),
          onPressed: () => _showDatePicker(context),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(width: 5),
            Flexible(
              child: TextFormField(
                controller: hbox.yController,
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
                controller: hbox.mController,
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
                controller: hbox.dController,
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
      ]),
    );
  }
}

class NumberForm extends StatelessWidget {
  const NumberForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fstore = Provider.of<KraFormProvider>(context);
    fstore.cnController.text = "+254";
    final name = fstore.firstName;
    return Form(
      key: fstore.phoneKey,
      child: Column(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 5),
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    maxLength: 4,
                    controller: fstore.cnController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      counterText: "",
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
                    maxLength: 10,
                    controller: fstore.phController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      counterText: "",
                      labelText: 'Enter Phone number',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IDForm extends StatelessWidget {
  const IDForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fstore = Provider.of<KraFormProvider>(context);
    return Form(
      key: fstore.kraKey,
      child: Column(children: [
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
          padding: EdgeInsets.only(left: 60, right: 60),
          child: OTPTextField(
            keyboardType: TextInputType.text,
            length: 11,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 15,
            fieldStyle: FieldStyle.underline,
            style: TextStyle(fontSize: 14),
            onCompleted: (pin) {
              fstore.krapin = pin;
              print("Completed: " + pin);
            },
          ),
        )
      ]),
    );
  }
}

class DoubleCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fstore = Provider.of<KraFormProvider>(context);
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
            initialValue: fstore.firstName,
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
            initialValue: fstore.lastName,
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
                initialValue: fstore.countrycode,
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
                initialValue: fstore.phoneNumber,
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
            initialValue: fstore.krapin,
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
                    value: fstore.terms,
                    onChanged: (v) {
                      fstore.termsAccept(v);
                    }),
                Text("By proceeding you agree to our Terms and Conditions")
              ],
            )),
      ],
    );
  }
}
