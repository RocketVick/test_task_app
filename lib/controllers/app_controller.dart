import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_task_app/config.dart';
import 'package:test_task_app/models/smart_block.dart';

class AppController extends GetxController {
  final horizontalListController = ScrollController();
  var panelPosition = Rx<double>(0);
  final RxList<SmartBlock> blocks = List.generate(smartBlockCount, (index) {
    return SmartBlock(index);
  }).obs;

  void updatePanelPosition(double position) {
    panelPosition.value = position;
  }

  void _scrollToElement(int index) {
    horizontalListController.animateTo(
        index * (smartBlockSize + smartBlockInterval),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn);
  }

  void selectBlock(int index) {
    for (var element in blocks) {
      element.id == index
          ? element.isSelected = true
          : element.isSelected = false;
    }
    blocks.refresh();
    _scrollToElement(index);
  }

  @override
  void dispose() {
    horizontalListController.dispose();
    super.dispose();
  }
}
