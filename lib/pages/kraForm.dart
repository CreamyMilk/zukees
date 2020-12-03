import 'package:flutter/material.dart';

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
                      value: 0.25 * (activePage + 1))))),
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
        icon: activePage == pages.length - 1?Icon(Icons.check_circle_outline,color:Colors.white):null,
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
        Text("Lets Register for your autmated ta filing"),
        Text("Whats is your name ?"),
        Text("Just as it appears on your National ID"),
        Container(
          child: TextField(),
        ),
      ],
    );
  }
}

class BirthForm extends StatelessWidget {
  const BirthForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Whats is your Age?"),
        Text("Just as it appears on your National ID"),
        Container(
          child: TextField(),
        ),
      ],
    );
  }
}

class NumberForm extends StatelessWidget {
  final String name;
  const NumberForm({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Ok $name"),
        Text("Whats is your Phone Number?"),
        Text("Safaricom number that will be used for account activation"),
        Container(
          child: TextField(),
        ),
      ],
    );
  }
}

class IDForm extends StatelessWidget {
  const IDForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Let's complete your registration."),
        Text("Enter your identity details"),
        Text("This is definitiely unique to you."),
        Container(
          child: TextField(),
        ),
      ],
    );
  }
}
