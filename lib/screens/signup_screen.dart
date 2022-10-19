import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/screens/utils/sqlite_services.dart';
import 'package:passwordmanager/widgets/custom_button.dart';
import 'package:passwordmanager/widgets/validator.dart';
import 'authentication_screen.dart';
import '../widgets/validation_textfield.dart';
import '../screens/utils/crypt.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with MobileValidation, Crypt {
  bool _passwordVisibility = false;
  bool _obscure = true;
  @override
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mPinController = TextEditingController();
  TextEditingController mPinConfirmController = TextEditingController();
  @override
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
          MyTextField(
              label: "MPin",
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
              textController: mPinConfirmController,
              obscure: _obscure,
              callBack: (value) {
                return MpinConfirmer(value, mPinController.text);
              }),
          CustomWhiteButton(
              text: "Sign Up",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (mPinController.text == mPinConfirmController.text) {
                    if (await DatabaseService.instance
                            .checkExistanceUser(mobileController.text) ==
                        false) {
                      DatabaseService.instance.createUser({
                        'phone_number': mobileController.text.trim(),
                        'password': Crypt.encryptPassword(mPinController.text),
                        //'password': mPinController.text.trim(),
                      });
                      // DatabaseService.instance.getAllUser();
                      // int userid = await DatabaseService.instance
                      //     .getUserByMobile(mobileController.text);
                      // print(userid);
                      Fluttertoast.showToast(
                        msg: "Account Created",
                        fontSize: 10,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Authentication()));
                    } else {
                      Fluttertoast.showToast(
                        msg: "Mobile Number Exists",
                        fontSize: 20,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                      );
                    }
                  }
                }
              }),
        ],
      ),
    );
    ;
  }
}
