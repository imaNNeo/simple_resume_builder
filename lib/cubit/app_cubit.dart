import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_resume_builder/builder/resume_generator.dart';
import 'package:simple_resume_builder/models/resume_data.dart';
import 'package:simple_resume_builder/models/value_wrapper.dart';
import 'package:flutter/services.dart' show rootBundle;
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void onPageOpened() async {
    emit(state.copyWith(isLoading: true));
    try {
      final dataStr = await rootBundle.loadString('assets/data.json');
      final resumeData = ResumeData.fromJson(jsonDecode(dataStr));
      final resumePdfBytes = await ResumeGenerator.generate(resumeData);
      emit(state.copyWith(
        isLoading: false,
        resumeData: ValueWrapper(resumeData),
        pdfBytes: ValueWrapper(resumePdfBytes),
      ));
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      emit(state.copyWith(isLoading: false, error: e.toString()));
      emit(state.copyWith(error: ''));
    }
  }
}
