import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_task_app/controllers/app_controller.dart';

class SelectScreen extends StatelessWidget {
  SelectScreen({Key? key, required this.initialIndex}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final AppController _controller = Get.find<AppController>();
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                initialValue: initialIndex.toString(),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onSaved: (value) {
                  var intValue = int.parse(value!);
                  _controller.selectBlock(intValue);
                  Get.back();
                },
                validator: (value) {
                  var intValue = int.tryParse(value ?? '');
                  return intValue != null &&
                          intValue < _controller.blocks.length
                      ? null
                      : 'Not valid value';
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
