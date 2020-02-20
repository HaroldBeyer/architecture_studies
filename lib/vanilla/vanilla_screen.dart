import 'package:architecture_studies/repository.dart';
import 'package:architecture_studies/user.dart';
import 'package:flutter/material.dart';

class VanillaScreen extends StatefulWidget {
  VanillaScreen(this._repository);
  final Repository _repository;

  @override
  State<StatefulWidget> createState() => _VanillaScreenState();
}

class _VanillaScreenState extends State<VanillaScreen> {
  bool _isLoading = false;
  bool _isError = false;
  User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vanilla'),
      ),
      body: SafeArea(
        child: _isLoading
            ? _buildLoading()
            : _isError ? _buildError() : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_user != null) {
      return _buildContent();
    } else {
      return _buildInit();
    }
  }

  Widget _buildInit() {
    return Center(
      child: RaisedButton(
        child: Text('Load user data'),
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          widget._repository.getUser().then((user) {
            setState(() {
              _user = user;
              _isLoading = false;
            });
          }).catchError((onError) => {
                setState(() {
                  _isLoading = false;
                  _isError = true;
                })
              });
        },
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Text('Hello ${_user.name} ${_user.surname}'),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Icon(Icons.error),
    );
  }
}
