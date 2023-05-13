import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SimplePdfController extends GetxController {
  final isShowZoomSlider = false.obs;
  final zoomLevel = 100.0.obs;
  final pdfController = PdfViewerController();
  final currentPage = 1.obs;
  final isShowSearch = false.obs;
  final isShowBottomMenu = true.obs;
  final toPageController = TextEditingController();
  Rx<PdfPageLayoutMode> pdfLayoutMode = Rx(PdfPageLayoutMode.continuous);
  PdfTextSearchResult pdfTextSearchResult = PdfTextSearchResult();
  final textSearchCount = 0.obs;
  final textSearchCurrentIndex = 0.obs;

  showHideZoom() {
    isShowZoomSlider.value = !isShowZoomSlider.value;
  }

  zoomTo(double val) {
    pdfController.zoomLevel = val / 100;
    zoomLevel.value = val;
  }

  nextPage() {
    pdfController.nextPage();
    currentPage.value = pdfController.pageNumber;
  }

  previousPage() {
    pdfController.previousPage();
    currentPage.value = pdfController.pageNumber;
  }

  showSearchPage() async {
    toPageController.text = "";
    await Get.defaultDialog(
      title: "Go to page",
      content: Container(
        margin: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: toPageController,
          validator: (value) {
            if (!GetUtils.isLengthLessThan(value, pdfController.pageCount)) {
              return "Cannot more than ${pdfController.pageCount}";
            }
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "0",
            suffix: Text("of ${pdfController.pageCount}"),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
          ),
          onChanged: (val) {
            if (int.parse(val) > pdfController.pageCount) {
              toPageController.text = pdfController.pageCount.toString();
            }
          },
        ),
      ),
      textConfirm: "Go",
      confirmTextColor: Colors.white,
      onConfirm: () {
        pdfController.jumpToPage(int.parse(toPageController.text));

        Get.back();
      },
    );
  }

  showHideSearchText() {
    isShowSearch.value = !isShowSearch.value;
    pdfTextSearchResult.clear();
  }

  searchText(val) {
    pdfTextSearchResult = pdfController.searchText(val);
    pdfTextSearchResult.addListener(() {
      if (pdfTextSearchResult.hasResult) {
        textSearchCount.value = pdfTextSearchResult.totalInstanceCount;
        textSearchCurrentIndex.value = pdfTextSearchResult.currentInstanceIndex;
      }
    });
  }
}
