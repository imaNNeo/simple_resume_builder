import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../models/resume_data.dart';
import 'widgets/start_end_text.dart';

part 'widgets/work_experience_row.dart';

part 'widgets/section.dart';

part 'widgets/education_history_row.dart';

part 'widgets/honor_and_award_row.dart';

part 'widgets/community_row.dart';

const _logoSize = 20.0;
const _logoMarginRight = 6.0;
final _loadedImages = <String, Uint8List>{};
const _longContentStyle = pw.TextStyle(
  fontSize: 10,
  lineSpacing: 3,
);

class ResumeGenerator {
  static Future<Uint8List> generate(ResumeData data) async {
    final theme = pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
      italic: pw.Font.helveticaOblique(),
      boldItalic: pw.Font.helveticaBoldOblique(),
    );
    final pdf = pw.Document(
      theme: theme,
      title: '${data.fullName} Resume',
      author: data.fullName,
      creator: data.fullName,
      producer: data.fullName,
    );

    final linkColor = PdfColor.fromHex('#3171AC');
    const sectionSpace = 20.0;

    for (final experience in data.experience) {
      if (experience.companyLogo == null) {
        continue;
      }
      // Response response = await get(Uri.parse(experience.companyLogo!));
      Response response = await get(Uri.parse('https://fastly.picsum.photos/id/93/200/200.jpg?hmac=zg_Gq7olpOr79tOB65nmsvLWAIR_Ju8QQWkTKurbgJs'));
      _loadedImages[experience.companyLogo!] = response.bodyBytes;
    }
    for (final education in data.education) {
      if (education.schoolLogo == null) {
        continue;
      }
      // Response response = await get(Uri.parse(education.schoolLogo!));
      Response response = await get(Uri.parse('https://fastly.picsum.photos/id/93/200/200.jpg?hmac=zg_Gq7olpOr79tOB65nmsvLWAIR_Ju8QQWkTKurbgJs'));
      _loadedImages[education.schoolLogo!] = response.bodyBytes;
    }
    for (final item in data.communityAndOpenSource) {
      if (item.logo.isEmpty) {
        continue;
      }
      // Response response = await get(Uri.parse(item.logo));
      Response response = await get(Uri.parse('https://fastly.picsum.photos/id/93/200/200.jpg?hmac=zg_Gq7olpOr79tOB65nmsvLWAIR_Ju8QQWkTKurbgJs'));
      _loadedImages[item.logo] = response.bodyBytes;
    }
    pdf.addPage(
      pw.MultiPage(
        footer: (pw.Context context) {
          if (context.pagesCount <= 1) {
            return pw.Container();
          }
          return pw.Center(
            child: pw.Text(
              '${data.fullName} - Page ${context.pageNumber} / ${context.pagesCount}',
              style: _longContentStyle.copyWith(
                color: PdfColor.fromHex('#727272'),
              ),
            ),
          );
        },
        margin: const pw.EdgeInsets.only(
          left: 44,
          right: 58,
          top: 42,
          bottom: 42,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.SizedBox(height: 14),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  data.fullName,
                  style: const pw.TextStyle(fontSize: 23),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  data.location,
                  style: const pw.TextStyle(fontSize: 10),
                ),
                pw.SizedBox(height: 12),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 0),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        data.email,
                        style: const pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        children: [
                          pw.Text(
                            data.github,
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: linkColor,
                            ),
                          ),
                          pw.SizedBox(width: 24),
                          pw.Text(
                            data.linkedIn,
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: linkColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: sectionSpace),
            Section(
              title: 'Summary',
              children: [
                pw.Text(
                  data.summary,
                  style: _longContentStyle,
                ),
              ],
            ),
            pw.SizedBox(height: sectionSpace),
            Section(
              title: 'Experience',
              children: data.experience.asMap().entries.map((e) {
                final index = e.key;
                final experience = e.value;
                return WorkExperienceRow(
                  experience: experience,
                  index: index,
                );
              }).toList(),
            ),
            ...List.generate(
              2,
              (index) => pw.SizedBox(height: sectionSpace),
            ).toList(),
            Section(
              title: 'Education',
              children: data.education.asMap().entries.map((e) {
                final index = e.key;
                final education = e.value;
                return EducationHistoryRow(
                  education: education,
                  index: index,
                );
              }).toList(),
            ),
            ...List.generate(
              2,
              (index) => pw.SizedBox(height: sectionSpace),
            ).toList(),
            Section(
              title: 'Community & Open Source',
              children: data.communityAndOpenSource.asMap().entries.map((e) {
                final index = e.key;
                final item = e.value;
                return CommunityRow(
                  item: item,
                  index: index,
                );
              }).toList(),
            ),
            ...List.generate(
              5,
              (index) => pw.SizedBox(height: sectionSpace),
            ).toList(),
            Section(
              title: 'Honor & Awards',
              children: data.honorsAndAwards.asMap().entries.map((e) {
                final index = e.key;
                final honor = e.value;
                return HonorAndAwardRow(
                  honor: honor,
                  index: index,
                );
              }).toList(),
            ),
            pw.SizedBox(height: sectionSpace),
            Section(
              title: 'Skills',
              children: [
                pw.SizedBox(height: 2),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                      left: _logoSize + _logoMarginRight),
                  child: pw.Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: data.skills
                        .map(
                          (e) => pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.grey200,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: pw.Text(
                              e,
                              style: const pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    ); // Page

    return pdf.save();
  }
}
