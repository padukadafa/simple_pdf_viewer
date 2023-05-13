import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:simple_pdf_viewer/controller/simple_pdf_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FloatingBottomMenu extends StatelessWidget {
  FloatingBottomMenu({super.key});
  final controller = Get.find<SimplePdfController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          return Visibility(
            visible: controller.isShowZoomSlider.value,
            child: Row(
              children: [
                Expanded(
                  child: Slider(
                    mouseCursor: MouseCursor.defer,
                    value: controller.zoomLevel.value,
                    max: 300,
                    min: 100,
                    divisions: 25,
                    onChanged: controller.zoomTo,
                  ),
                ),
                Text("${controller.zoomLevel.value.floor()}%"),
              ],
            ),
          );
        }),
        Container(
          height: 55,
          margin: const EdgeInsets.all(8.0),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  if (controller.pdfLayoutMode.value ==
                      PdfPageLayoutMode.continuous) {
                    controller.pdfLayoutMode.value = PdfPageLayoutMode.single;
                  } else {
                    controller.pdfLayoutMode.value =
                        PdfPageLayoutMode.continuous;
                  }
                },
                icon: const Icon(
                  Icons.view_carousel,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => controller.showHideZoom(),
                icon: const Icon(
                  Icons.zoom_in,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.text_fields,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => controller.previousPage(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.showSearchPage(),
                    child: Obx(() {
                      return Text(
                        "${controller.currentPage.value} of ${controller.pdfController.pageCount}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                    }),
                  ),
                  IconButton(
                    onPressed: () => controller.nextPage(),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  controller.isShowBottomMenu.value = false;
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
