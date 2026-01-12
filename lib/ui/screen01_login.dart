import 'package:field_technician_demo/ui/screen02_dashboard.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';

import '../app_data.dart';
import '../helper.dart';


class LoginScreen extends StatefulWidget {

  LoginScreen({
    super.key,
    required this.saveTasks,
    required this.saveOutboxTasks,
  });

  Function saveTasks;
  final Function saveOutboxTasks;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A57A3),
                  Color(0xFF0097A7),
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 120,),
                Image.asset(
                  'images/logo_field_tech.png',
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 12,),
                Text(
                  "Field Technician - \n Task Report Apps",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                                "Username",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color(0xFF212121),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              controller: usernameController,
                              onChanged: (val) {
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Username',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                                "Password",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color(0xFF212121),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              controller: passwordController,
                              onChanged: (val) {

                              },
                              decoration: InputDecoration(
                                //prefixIcon: Image.asset('images/email.png', width: 20, height: 20,),
                                hintText: 'Enter Password',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: SizedBox(
                              height: 47,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, Helper().createRoute( DashboardScreen(
                                    saveTasks: widget.saveTasks,
                                    saveOutboxTasks: widget.saveOutboxTasks,
                                  )));

                                },
                                style: ButtonStyle(
                                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                                    backgroundColor: WidgetStateProperty.all<Color>(const Color(
                                        0xffd6950d),),
                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            side: BorderSide(color: Color(0xffd6950d),)
                                        )
                                    )
                                ),
                                child: const Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),

                  ),
                ),
                const Spacer(), // Pushes the version text to the bottom
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, right: 15.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      appVersion,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}