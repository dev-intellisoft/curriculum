import 'dart:async';
import 'dart:typed_data';

import 'package:curriculum/core/classes/resume.dart';
import 'package:pdf/pdf.dart';
import 'resume.dart';

const samples = <Sample>[
  Sample('RÉSUMÉ', 'resume.dart', generateResume, true),
];

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, Resume? data);

class Sample {
  const Sample(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}
