import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/screens/utils/sqlite_services.dart';
import 'package:passwordmanager/widgets/validation_textfield.dart';
import 'package:passwordmanager/widgets/validator.dart';
import 'home_screen.dart';
import 'package:passwordmanager/widgets/custom_button.dart';
import '../screens/utils/crypt.dart';

class SignIn extends StatefulWidget {
  Function updateIndex;
  SignIn({required this.updateIndex});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with MobileValidation, Crypt {
  bool _passwordVisibility = false;
  bool _obscure = true;
  @override
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mPinController = TextEditingController();
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextField(
              label: "Mobile Number",
              textController: mobileController,
              obscure: false,
              callBack: (value) {
                return mobileValadition(value);
              }),
          MyTextField(
              label: "MPin",
              textController: mPinController,
              icon: IconButton(
                icon: Icon(
                  _passwordVisibility ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisibility =
                        _passwordVisibility == true ? false : true;
                    _obscure = _passwordVisibility == true ? true : false;
                  });
                },
              ),
              obscure: _obscure,
              callBack: (value) {
                return MpinValidator(value);
              }),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: InkWell(
                child: Text(
                  "Forgot password?",
                ),
                onTap: () {
                  widget.updateIndex();
                }),
          ),
          CustomWhiteButton(
              text: "Sign In",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  String respone = await DatabaseService.instance.getUserByData(
                      mobileController.text,
                      Crypt.encryptPassword(mPinController.text));
                  if (respone == "404") {
                    Fluttertoast.showToast(
                      msg: "User Does not Exist",
                      fontSize: 20,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                    );
                  } else if (respone == "200") {
                    Fluttertoast.showToast(
                      msg: "Success",
                      fontSize: 20,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                    );
                    int userid = await DatabaseService.instance
                        .getUserByMobile(mobileController.text);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              userid: userid,
                            )));
                  } else if (respone == "401") {
                    Fluttertoast.showToast(
                      msg: "Incorrect Password",
                      fontSize: 20,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                    );
                  }
                }
              }),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: Image.asset(
              'images/fingerprint.png',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("OR"),
              SizedBox(
                width: 15,
              ),
              Text("USE YOUR FINGERPRINT TO LOGIN",
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ],
      ),
    );
  }
}
