import 'package:flutter/material.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginPasswordVisibility extends LoginState {}

class UserLoginStateSuccess extends LoginState {}

class SignUpStateSuccess extends LoginState {}
