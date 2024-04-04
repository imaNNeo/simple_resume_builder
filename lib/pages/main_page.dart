import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_text_field/json_text_field.dart';
import 'package:simple_resume_builder/cubit/app_cubit.dart';
import 'package:simple_resume_builder/extensions/string_extensions.dart';
import 'package:simple_resume_builder/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late JsonTextFieldController _textFieldController;

  @override
  void initState() {
    _textFieldController = JsonTextFieldController();
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
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Enter your json here:'),
                    const SizedBox(height: 8),
                    Expanded(
                      child: JsonTextField(
                        controller: _textFieldController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 80,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            final json = _textFieldController.text.trim();
                            context.read<AppCubit>().generatePdf(
                                  DefaultAssetBundle.of(context),
                                  json,
                                );
                          },
                          child: const Text('Generate PDF'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.isLoading) const LoadingOverlay(),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
