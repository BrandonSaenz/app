import 'package:app/src/pages/muscular_groups.dart';
import 'package:app/src/pages/users.dart';
import 'package:app/src/pages/rutinas.dart';
import 'package:flutter/material.dart';

class LocalData {
  static const List<String> list_menu = ['GRUPOS MUSCULARES', 'USUARIOS'];
  static const List<Widget> widget = [MuscularPage(), UsersPage()];
}
