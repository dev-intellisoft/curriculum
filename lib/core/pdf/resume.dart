import 'dart:async';
import 'dart:typed_data';

import 'package:curriculum/core/classes/education.dart';
import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/classes/language.dart';
import 'package:curriculum/core/classes/resume.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';

const sep = 120.0;

Future<Uint8List> generateResume(PdfPageFormat format, Resume? resume) async {
  final doc = pw.Document(title: 'app_name'.tr, author: 'Wellington Cunha');
  final pageTheme = await _myPageTheme(format);

  List<String> keywords = [];

  resume!.experiences.forEach((element) {
    if ( element.keywords != null) {
      List<String> s = element.keywords!.split(', ');
      keywords = keywords..addAll(s);
    }
  });

  if ( keywords.isNotEmpty ) {
    keywords = [...{...keywords}];
  }

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context)  {

        return [
          pw.Wrap(
            children: [
              pw.Text('${resume.firstName} ${resume.lastName}',
                textScaleFactor: 2,
                style: pw.Theme.of(context)
                  .defaultTextStyle
                  .copyWith(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 50),
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
                              fontWeight: pw.FontWeight.bold,)),

                      pw.Text('${resume.location}'),
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
                _Category(title: 'resume.experiences'.tr),
              pw.ListView.builder(
                  itemBuilder: (context, index) {
                    return _Experience(
                      experience: resume.experiences[index],);
                  },
                  itemCount: resume.experiences.length
              ),

              if ( resume.educations.isNotEmpty )
                _Category(title: 'resume.educations'.tr),
                pw.ListView.builder(
                    itemBuilder: (context, index) {
                      return _Education(education:resume.educations[index] );
                    },
                    itemCount: resume.educations.length
                ),

              if ( resume.languages.isNotEmpty )
                _Category(title: 'resume.languages'.tr),
                _Language(languages:resume.languages ),

              if ( keywords.isNotEmpty )
                _Category(title: 'resume.skills'.tr),
                _Keyword(keywords: keywords)

            ]
          ),
        ];
      },
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

class _Keyword extends pw.StatelessWidget {
  _Keyword({
    required this.keywords,
  });

  List<String> keywords;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Wrap(
        runSpacing: 5.0,
        spacing: 5.0,
        children: keywords.map((e) => pw.Container(
          margin: const pw.EdgeInsets.only(right: 10),
          child: pw.Text(e),
          decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(5)
          ),
        )).toList()
    );
  }
}

class _Language extends pw.StatelessWidget {
  _Language({
    required this.languages,
  });

  List<Language> languages;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      children: [
        pw.Row(
          children: languages.map((e) => pw.Container(
            margin: const pw.EdgeInsets.only(right: 10),
            child: pw.Text(e.language!),
            decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(5)
            ),
          )).toList()
        )
      ]
    );
  }
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
                child: pw.Text(''
                    //todo fix this DateFormat
                  // '${
                  //     education.start == null? '':DateFormat('MMM yyyy').format(education.start!)
                  // } - ${
                  //     education.end == null?'':DateFormat('MMM yyyy').format(education.end!)
                  // }'
                )
            ),
            pw.Text('${education.course} at ${education.institution}',
              style: pw.Theme.of(context)
                .defaultTextStyle
                .copyWith(fontWeight: pw.FontWeight.bold)),
            pw.Spacer(),
          ]),
        pw.Container(
          decoration: const pw.BoxDecoration(
            border: pw.Border(left: pw.BorderSide( width: 2))),
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
                ''
                //todo fix this DateFormat
                // '${
                //     experience.start == null? '':DateFormat('MMM yyyy').format(experience.start!)
                // } - ${
                //     experience.end == null?'':DateFormat('MMM yyyy').format(experience.end!)
                // }'
              )
            ),
            pw.Text('${experience.title} at ${experience.company}',
              style: pw.Theme.of(context)
                .defaultTextStyle
                .copyWith(fontWeight: pw.FontWeight.bold)),
          ]),
        pw.Container(
          decoration: const pw.BoxDecoration(
            border: pw.Border(left: pw.BorderSide( width: 2))),
          padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
          margin: const pw.EdgeInsets.only(left: 5),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              if ( experience.description != null )
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
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Text(
        title.toUpperCase(),
        textScaleFactor: 1.5,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold
        )
      ),
    );
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
