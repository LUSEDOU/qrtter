part of 'generator_bloc.dart';

enum GeneratorStatus { initial, success, failure }

class GeneratorState extends Equatable {
  const GeneratorState({
    this.qrCode,
    this.qrText,
    this.status = GeneratorStatus.initial,
  });

  final String? qrText;
  final String? qrCode;
  final GeneratorStatus status;

  @override
  List<Object?> get props => [qrCode, qrText, status];

  GeneratorState copyWith({
    String? qrCode,
    String? qrText,
    GeneratorStatus? status,
  }) {
    return GeneratorState(
      qrCode: qrCode ?? this.qrCode,
      qrText: qrText ?? this.qrText,
      status: status ?? this.status,
    );
  }
}
