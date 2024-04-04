import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_resume_builder/builder/resume_generator.dart';
import 'package:simple_resume_builder/models/resume_data.dart';
import 'package:simple_resume_builder/models/value_wrapper.dart';
import 'package:universal_html/html.dart' as html;

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void generatePdf(AssetBundle bundle, String jsonData) async {
    emit(state.copyWith(isLoading: true));
    try {
      final resumeData = ResumeData.fromJson(jsonDecode(jsonData));
      final resumePdfBytes = await ResumeGenerator.generate(bundle, resumeData);
      _downloadContentAsFileInWeb(
        fileName: 'resume.pdf',
        bytes: resumePdfBytes,
      );
      emit(state.copyWith(
        isLoading: false,
        resumeData: ValueWrapper(resumeData),
      ));
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      emit(state.copyWith(isLoading: false, error: e.toString()));
      emit(state.copyWith(error: ''));
    }
  }

  void _downloadContentAsFileInWeb({
    required String fileName,
    Uint8List? bytes,
  }) {
    if (bytes != null) {
      // prepare
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = fileName;
      html.document.body?.children.add(anchor);

      // download
      anchor.click();

      // cleanup
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    }
  }
}
