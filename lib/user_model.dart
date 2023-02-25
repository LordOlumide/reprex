class User {
  final String email;
  final String username;

  const User({
    required this.email,
    required this.username,
  });

  factory User.fromJson(json) {
    return User(email: json['email'], username: json['username']);
  }

  @override
  String toString() {
    return 'email: $email, username: $username';
  }
}
