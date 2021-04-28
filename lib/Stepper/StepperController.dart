import 'package:flutter/material.dart';

typedef FunctionThatReturned(int value);

class StepperController {
  VoidCallback next;
  VoidCallback prev;
  FunctionThatReturned setPage;

  void dispose() {
    next = null;
    prev = null;
    setPage = null;
  }
}