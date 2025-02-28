import 'package:flutter/material.dart';
import 'package:testapp/const.dart';
import 'package:testapp/services/alert_service.dart';
import 'package:testapp/services/auth_service.dart';
import 'package:testapp/services/navigation_service.dart';
import 'package:testapp/widgets/custom_form_field.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;

  String? email, password;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt<NavigationService>();
    _alertService = _getIt<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [
            _headerText(),
            _loginForm(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Welcome Back!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "Hello again, you've been missed",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ]),
    );
  }

  Widget _loginForm() {
    return Container(
        height: MediaQuery.sizeOf(context).height * 0.4,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.05,
        ),
        child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomFormField(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  hintText: 'Email',
                  validationRegEx: EMAIL_VALIDATION_REGEX,
                  onSaved: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                CustomFormField(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  hintText: 'Password',
                  validationRegEx: PASSWORD_VALIDATION_REGEX,
                  obscureTex: true,
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                _loginButton(),
                _createAccountLink(),
              ],
            )));
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await _authService.login(email!, password!);
            if (result) {
              // Navigate to home page
              _navigationService.pushReplacementNamed("/home");
            } else {
              // Show error message
              _alertService.showToast(
                text: "FAILED TO LOGIN, PLEASE TRY AGAIN!",
                icon: Icons.error,
              );
            }
          }
        },
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _createAccountLink() {
    return Expanded(
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            GestureDetector(
              onTap: () => {
                _navigationService.pushNamed("/register"),
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ]),
    );
  }
}
