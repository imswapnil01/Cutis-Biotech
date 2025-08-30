import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cutis_biotech/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _pin = "";

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
    // if (_pin.length == 5) {

    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please enter a valid 5-digit PIN')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              SizedBox(
                height: 50,
                child: Image.asset("assets/Images/cutis_Biotech.png"),
              ),

              const SizedBox(height: 20),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 29,
                  color: Color.fromARGB(255, 14, 82, 138),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Enter your 5-digit PIN",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 20),

              // PIN Input Fields
              Container(
                width: 260, 
                child: PinCodeTextField(
                  appContext: context,
                  length: 5,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(fontSize: 20),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 45,
                    fieldWidth:
                        45, 
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    activeColor: Color.fromRGBO(81, 120, 237, 1),
                    selectedColor: Color.fromRGBO(81, 120, 237, 1),
                    inactiveColor: Colors.grey,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: (value) {
                    setState(() {
                      _pin = value;
                    });
                  },
                ),
              ),

             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Forgot PIN logic
                    },
                    child: const Text(
                      "Forgot PIN?",
                      style: TextStyle(color: Color.fromARGB(255, 80, 113, 223),fontWeight: FontWeight.bold),
                    ),
                  ),
                 
                ],
              ),
              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: 280,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(81, 120, 237, 1),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _login,
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Forgot PIN & Sign Up Options
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     // Forgot PIN logic
                  //   },
                  //   child: const Text(
                  //     "Forgot PIN?",
                  //     style: TextStyle(color: Color.fromRGBO(81, 120, 237, 1)),
                  //   ),
                  // ),
                  Text('Create an account?'),
                  TextButton(
                    onPressed: () {
                      // Sign up logic
                    },
                    child: const Text("Sign Up",
                        style:
                            TextStyle(color: Color.fromARGB(255, 80, 113, 223), fontWeight: FontWeight.bold,)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
