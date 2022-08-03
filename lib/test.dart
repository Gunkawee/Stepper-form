import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'กรอกข้อมูลส่วนบุคคล';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _currentStep = 0;
  bool isCompleted = false;
  StepperType _stepperType = StepperType.horizontal;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final postcode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.light(primary: Colors.green)),
        child: Stepper(
          type: _stepperType,
          steps: getSteps(),
          currentStep: _currentStep,
          onStepContinue: () {
            final isLastStep = _currentStep == getSteps().length - 1;
            if (isLastStep) {
              setState(() => isCompleted = true);
              print('Completed'); // sent data to server
            } else {
              setState(
                () => _currentStep += 1,
              );
            }
          },
          onStepTapped: (step) => _currentStep = step,
          onStepCancel: () {
            _currentStep == 0 ? null : setState(() => _currentStep -= 1);
          },
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 0,
            title: Text('Account'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  controller: firstName,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextFormField(
                  controller: lastName,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(labelText: 'Email Address'),
                ),
              ],
            )),
        Step(
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 1,
            title: Text('Address'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  controller: address,
                  decoration: InputDecoration(labelText: 'Home Address'),
                ),
                TextFormField(
                  controller: postcode,
                  decoration: InputDecoration(labelText: 'Postcode'),
                ),
              ],
            )),
        Step(
          isActive: _currentStep >= 2,
          title: Text('Complete'),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "First Name : " + firstName.text,
                  style: TextStyle(fontSize: 20),
                ),
                Text("LastName : " + lastName.text,
                    style: TextStyle(fontSize: 20)),
                Text("Email : " + email.text, style: TextStyle(fontSize: 20)),
                Text("Address : " + address.text,
                    style: TextStyle(fontSize: 20)),
                Text("PostCode : " + postcode.text,
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ];
}
