import 'package:flutter/material.dart';

//OBS: Since this class' extendor scripts are Notifiers, which are written in the same script as their parent Model, they can't be written here. As such, despite all
//  extendors having a 'selDate' field, it can't be written here because it would need to be made public for them to access it, since Flutter doesn't have an easy way to
//  create protected fields.
abstract class SelDateNotifier extends ChangeNotifier{

  DateTime get selDate;
  set selDate(DateTime newDate);
}