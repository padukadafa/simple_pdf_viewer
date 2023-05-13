library simple_pdf_viewer;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simple_pdf_viewer/views/pdf_appbar.dart';
import 'package:simple_pdf_viewer/controller/simple_pdf_controller.dart';
import 'package:simple_pdf_viewer/views/floating_bottom_menu.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// A Calculator.
class SPdfViewer extends StatelessWidget {
  SPdfViewer({super.key});
  final controller = Get.put(SimplePdfController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PdfAppBar(),
        Expanded(
          child: Stack(
            children: [
              Center(
                child: Obx(() {
                  return SfPdfViewer.network(
                    'https://www.africau.edu/images/default/sample.pdf',
                    controller: controller.pdfController,
                    enableDoubleTapZooming: true,
                    pageLayoutMode: controller.pdfLayoutMode.value,
                    maxZoomLevel: 300,
                    canShowScrollHead: false,
                    onPageChanged: (val) {
                      controller.currentPage.value = val.newPageNumber;
                    },
                    onZoomLevelChanged: (val) {
                      controller.zoomLevel.value = val.newZoomLevel * 100;
                    },
                  );
                }),
              ),
              Obx(() {
                return Align(
                  alignment: (controller.isShowBottomMenu.value)
                      ? Alignment.bottomCenter
                      : Alignment.bottomRight,
                  child: Visibility(
                    visible: controller.isShowBottomMenu.value,
                    child: FloatingBottomMenu(),
                    replacement: Container(
                      margin: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          controller.isShowBottomMenu.value = true;
                        },
                        child: Icon(Icons.menu_open),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
