import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dialog_utils.dart';
import 'package:todoapp/firebase_utlis.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/register/regiester.dart';

import '../compounent/custom_widget.dart';
import '../home/homescreen.dart';
import '../provider/auth_provider.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailcontroller = TextEditingController(text: 'ahmed1@gmail.com');

  var passwordcontroller = TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main_back.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery
                        .sizeOf(context)
                        .height * 0.34,
                  ),

                  CustomFormFeild(
                    label: 'Email Address',
                    keyboardtype: TextInputType.emailAddress,
                    controller: emailcontroller,
                    myValidator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return 'Please Enter The Email Address';
                      }
                      bool emailValid =
                      RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'Please Enter The Email Valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormFeild(
                    label: 'Password',
                    ispassword: true,
                    keyboardtype: TextInputType.number,
                    controller: passwordcontroller,
                    myValidator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return 'Please Enter The Password';
                      }
                      if (text.length < 6) {
                        return 'the password is short';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        'Login',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                            color: MyTheme.whiteColor
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *0.05,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Don't have an account",
                        style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(Register.routeName);
                          },
                         child: Text('SingUp',
                           style:Theme.of(context).textTheme.titleMedium!.copyWith(
                             color: Theme.of(context).primaryColor
                           ),
                         ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    var authprovider=Provider.of<AuthProvider>(context,listen: false);
    if (formKey.currentState!.validate() == true) {

      DialogUtils.showLoading(context, 'Loading...');

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );

       var user=await FirebaseUtils.readUserFormFireStore(credential.user?.uid??'');

      if(user==null){
        return ;
      }
      //var authprovider=Provider.of<AuthProvider>(context,listen: false);

        authprovider.updateUser(user);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context, 'Login Successfully',
            posActionName: 'OK',
            posAction: (){
              Navigator.pushReplacementNamed(context,HomeScreen.routeName);
            }
        );
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideDialog(context);
        if (e.code == 'user-not-found') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(context,'No user found for that email.');

        } else if (e.code == 'wrong-password') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(context, 'Wrong password provided for that user.');

        }
      } catch (e) {
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context, e.toString());


      }
    }
  }
}