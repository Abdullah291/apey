class UserSingleton {
  // singleton
  static final UserSingleton _singleton = UserSingleton._internal();

  factory UserSingleton() => _singleton;

  UserSingleton._internal();

  static UserSingleton get userData => _singleton;

  UserSingleton user;

  String firstName= '';
  String lastName= '';
  String userEmail = '';
  String userId='';
  String dob= '';
  String imageUrl = '';
  // ignore: deprecated_member_use
  List interest= List();
}