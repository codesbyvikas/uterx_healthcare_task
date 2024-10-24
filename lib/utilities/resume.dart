import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:utrex_healthcare_task/utilities/custom_data.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume(PdfPageFormat format) async {
  final doc = pw.Document(title: 'Vikas Kewat - Resume', author: 'Vikas Kewat');

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/profile.jpeg')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(format);
  final data = CustomData.instance;

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Text(
                              data.name,
                              textScaleFactor: 2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Padding(
                                padding: const pw.EdgeInsets.only(top: 10)),
                            pw.Text(
                              data.jobTitle,
                              textScaleFactor: 1.2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                      fontWeight: pw.FontWeight.bold,
                                      color: green),
                            ),
                          ],
                        ),
                        pw.Container(
                          width: 60,
                          height: 60,
                          decoration: pw.BoxDecoration(
                            shape: pw.BoxShape.circle,
                            image: pw.DecorationImage(
                              image: profileImage,
                              fit: pw.BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text(data.location),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text(data.phone),
                          _UrlText(data.email, 'mailto:${data.email}'),
                          _UrlText(data.linkedIn, data.linkedIn),
                          _UrlText(data.github, data.github),
                        ],
                      ),
                      pw.Padding(padding: pw.EdgeInsets.zero)
                    ],
                  ),
                  _Category(title: 'Objective'),
                  pw.Text(data.objective),
                  _Category(title: 'Education'),
                  ...data.education.map((e) => _Block(
                        title: e.institution,
                        icon: const pw.IconData(0xe56c),
                        description: e.degree,
                        isEducation: true,
                      )),
                  _Category(title: 'Technical Skills'),
                  pw.Container(
                    padding: const pw.EdgeInsets.only(top: 10, bottom: 10),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: data.skills
                          .map((skill) => pw.Padding(
                                padding:
                                    const pw.EdgeInsets.symmetric(vertical: 3),
                                child: pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      width: 6,
                                      height: 6,
                                      margin: const pw.EdgeInsets.only(
                                          top: 5.5, left: 2, right: 5),
                                      decoration: const pw.BoxDecoration(
                                        color: green,
                                        shape: pw.BoxShape.circle,
                                      ),
                                    ),
                                    pw.Expanded(
                                      child: pw.Text(
                                        skill,
                                        style: pw.Theme.of(context)
                                            .defaultTextStyle
                                            .copyWith(
                                              fontSize: 11,
                                            ),
                                      ),
                                    ),
                                    pw.Icon(
                                      const pw.IconData(0xe5dc),
                                      color: lightGreen,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  _Category(title: 'Experience'),
                  ...data.experience.map((exp) => _Block(
                        title: exp.title,
                        description: exp.description,
                        icon: const pw.IconData(0xe8f9),
                      )),
                  _Category(title: 'Projects'),
                  ...data.projects.map((proj) => _Block(
                        title: proj.title,
                        description: proj.description,
                        icon: const pw.IconData(0xe8f4),
                      )),
                  _Category(title: 'Extracurricular Activities'),
                  ...data.extracurricular.map((extra) => _Block(
                        title: extra.title,
                        description: extra.description,
                        icon: const pw.IconData(0xe7ef),
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  return doc.save();
}

class _Block extends pw.StatelessWidget {
  _Block({
    required this.title,
    this.description,
    this.icon,
    this.isEducation = false,
  });

  final String title;
  final String? description;
  final pw.IconData? icon;
  final bool isEducation;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: <pw.Widget>[
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Container(
              width: 6,
              height: 6,
              margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
              decoration: const pw.BoxDecoration(
                color: green,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          title,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: isEducation ? 11 : 12,
                              ),
                        ),
                      ),
                      if (icon != null)
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 5),
                          child: pw.Icon(
                            icon!,
                            color: lightGreen,
                            size: isEducation ? 16 : 18,
                          ),
                        ),
                    ],
                  ),
                  if (description != null && description!.isNotEmpty)
                    pw.Container(
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          left: pw.BorderSide(color: green, width: 2),
                        ),
                      ),
                      padding: const pw.EdgeInsets.only(
                        left: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      margin: const pw.EdgeInsets.only(left: 5, top: 3),
                      child: pw.Text(
                        description!,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontSize: 10,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 8),
      ],
    );
  }
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/resume.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                  angle: pi, child: pw.SvgImage(svg: bgShape)),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}

class _Percent extends pw.StatelessWidget {
  _Percent({
    required this.size,
    required this.value,
    required this.title,
  });

  final double size;

  final double value;

  final pw.Widget title;

  static const fontSize = 1.2;

  PdfColor get color => green;

  static const backgroundColor = PdfColors.grey300;

  static const strokeWidth = 5.0;

  @override
  pw.Widget build(pw.Context context) {
    final widgets = <pw.Widget>[
      pw.Container(
        width: size,
        height: size,
        child: pw.Stack(
          alignment: pw.Alignment.center,
          fit: pw.StackFit.expand,
          children: <pw.Widget>[
            pw.Center(
              child: pw.Text(
                '${(value * 100).round().toInt()}%',
                textScaleFactor: fontSize,
              ),
            ),
            pw.CircularProgressIndicator(
              value: value,
              backgroundColor: backgroundColor,
              color: color,
              strokeWidth: strokeWidth,
            ),
          ],
        ),
      )
    ];

    widgets.add(title);

    return pw.Column(children: widgets);
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}
