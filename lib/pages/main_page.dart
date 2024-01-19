import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_resume_builder/cubit/app_cubit.dart';
import 'package:simple_resume_builder/extensions/string_extensions.dart';
import 'package:simple_resume_builder/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';
import 'package:pdfx/pdfx.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PdfControllerPinch? _controller;
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).onPageOpened();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state.error.isNotNullOrBlank) {
          toastification.show(
            context: context,
            title: Text(state.error!),
            type: ToastificationType.warning,
            alignment: Alignment.topCenter,
          );
        }
        if (state.pdfBytes != null) {
          _controller = PdfControllerPinch(
            document: PdfDocument.openData(state.pdfBytes!),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: _controller != null
                      ? PdfViewPinch(
                          controller: _controller!,
                          scrollDirection: Axis.vertical,
                          padding: 8,
                        )
                      : Container(),
                ),
              ],
            ),
            if (state.isLoading) const LoadingOverlay(),
          ],
        );
      },
    );
  }
}
