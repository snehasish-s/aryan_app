import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;
  final String title;

  const PdfViewerPage({super.key, required this.pdfPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.green),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}
