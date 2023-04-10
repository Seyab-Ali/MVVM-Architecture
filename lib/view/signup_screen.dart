import 'package:flutter/material.dart';
import 'package:mvvm_architecture/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(
                  context, emailFocusNode, passwordFocusNode);
              //  FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            controller: emailController,
            decoration: const InputDecoration(
                hintText: "Enter Email",
                labelText: "Email",
                prefixIcon: Icon(Icons.email)),
          ),
          ValueListenableBuilder(
            valueListenable: obscurePassword,
            builder: (context, value, child) {
              return TextFormField(
                focusNode: passwordFocusNode,
                obscureText: obscurePassword.value,
                obscuringCharacter: '*',
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: InkWell(
                      onTap: () {
                        obscurePassword.value = !obscurePassword.value;
                      },
                      child: Icon(obscurePassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility)),
                ),
              );
            },
          ),
          SizedBox(
            height: height * 0.085,
          ),
          RoundButton(
            loading: authViewModel.signUploading,
            title: "Login",
            onpress: () {
              if (emailController.text.isEmpty) {
                Utils.snackBar("Please Enter email", context);
              } else if (passwordController.text.isEmpty) {
                Utils.snackBar("Please Enter password", context);
              } else if (passwordController.text.length < 6) {
                Utils.snackBar("Please Enter 6  password", context);
              } else {
                Map data = {
                  'email': emailController.text.toString(),
                  'password': passwordController.text.toString(),
                };
                authViewModel.resgisterApi(data, context);
                print('Api hit');
              }
            },
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteName.login);
            },
            child: const Text("Already have an account? LogIn"),
          )
        ],
      ),
    );
  }
}
