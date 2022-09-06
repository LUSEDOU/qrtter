import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrtter/generator/generator.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  Route<dynamic> get route => MaterialPageRoute<void>(
        builder: (context) => this,
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeneratorBloc(),
      child: const GeneratorView(),
    );
  }
}

class GeneratorView extends StatelessWidget {
  const GeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<GeneratorBloc, GeneratorState>(
        listener: (context, state) {
          if (state.status == GeneratorStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Generate QR Code'),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text to generate QR Code',
                ),
                onChanged: (value) => context
                    .read<GeneratorBloc>()
                    .add(GeneratorQrChanged(qrText: value)),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context
                    .read<GeneratorBloc>()
                    .add(const GeneratorQrSubmit()),
                child: const Text('Generate'),
              ),
              const SizedBox(height: 16),
              BlocBuilder<GeneratorBloc, GeneratorState>(
                buildWhen: (previous, current) =>
                    previous.qrCode != current.qrCode &&
                    current.status == GeneratorStatus.success,
                builder: (context, state) {
                  return QrImage(
                    data: state.qrCode ?? '',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
