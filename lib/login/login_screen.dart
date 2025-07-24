import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dialog_utils.dart';
import 'package:todoapp/firebase_utlis.dart';
import 'package:todoapp/login/login_navigator.dart';
import 'package:todoapp/login/login_screen_view_model.dart';
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

class _LoginState extends State<Login> implements LoginNavigator{



 LoginScreenViewModel viewModel =LoginScreenViewModel();

 @override
 void initState(){
   super.initState();
   viewModel.navigator=this;
//   viewModel.navigator.nav(HomeScreen.routeName);

 }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>viewModel,
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(
          children: [
            Image.asset(
              'assets/images/main_back.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Form(
              key: viewModel.formKey,
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
                      controller: viewModel.emailController,
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
                      controller: viewModel.passwordController,
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
                         viewModel.login();
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
                              Navigator.of(context).pushNamed(RegisterScreen.routeName);
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
      ),
    );
  }



  @override
  void hideMyLoading() {
    DialogUtils.hideDialog(context);
  }

  @override
  void showMyLoading() {
    DialogUtils.showLoading(context, 'Loading...');
  }

  @override
  void showMyMessage(String message) {
   DialogUtils.showMessage(context, message,posActionName: 'OK');
  }

  @override
  void nav(String routeName) {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
