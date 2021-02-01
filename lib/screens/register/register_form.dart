import 'package:authapp/blocs/register_form_bloc/register_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/gradient_button.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterFormState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterFormBloc, RegisterFormState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Register Failure'),
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
                    Text('Registering...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
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
      child: BlocBuilder<RegisterFormBloc, RegisterFormState>(
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
                autovalidateMode: AutovalidateMode.always,
                autocorrect: false,
                validator: (_) {
                  return !state.isPasswordValid ? 'Invalid Password' : null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              GradientButton(
                width: 150,
                height: 45,
                onPressed: () {
                  if (isButtonEnabled(state)) {
                    _onFormSubmitted();
                  }
                },
                text: Text(
                  'Register',
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
            ],
          ),
        );
      }),
    );
  }

  void _onFormSubmitted() {
    context.read<RegisterFormBloc>().add(RegisterFormSubmitted(
          email: _emailController.text,
          password: _passwordController.text,
        ));
  }

  void _onEmailChange() {
    context
        .read<RegisterFormBloc>()
        .add(RegisterFormEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    context
        .read<RegisterFormBloc>()
        .add(RegisterFormPasswordChanged(password: _passwordController.text));
  }
}
