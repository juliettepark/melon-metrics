import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  int get sleep {return 7;}
  int get calories {return 120;}
  int get steps {return 1000;}
}