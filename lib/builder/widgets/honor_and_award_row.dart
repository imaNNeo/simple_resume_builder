part of '../resume_generator.dart';

class HonorAndAwardRow extends pw.StatelessWidget {
  final HonorAndAward honor;
  final int index;

  HonorAndAwardRow({
    required this.honor,
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
          pw.SizedBox(width: _logoSize + _logoMarginRight),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 1.5),
                pw.Text(
                  honor.title,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  honor.date,
                  style: _longContentStyle,
                ),
                if (honor.info.isNotEmpty) ...[
                  pw.SizedBox(height: 3),
                  pw.Text(
                    honor.info,
                    style: _longContentStyle,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
