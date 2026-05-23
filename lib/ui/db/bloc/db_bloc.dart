import 'dart:async';

import 'package:controlelectoral/data/helper/sqlhelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'db_event.dart';
part 'db_state.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  DbBloc() : super(DbState()) {
    on<DBInitialStatusEvent>(_onDBInitialStatusEvent);
    on<DBShutdownEvent>(_onDBShutdownEvent);
  }

  Future<void> _onDBInitialStatusEvent(
    DBInitialStatusEvent event,
    Emitter<DbState> emit,
  ) async {
    await SQLiteHelper().initDB();
    await SQLiteHelper().insertInitialData();
    emit(state.copyWith(isDB: true));
  }

  FutureOr<void> _onDBShutdownEvent(
    DBShutdownEvent event,
    Emitter<DbState> emit,
  ) {
    emit(state.copyWith(isDB: false));
  }
}
