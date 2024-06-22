import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_budget_managemet/app_view.dart';
import 'package:user_repository/user_repository.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';

class MyAppScreen extends StatelessWidget {
  final UserRepository userRepository;
  const MyAppScreen(this.userRepository, {super.key});


  @override
  Widget build(BuildContext context) {
    return  RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository
        ),
        child:const  MyAppView(),
    );
    
  }
}