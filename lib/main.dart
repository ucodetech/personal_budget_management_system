import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_budget_managemet/app.dart';
import 'package:user_repository/user_repository.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBk0A1DUqlutEIQ7LQUoj1FDwJG9yciw30', // paste your api key here
      appId: '1:847211822277:android:49a9c9b008cfd54dd704ac', //paste your app id here
      messagingSenderId: '847211822277', //paste your messagingSenderId here
      projectId: 'expense-tracker-47240',
      storageBucket: "expense-tracker-47240.appspot.com", //paste your project id here
    ),
  );
  Bloc.observer = SimpleBlocObserver();

  runApp(MyAppScreen(FirebaseUserRepo()));
}


