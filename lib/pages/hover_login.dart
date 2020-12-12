import 'package:flutter/material.dart';

class HoverLogin extends StatefulWidget {
  HoverLogin({Key key}) : super(key: key);

  @override
  _HoverLoginState createState() => _HoverLoginState();
}

class _HoverLoginState extends State<HoverLogin> {
     double h;
     @override
  void initState() {
    // TODO: implement initState
    h=0.5;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      floatingActionButton: FloatingActionButton( onPressed: () {print(MediaQuery.of(context).viewInsets.bottom); setState((){
               h=0.5;
             }); } ),
          body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(seconds:1), 
             color:Colors.black,
             height:MediaQuery.of(context).size.height*(1-h),
             width:MediaQuery.of(context).size.width,
             child:IconButton(icon: Icon(Icons.healing,color:Colors.white,size: 150,), onPressed: () {print(h); setState((){
               h=0.1;
             }); },)
          ),
          AnimatedContainer(
            duration: Duration(seconds:1), 
             color:Colors.red,
                  height:MediaQuery.of(context).size.height*(h),
             width:MediaQuery.of(context).size.width,
             child:SingleChildScrollView(
                            child: Column(
                              children: [
                                TextField(),
                                IconButton(icon: Icon(Icons.healing,color:Colors.white,size: 150,), onPressed: () {print(h); setState((){
                 h=0.9;
               }); },),
                              ],
                            ),
             )
          ),

        ],
      ),
    );
  }
}




