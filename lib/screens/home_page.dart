import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:utrex_healthcare_task/utilities/resume.dart';
import 'package:utrex_healthcare_task/utilities/custom_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  Uint8List? pdfBytes;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final bytes = await generateResume(PdfPageFormat.a4);
      if (mounted) {
        setState(() {
          pdfBytes = bytes;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to generate PDF: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resume'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pdfBytes == null
              ? const Center(
                  child: Text('Failed to load PDF'),
                )
              : PdfPreview(
                  build: (format) => pdfBytes!,
                  initialPageFormat: PdfPageFormat.a4,
                  scrollViewDecoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  allowPrinting: true,
                  allowSharing: true,
                  canChangePageFormat: true,
                ),
    );
  }
}
