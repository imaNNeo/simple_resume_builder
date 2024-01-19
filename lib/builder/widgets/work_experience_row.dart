part of '../resume_generator.dart';

class WorkExperienceRow extends pw.StatelessWidget {
  final WorkExperience experience;

  final int index;

  WorkExperienceRow({
    required this.experience,
    required this.index,
  });

  @override
  pw.Widget build(pw.Context context) {
    final isFirst = index == 0;
    return pw.Padding(
      padding: pw.EdgeInsets.only(top: isFirst ? 2 : 14),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          experience.companyLogo == null
              ? pw.Container(
                  width: _logoSize,
                  height: _logoSize,
                )
              : pw.Image(
                  pw.MemoryImage(
                    _loadedImages[experience.companyLogo!]!,
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
                  experience.position,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(experience.company),
                pw.SizedBox(height: 3),
                StartEndText(
                  start: experience.startDate,
                  end: experience.endDate,
                  textStyle: _longContentStyle,
                ),
                pw.SizedBox(height: 3),
                ...experience.summary.map(
                  (e) => pw.Bullet(
                    text: e,
                    bulletSize: 1 * PdfPageFormat.mm,
                    bulletMargin: const pw.EdgeInsets.only(
                      top: 1.7 * PdfPageFormat.mm,
                      right: 0.8 * PdfPageFormat.mm,
                    ),
                    style: _longContentStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
