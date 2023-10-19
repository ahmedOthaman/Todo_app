

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/home/homescreen.dart';
import 'package:todoapp/login/login_navigator.dart';


class LoginScreenViewModel extends ChangeNotifier {
  ///todo:hold data handle logic
  var emailController = TextEditingController(text: 'ahmed10@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  late LoginNavigator navigator;
  var formKey = GlobalKey<FormState>();

  void login() async {
    if (formKey.currentState!.validate() == true) {
      navigator.showMyLoading();

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        navigator.hideMyLoading();
        navigator.showMyMessage('Login Successfully');
         navigator.nav(HomeScreen.routeName);
        // var user=await FirebaseUtils.readUserFormFireStore(credential.user?.uid??'');
        //
        // if(user==null){
        //   return ;
        // }
        //var authprovider=Provider.of<AuthProvider>(context,listen: false);
        //
        // authprovider.updateUser(user);
        // DialogUtils.hideDialog(context);
        // DialogUtils.showMessage(context, 'Login Successfully',
        //     posActionName: 'OK',
        //     posAction: (){
        //       Navigator.pushReplacementNamed(context,HomeScreen.routeName);
        //     }
        // );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          navigator.hideMyLoading();
          navigator.showMyMessage(
              'No user found for that email. or Wrong password provided for that user.');
        }
      }
      catch (e) {
        navigator.hideMyLoading();
        navigator.showMyMessage(e.toString());
      }
    }
  }
}