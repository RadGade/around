class newUser {
  final String id;
  final String username;
  final String email;
  final DateTime birthday;
  

  newUser({this.id, this.username, this.email, this.birthday});

  newUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        email = data['email'],
        birthday = data['birthday'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'birthday': birthday,
    };
  }
}