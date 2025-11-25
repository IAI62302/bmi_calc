import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedGender = 0, _height = 170, _weight = 65, _age = 25;
  double _bmiResult = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BMI Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        backgroundColor: Colors.deepPurpleAccent[200],
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            double heightInMeters = _height / 100;
            _bmiResult = _weight / (heightInMeters * heightInMeters);
          });
        },
        child: Icon(Icons.calculate),
      ),
    );
  }

  Widget _buildUI() {
    return Column(children: [_genderSelect(), _heightSelect(), _weightAgeSelectRow(), _bmiResultDisplay(), _bmiStatus()],);
  }

  Widget _genderSelect() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(40),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedGender = 0;
                  });
                },
                iconSize: 40,
                icon: Icon(
                  Icons.male,
                  color: _selectedGender == 0 ? Colors.blue : Colors.black,
                ),
              ),
              Text("Male", style: TextStyle(fontSize: 20)),
            ],
          ),

          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedGender = 1;
                  });
                },
                iconSize: 40,
                icon: Icon(
                  Icons.female,
                  color: _selectedGender == 1 ? Colors.pink : Colors.black,
                ),
              ),
              Text("Female", style: TextStyle(fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heightSelect() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(40),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Text("Select Height", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Slider(
          value: _height.toDouble(),
          min: 0,
          max: 300,
          divisions: 300,
          label: '$_height cm',
          onChanged: (double value) {
            setState(() {
              _height = value.toInt();
            });
          },
        ),
        Text("$_height cm", style: TextStyle(fontSize: 18)),
      ]),
    );
  }

  Widget _weightAgeSelectRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      _weightSelect(),
      _ageSelect(),
    ],);
  }

  Widget _weightSelect() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      padding: EdgeInsets.all(7),
      child: Column(children: [
        Text("Weight", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        
        SizedBox(height: 20),
        
        ItemCount(buttonSizeHeight: 30, buttonSizeWidth: 60, initialValue: _weight, minValue: 50, maxValue: 300, onChanged:(value) {
          setState(() {
            _weight = value.toInt();
          });
        }, decimalPlaces: 0,)
      ],));
  }

  Widget _ageSelect() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      padding: EdgeInsets.all(7),
      child: Column(children: [
        Text("Age", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        
        SizedBox(height: 20),
        
        ItemCount(buttonSizeHeight: 30, buttonSizeWidth: 60, initialValue: _age, minValue: 0, maxValue: 100, onChanged:(value) {
          setState(() {
            _age = value.toInt();
          });
        }, decimalPlaces: 0,)
      ],));
  }

  Widget _bmiResultDisplay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Text("BMI Result", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Text(_bmiResult == 0.0 ? "Press Calculate For Result" : _bmiResult.toStringAsFixed(2), style: TextStyle(fontSize: 18)),
      ]));
  }

  Widget _bmiStatus() {
    String status = "";
    if (_bmiResult == 0.0) {
      status = "To be determined";
    } else if (_bmiResult < 18.5) {
      status = "Underweight";
    } else if (_bmiResult < 24.9) {
      status = "Normal weight";
    } else if (_bmiResult < 29.9) {
      status = "Overweight";
    } else {
      status = "Obesity";
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Text("BMI Status", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Text(status, style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent)),
      ]));
  }
}
