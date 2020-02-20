import 'package:architecture_studies/repository.dart';
import 'package:architecture_studies/scoped_model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModelScreen extends StatefulWidget {
  UserModelScreen(this._repository);
  final Repository _repository;

  @override
  State<StatefulWidget> createState() => _UserModelScreenState();
}

class _UserModelScreenState extends State<UserModelScreen> {
  UserModel _userModel;

  @override
  void initState() {
    _userModel = UserModel(widget._repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _userModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scoped model'),
        ),
        body: SafeArea(
          child: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isError) return _buildError();
              if (model.isLoading) {
                return _buildLoading();
              } else {
                // model.user != null ? _buildContent(model) : _buildInit(model);
                if (model.user != null) {
                  return _buildContent(model);
                } else {
                  return _buildInit(model);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInit(UserModel userModel) {
    return Center(
      child: RaisedButton(
        child: const Text('Load user data'),
        onPressed: () {
          userModel.loadUserData();
        },
      ),
    );
  }

  Widget _buildContent(UserModel userModel) {
    return Center(
      child: Text('Hello ${userModel.user.name} ${userModel.user.surname}'),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Icon(Icons.error),
    );
  }
}
