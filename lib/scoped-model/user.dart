import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';

mixin UserModel on Model {
    User _authenticatedUser;

    void login(String email, String password) {
        _authenticatedUser = User(
            id: 'bc123',
            email: email,
            password: password,
        );
    }
}
