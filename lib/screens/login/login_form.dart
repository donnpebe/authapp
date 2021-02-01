import 'package:authapp/blocs/login_form_bloc/login_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../register/register_screen.dart';
import '../../widgets/gradient_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Login Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Logging in...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      child: BlocBuilder<LoginFormBloc, LoginFormState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.always,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isEmailValid ? 'Invalid Email' : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "Password",
                  ),
                  obscureText: true,
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20,
                ),
                GradientButton(
                  width: 150,
                  height: 45,
                  onPressed: () {
                    if (_isButtonEnabled(state)) {
                      _onFormSubmitted();
                    }
                  },
                  text: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GradientButton(
                  width: 150,
                  height: 45,
                  onPressed: () {
                    Navigator.of(context).push<void>(RegisterScreen.route());
                  },
                  text: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPopulated() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  bool _isButtonEnabled(LoginFormState state) {
    return state.isFormValid && _isPopulated() && !state.isSubmitting;
  }

  void _onEmailChange() {
    context.read<LoginFormBloc>().add(LoginEmailChanged(
          email: _emailController.text,
        ));
  }

  void _onFormSubmitted() {
    context.read<LoginFormBloc>().add(LoginWithCredentialsPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ));
  }
}
