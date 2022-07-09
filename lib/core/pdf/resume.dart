import 'dart:async';
import 'dart:typed_data';

import 'package:curriculum/core/classes/education.dart';
import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/classes/resume.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume(PdfPageFormat format, Resume? resume) async {

  final doc = pw.Document(title: 'openCV Builder', author: 'Wellington Cunha');

  final pageTheme = await _myPageTheme(format);

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
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text('${resume!.firstName} ${resume.lastName}',
                            textScaleFactor: 2,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),

                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[

                                if( resume.experiences.isNotEmpty )
                                  pw.Text('${resume.experiences[0].title}',
                                      textScaleFactor: 1.2,
                                      style: pw.Theme.of(context)
                                          .defaultTextStyle
                                          .copyWith(
                                          fontWeight: pw.FontWeight.bold,
                                          color: green)),

                                pw.Text('${resume.location}'),
                                // pw.Text('Nordegg, AB T0M 2H0'),
                                // pw.Text('Canada, ON'),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('${resume.telephone}'),
                                _UrlText('${resume.email}',
                                    'mailto:${resume.email}'),
                                _UrlText(
                                    '${resume.linkedIn}', '${resume.linkedIn}'),
                                _UrlText(
                                    '${resume.github}', '${resume.github}'),
                              ],
                            ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                        if ( resume.experiences.isNotEmpty )
                          _Category(title: 'Work Experience'),
                          pw.ListView.builder(
                              itemBuilder: (context, index) {
                                return _Experience(
                                    experience: resume.experiences[index],);
                              },
                              itemCount: resume.experiences.length
                          ),

                        if ( resume.educations.isNotEmpty )
                          _Category(title: 'Education'),
                          pw.ListView.builder(
                            itemBuilder: (context, index) {
                              return _Education(education:resume.educations[index] );
                            },
                            itemCount: resume.educations.length
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return await doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  format = format.applyMargin(
      left: .5 * PdfPageFormat.cm,
      top: 1.0 * PdfPageFormat.cm,
      right: .5 * PdfPageFormat.cm,
      bottom: 1.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );
}


class _Education extends pw.StatelessWidget {
  _Education({
    required this.education,
  });

  Education education;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  margin: const pw.EdgeInsets.only(right: 15),
                    child: pw.Text(
                        '${
                            education.start == null? '':DateFormat('MMM yyyy').format(education.start!)
                        } - ${
                            education.end == null?'':DateFormat('MMM yyyy').format(education.end!)
                        }')
                ),
                pw.Text('${education.course} at ${education.institution}',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text('${education.description}'),
                ]),
          ),
        ]);
  }
}

class _Experience extends pw.StatelessWidget {
  Experience experience;
  _Experience({
    required this.experience,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(

                  height: 6,
                  margin: const pw.EdgeInsets.only( right: 20),
                  child: pw.Text(
                      '${
                          experience.start == null? '':DateFormat('MMM yyyy').format(experience.start!)
                      } - ${
                          experience.end == null?'':DateFormat('MMM yyyy').format(experience.end!)
                      }')
                ),
                pw.Text('${experience.title} at ${experience.company}',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(experience.description!),
                ]),
          ),
        ]);
  }
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
        title.toUpperCase(),
        textScaleFactor: 1.5,
      ),
    );
  }
}
//
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
//
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
