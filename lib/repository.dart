import 'dart:math';

import 'package:architecture_studies/user.dart';

class Repository {
  Future<User> getUser() async {
    await Future.delayed(Duration(seconds: 2));
    Random random = new Random();
    if (random.nextBool()) throw new Error();
    return User(name: 'Rafael', surname: 'Neri');
  }
}
