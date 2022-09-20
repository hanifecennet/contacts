import 'dart:convert';

import 'package:contacts/models/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'screens/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(
      ),  
    ),
  );
}