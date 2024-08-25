import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/service/auth_service.dart';
import 'package:flutter/material.dart';

enum AuthType { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const String routeName = '/auth_screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthType _authType = AuthType.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // TODO: final logger = Logger();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passController.dispose();
  }

  void signUpUser() {
    FocusManager.instance.primaryFocus?.unfocus();
    authService.signUp(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passController.text,
    );
  }

  void signInUser() {
    FocusManager.instance.primaryFocus?.unfocus();
    authService.signIn(
      context: context,
      email: _emailController.text,
      password: _passController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                GlobalVariables.welcome,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: _authType == AuthType.signUp
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                leading: Radio(
                  groupValue: _authType,
                  value: AuthType.signUp,
                  activeColor: GlobalVariables.secondaryColor,
                  onChanged: (value) {
                    setState(() {
                      _authType = AuthType.signUp;
                    });
                  },
                ),
                title: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (_authType == AuthType.signUp)
                Container(
                  color: _authType == AuthType.signUp
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hint: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hint: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _passController,
                          hint: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          btnColor: GlobalVariables.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _authType == AuthType.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                leading: Radio(
                  groupValue: _authType,
                  value: AuthType.signIn,
                  activeColor: GlobalVariables.secondaryColor,
                  onChanged: (value) {
                    setState(() {
                      _authType = AuthType.signIn;
                    });
                  },
                ),
                title: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (_authType == AuthType.signIn)
                Container(
                  color: _authType == AuthType.signIn
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hint: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _passController,
                          hint: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'Sign In',
                          onTap: () {
                            if(_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                          btnColor: GlobalVariables.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
