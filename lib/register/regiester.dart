import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dialog_utils.dart';
import 'package:todoapp/firebase_utlis.dart';
import 'package:todoapp/home/homescreen.dart';
import 'package:todoapp/model/user.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/auth_provider.dart';
import '../compounent/custom_widget.dart';
import '../login/login_screen.dart';

class Register extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var namecontroller = TextEditingController(text: 'ahmed2');

  var emailcontroller = TextEditingController(text: 'ahmed2@gmail.com');

  var passwordcontroller = TextEditingController(text: '123456');

  var confirmationpasswordcontroller = TextEditingController(text: '123456');

  var formKey=GlobalKey<FormState>();

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
            key:formKey ,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.34,
                  ),
                  CustomFormFeild(
                    label: 'User Name',
                    controller: namecontroller,
                    myValidator: (text){
                      if(text==null ||text.trim().isEmpty){
                        return 'Please Enter The User Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormFeild(
                      label: 'Email Address',
                      keyboardtype: TextInputType.emailAddress,
                      controller: emailcontroller,
                      myValidator: (text){
                      if(text==null ||text.trim().isEmpty){
                      return 'Please Enter The Email Address';
                      }
                      bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if(!emailValid){
                        return 'Please Enter The Email Valid';
                      }
                      return null;
                      } ,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormFeild(
                      label: 'Password',
                      ispassword: true,
                      keyboardtype: TextInputType.number,
                      controller: passwordcontroller,
                      myValidator: (text){
                      if(text==null ||text.trim().isEmpty){
                        return 'Please Enter The Password';
                      }if(text.length<6){
                        return 'the password is short';
                      }
                      return null;
                    } ,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomFormFeild(
                      label: 'Confirmation Password',
                      ispassword: true,
                      keyboardtype: TextInputType.number,
                      controller: confirmationpasswordcontroller,
                      myValidator: (text){
                      if(text==null ||text.trim().isEmpty){
                        return 'Please Enter The Confirmation Password';
                      }
                      // if(text != passwordcontroller){
                      //   return "password don't match";
                      // }
                      return null;
                    } ,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: (){
                          regiester();
                      },
                     child: Text(
                       'Register',
                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
                         color: MyTheme.whiteColor
                       ),
                     ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *0.05,
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(Login.routeName);
                    },
                    child: Text('Already have an account',
                      style:Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> regiester() async {
    if(formKey.currentState!.validate()==true) {
 DialogUtils.showLoading(context, 'Loading...');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password:passwordcontroller.text,
        );
        MyUser myUser=MyUser(
            id: credential.user?.uid??'',
            name: namecontroller.text,
            email: emailcontroller.text
        );

        var authprovider=Provider.of<AuthProvider>(context,listen: false);
   authprovider.updateUser(myUser);
        FirebaseUtils.AddUserToFireStore(myUser);

       DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context, 'Register Successfully',
            posActionName: 'OK',
           posAction: (){
          Navigator.pushReplacementNamed(context,HomeScreen.routeName);
           }
        );

      } on FirebaseAuthException catch (e) {
        DialogUtils.hideDialog(context);
        String errormessage='something with wrong';
        if (e.code == 'weak-password') {
          errormessage= 'The password provided is too weak.';
          DialogUtils.showLoading(context,  errormessage);
        } else if (e.code == 'email-already-in-use') {
          errormessage= 'The account already exists for that email.';
          DialogUtils.showLoading(context,  errormessage);
        }
      } catch (e) {

        DialogUtils.showLoading(context, e.toString());

      }
     }
  }
}
