import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final formKey = GlobalKey<FormState>();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(70, 184, 252, 1),
            Color.fromRGBO(30, 136, 252, 1)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset("images/logo_login.png"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Text("SIGN IN",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                onTap: () {
                                  setState(() {
                                    index = 0;
                                  });
                                },
                              ),
                              GestureDetector(
                                child: Text("SIGN UP",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                onTap: () {
                                  setState(() {
                                    index = 1;
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 3.5,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: index == 0
                                      ? const Color(0xFFFFA222)
                                      : Colors.transparent,
                                ),
                              ),
                              Container(
                                height: 3.5,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: index == 1
                                      ? const Color(0xFFFFA222)
                                      : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.white30,
                          ),
                          IndexedStack(
                            index: index,
                            children: [
                              SignIn(updateIndex: () {
                                setState(() {
                                  index = 1;
                                });
                              }),
                              SignUp()
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
