part of '../resume_generator.dart';

class CommunityRow extends pw.StatelessWidget {
  final CommunityAndOpenSourceItem item;
  final int index;

  CommunityRow({
    required this.item,
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
          item.logo.isEmpty
              ? pw.Container(
                  width: _logoSize,
                  height: _logoSize,
                )
              : pw.Image(
                  pw.MemoryImage(
                    _loadedImages[item.logo]!,
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
                  item.title,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                if (item.link != null && item.link!.isNotEmpty) ...[
                  pw.SizedBox(height: 2),
                  pw.Text(item.link!),
                ],
                pw.SizedBox(height: 3),
                pw.Text(
                  'Since ${item.since}',
                  style: _longContentStyle,
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  item.summary,
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
