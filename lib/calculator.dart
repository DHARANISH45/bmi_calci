import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  Color myColor = Colors.transparent;
  String bmiStatus = "";
  TextEditingController weight_Controller = TextEditingController();
  TextEditingController height_Controller = TextEditingController();
  var main_result = TextEditingController();

  CalCulate_BMI(String weight, String height) async {
    var myDouble_weight = double.parse(weight);
    assert(myDouble_weight is double);
    var myDouble_height = double.parse(height);
    assert(myDouble_height is double);

    var res = (myDouble_weight / (myDouble_height * myDouble_height));

    setState(() {
      main_result.text = res.toStringAsFixed(2);
      if (res < 18.5) {
        myColor = Color(0xFFFFFF00); // Yellow for underweight
        bmiStatus = "Underweight";
      } else if (res >= 18.5 && res <= 24.9) {
        myColor = Color(0xFF00FF00); // Green for normal weight
        bmiStatus = "Normal weight";
      } else if (res >= 25 && res <= 29.9) {
        myColor = Color(0xFFFF0000); // Red for overweight
        bmiStatus = "Overweight";
      } else if (res >= 30 && res <= 34.9) {
        myColor = Color(0xFFFF0000); // Red for obesity
        bmiStatus = "Obese";
      } else if (res >= 35) {
        myColor = Color(0xFFFF0000); // Red for extreme obesity
        bmiStatus = "Extremely obese";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "BMI Calculator",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF880E4F), // Changed color
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: weight_Controller,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter your weight (kg)",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: height_Controller,
                        autofocus: false,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter your height (m)",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            CalCulate_BMI(weight_Controller.text, height_Controller.text);
                          },
                          child: Text(
                            "Calculate",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF880E4F)), // Changed color
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      height: 80,
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: Text(
                          "BMI: " + main_result.text + "\nStatus: " + bmiStatus,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // Legend for BMI color coding
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        LegendItem(color: Color(0xFFFFFF00), text: "Underweight"),
                        LegendItem(color: Color(0xFF00FF00), text: "Normal weight"),
                        LegendItem(color: Color(0xFFFF0000), text: "Overweight"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            color: color,
          ),
          SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
