import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_garda_medica/presentation/home_screen.dart';
import 'package:tes_garda_medica/state/cubit/home_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          backgroundColor: Colors.white54,
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          accentColor: Colors.tealAccent,
          disabledColor: Colors.white54),
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => HomeCubit()..showListData()),
      ], child: HomeScreen()),
    );
  }
}
