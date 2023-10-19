import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/register/register_navigator.dart';

import '../dialog_utils.dart';
import '../firebase_utlis.dart';
import '../provider/auth_provider.dart';

class RegisterScreenViewModel extends ChangeNotifier{
  /// todo: hold data handle logic
  late RegisterNavigator navigator;
 void register(String email,String password)async{

    navigator.showMyLoading();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password:password,
      );
      // MyUser myUser=MyUser(
      //     id: credential.user?.uid??'',
      //     name: namecontroller.text,
      //     email: emailcontroller.text
      // );
      //
      // var authprovider=Provider.of<AuthProvider>(context,listen: false);
      // authprovider.updateUser(myUser);
      // FirebaseUtils.AddUserToFireStore(myUser);

      navigator.hideMhyLoading();
      navigator.showMessage('Register Successfully');

    } on FirebaseAuthException catch (e) {

      String errormessage='something with wrong';
      if (e.code == 'weak-password') {
        navigator.hideMhyLoading();
        navigator.showMessage('The password provided is too weak.');

      } else if (e.code == 'email-already-in-use') {
        navigator.hideMhyLoading();
        navigator.showMessage('The account already exists for that email.');
      }
    } catch (e) {

      navigator.hideMhyLoading();
      navigator.showMessage(e.toString());


    }
  }
}