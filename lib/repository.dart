import 'package:architecture_studies/user.dart';

class Repository {
  Future<User> getUser() async {
    await Future.delayed(Duration(seconds: 2));
    // throw new Error();
    return User(name: 'Rafael', surname: 'Neri');
  }
}
