import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'generator_event.dart';
part 'generator_state.dart';

const Duration _kDuration = Duration(milliseconds: 300);

EventTransformer<GeneratorQrChanged> _eventTransformer() {
  return (events, mapper) => events
      .debounce(_kDuration)
      .switchMap(mapper)
      .distinct((previous, current) => previous.qrText == current.qrText);
}

class GeneratorBloc extends Bloc<GeneratorEvent, GeneratorState> {
  GeneratorBloc() : super(const GeneratorState()) {
    on<GeneratorQrChanged>(_onQrChanged, transformer: _eventTransformer());
    on<GeneratorQrFailed>(_onQrFailed);
    on<GeneratorQrSubmit>(_onSubmit);
    on<GeneratorReset>(_onReset);
  }

  void _onQrChanged(
    GeneratorQrChanged event,
    Emitter<GeneratorState> emit,
  ) {
    emit(
      state.copyWith(
        qrText: event.qrText,
        status: GeneratorStatus.success,
      ),
    );
  }

  void _onQrFailed(
    GeneratorQrFailed event,
    Emitter<GeneratorState> emit,
  ) {
    emit(
      state.copyWith(
        status: GeneratorStatus.failure,
      ),
    );
  }

  void _onSubmit(
    GeneratorQrSubmit event,
    Emitter<GeneratorState> emit,
  ) {
    emit(
      state.copyWith(
        status: GeneratorStatus.success,
        qrCode: state.qrText,
      ),
    );
  }

  void _onReset(
    GeneratorReset event,
    Emitter<GeneratorState> emit,
  ) {
    emit(GeneratorState(qrText: state.qrText));
  }
}
