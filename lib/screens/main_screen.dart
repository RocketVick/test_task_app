import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:test_task_app/config.dart';
import 'package:test_task_app/controllers/app_controller.dart';
import 'package:test_task_app/models/smart_block.dart';
import 'package:test_task_app/screens/select_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final AppController _controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height / 1.5,
        maxHeight: MediaQuery.of(context).size.height,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        onPanelSlide: (slide) {
          print('slide=$slide and previous=${_controller.panelPosition.value}');
          if (slide == 1 && _controller.panelPosition.value < 0.9999) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Panel Opened')));
          }
          _controller.updatePanelPosition(slide);
        },
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -size / 2.3,
              left: -size / 2.3,
              child: Obx(() => AnimatedRotation(
                    turns: _controller.panelPosition / 5,
                    duration: const Duration(milliseconds: 100),
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: SvgPicture.asset(
                        'assets/circle.svg',
                      ),
                    ),
                  )),
            )
          ],
        ),
        panel: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [stub(), stub(), stub()],
            ).paddingOnly(left: 30),
            SizedBox(
                height: smartBlockSize,
                child: ListView.builder(
                    controller: _controller.horizontalListController,
                    padding: EdgeInsets.only(left: 30),
                    scrollDirection: Axis.horizontal,
                    itemCount: _controller.blocks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        key: ValueKey(index),
                        child: Obx(() => smartBlock(_controller.blocks[index])),
                        onTap: () =>
                            Get.to(() => SelectScreen(initialIndex: index)),
                      );
                    })).paddingOnly(top: 10)
          ],
        ).paddingOnly(top: 30),
      ),
    );
  }

  Widget stub() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 50,
        width: (300 - Random().nextInt(100)).toDouble(),
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    );
  }

  Widget smartBlock(SmartBlock block) {
    return Padding(
      padding: EdgeInsets.only(right: smartBlockInterval),
      child: Container(
        height: smartBlockSize,
        width: smartBlockSize,
        child: Center(
          child: Text(block.id.toString()),
        ),
        decoration: BoxDecoration(
            color: block.isSelected ? Colors.purpleAccent : Colors.grey[400],
            borderRadius: const BorderRadius.all(Radius.circular(30))),
      ),
    );
  }
}
