import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makemeadrink/app.dart';
import 'package:makemeadrink/simple_bloc_observer.dart'; 
import 'package:user_repository/user_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
 runApp(MyApp(FirebaseUserRepo()));
}


