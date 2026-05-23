part of 'db_bloc.dart';

class DbState {
  DbState({this.isDB = false});

  final bool isDB;

  bool get isAllEnable => isDB;

  DbState copyWith({bool? isDB}) {
    return DbState(isDB: isDB ?? this.isDB);
  }
}
