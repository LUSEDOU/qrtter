part of 'generator_bloc.dart';

@immutable
abstract class GeneratorEvent extends Equatable {
  const GeneratorEvent();
}

class GeneratorQrChanged extends GeneratorEvent {
  const GeneratorQrChanged({required this.qrText});

  final String qrText;

  @override
  List<Object> get props => [qrText];
}

class GeneratorQrFailed extends GeneratorEvent {
  const GeneratorQrFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}

class GeneratorReset extends GeneratorEvent {
  const GeneratorReset();

  @override
  List<Object> get props => [];
}

class GeneratorQrSubmit extends GeneratorEvent {
  const GeneratorQrSubmit();

  @override
  List<Object> get props => [];
}
