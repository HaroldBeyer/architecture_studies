import 'dart:async';

import 'package:architecture_studies/repository.dart';
import 'package:architecture_studies/user.dart';

class UserBloc {
  UserBloc(this._repository);

  final Repository _repository;

  final _userStreamController = StreamController<UserState>();

  Stream<UserState> get user => _userStreamController.stream;

  void loadUserData() {
    _userStreamController.sink.add(UserState._userLoading());
    _repository.getUser().then((user) {
      _userStreamController.sink.add(UserState._userData(user));
    }).catchError((onError) {
      _userStreamController.sink.add(UserState._userError());
    });
  }

  void dispose() {
    _userStreamController.close();
  }
}

class UserState {
  UserState();
  factory UserState._userData(User user) = UserDataState;
  factory UserState._userLoading() = UserLoadingState;
  factory UserState._userError() = UserErrorState;
}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {}

class UserDataState extends UserState {
  UserDataState(this.user);
  final User user;
}
