import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
    title: "simple intrest calci",
    home: SIcal(),
  ));
}

class SIcal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIstate();
  }
}

class SIstate extends State<SIcal> {
  var _form = GlobalKey<FormState>();
  final margine = 5.0;
  var _currencies = ["Rupees", "Dollar", "Pound"];

  var _currentvalue = "Rupees";
  String ans = '';

  TextEditingController principlecontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController termcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple Intrest calci"),
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            children: [
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: margine * 2, bottom: margine * 2),
                child: TextFormField(
                  controller: principlecontroller,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Principle cannot be empty";
                    }
                    if (!RegExp(r'^[0-9]*\.?[0-9]+$').hasMatch(value)) {
                      return "Only Valid Number";
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle:
                        TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                    labelText: "Principal",
                    hintText: "Enter Principal Amount EX. 1000",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: margine * 2, bottom: margine * 2),
                child: TextFormField(
                  controller: roicontroller,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Plese enter term";
                    }
                    if (!RegExp(r'^[0-9]*\.?[0-9]+$').hasMatch(value)) {
                      return "Only Valid Number";
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle:
                        TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                    labelText: "Rate",
                    hintText: "Enter Rate of Intrest",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: margine * 2, bottom: margine * 2),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: termcontroller,
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plese enter term";
                          }
                          if (!RegExp(r'^[0-9]*\.?[0-9]+$').hasMatch(value)) {
                            return "Only Valid Number";
                          }
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          labelText: "Term",
                          hintText: "Enter Term",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    Container(
                      width: margine * 2,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (String newvalue) {
                          setState(() {
                            _dropchange(newvalue);
                          });
                        },
                        value: _currentvalue,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: margine, bottom: margine),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          setState(() {
                            if (_form.currentState.validate()) {
                              this.ans = _calculate();
                            }
                          });
                        },
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                this.ans,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(margine * 10),
    );
  }

  void _dropchange(String newv) {
    setState(() {
      _currentvalue = newv;
    });
  }

  String _calculate() {
    double prici = double.parse(principlecontroller.text);
    double roi = double.parse(roicontroller.text);
    double term = double.parse(termcontroller.text);

    double intrest = prici + (prici + roi + term) / 100;
    String result = "After  $term year amount will be $intrest ";

    return result;
  }

  void _reset() {
    principlecontroller.text = "";
    roicontroller.text = "";
    termcontroller.text = "";

    this.ans = "";
    _currentvalue = _currencies[0];
  }
}
