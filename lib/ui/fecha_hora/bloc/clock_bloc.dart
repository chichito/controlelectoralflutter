import 'package:flutter_bloc/flutter_bloc.dart';

part 'clock_event.dart';
part 'clock_state.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  ClockBloc() : super(ClockState(DateTime.now())) {
    on<StartClock>((event, emit) async {
      await emit.forEach<DateTime>(
        Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),

        onData: (dateTime) {
          return ClockState(dateTime);
        },
      );
    });
  }
}
