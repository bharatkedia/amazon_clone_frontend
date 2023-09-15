import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/color_util.dart';
import 'package:amazon_clone/constants/text_util.dart';
import 'package:flutter/cupertino.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                TextUtil.welcome,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: _authType == AuthType.signUp
                    ? ColorUtil.backgroundColor
                    : ColorUtil.greyBackgroundColor,
                leading: Radio(
                  groupValue: _authType,
                  value: AuthType.signUp,
                  activeColor: ColorUtil.secondaryColor,
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
                      ? ColorUtil.backgroundColor
                      : ColorUtil.greyBackgroundColor,
                  padding: const EdgeInsets.all(8),
                  child: Form(
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
                          btnColor: ColorUtil.secondaryColor,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _authType == AuthType.signIn
                    ? ColorUtil.backgroundColor
                    : ColorUtil.greyBackgroundColor,
                leading: Radio(
                  groupValue: _authType,
                  value: AuthType.signIn,
                  activeColor: ColorUtil.secondaryColor,
                  onChanged: (value) {
                    print(value);
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
                      ? ColorUtil.backgroundColor
                      : ColorUtil.greyBackgroundColor,
                  padding: const EdgeInsets.all(8),
                  child: Form(
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
                          btnColor: ColorUtil.secondaryColor,
                          onTap: () {},
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
