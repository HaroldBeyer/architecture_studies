import 'package:architecture_studies/repository.dart';
import 'package:architecture_studies/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  UserModel(this._repository);
  final Repository _repository;

  bool _isLoading = false;
  User _user;
  bool _isError = false;

  User get user => _user;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  void loadUserData() {
    _isLoading = true;
    notifyListeners();
    _repository.getUser().then((user) {
      _user = user;
      _isLoading = false;
      notifyListeners();
    }).catchError(
        (onError) => {_isLoading = false, _isError = true, notifyListeners()});
  }

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);
}
