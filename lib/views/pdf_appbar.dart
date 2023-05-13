import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:simple_pdf_viewer/controller/simple_pdf_controller.dart';

class PdfAppBar extends StatelessWidget {
  PdfAppBar({super.key});
  final controller = Get.find<SimplePdfController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: controller.isShowSearch.value,
        replacement: AppBar(
          // leading: IconButton(
          //   onPressed: () => Navigator.pop(context),
          //   icon: const Icon(Icons.arrow_back),
          // ),
          title: Text("This is title"),
          actions: [
            IconButton(
              onPressed: () => controller.showHideSearchText(),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Option 1"),
                  ),
                ];
              },
            ),
          ],
        ),
        child: AppBar(
          title: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            onChanged: controller.searchText,
          ),
          leading: IconButton(
            onPressed: () => controller.showHideSearchText(),
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  controller.pdfTextSearchResult.previousInstance(),
              icon: Icon(Icons.arrow_left),
            ),
            Center(
              child: Obx(() {
                return Text(
                  "${controller.textSearchCurrentIndex} of ${controller.textSearchCount}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                );
              }),
            ),
            IconButton(
              onPressed: () => controller.pdfTextSearchResult.nextInstance(),
              icon: Icon(Icons.arrow_right),
            ),
          ],
        ),
      );
    });
  }
}
