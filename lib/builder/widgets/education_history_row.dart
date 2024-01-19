part of '../resume_generator.dart';

class EducationHistoryRow extends pw.StatelessWidget {
  final EducationHistory education;

  final int index;

  EducationHistoryRow({
    required this.education,
    required this.index,
  });

  @override
  pw.Widget build(pw.Context context) {
    final isFirst = index == 0;
    return pw.Padding(
      padding: pw.EdgeInsets.only(top: isFirst ? 2 : 16),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          education.schoolLogo == null
              ? pw.Container(
                  width: _logoSize,
                  height: _logoSize,
                )
              : pw.Image(
                  pw.MemoryImage(
                    _loadedImages[education.schoolLogo!]!,
                  ),
                  width: _logoSize,
                  height: _logoSize,
                ),
          pw.SizedBox(width: _logoMarginRight),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 1.5),
                pw.Text(
                  education.schoolName,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text('${education.degree}, ${education.field}'),
                pw.SizedBox(height: 3),
                pw.Text(
                  '${education.startDate} - ${education.endDate}',
                  style: _longContentStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
