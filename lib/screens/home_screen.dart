import 'package:authapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:authapp/widgets/avatar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested()),
            ),
          ],
        ),
        body: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Avatar(photo: user.photo),
              const SizedBox(height: 4.0),
              Text(user.email),
              const SizedBox(height: 4.0),
              Text(user.name ?? ''),
            ],
          ),
        ));
  }
}
