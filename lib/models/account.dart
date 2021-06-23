class Account {
  final String username;
  final String password;
  final String name;
  final DateTime dob;
  final String gender;
  final String profile;

  Account(
      {this.username,
      this.password,
      this.name,
      this.dob,
      this.gender,
      this.profile});

  factory Account.fromJson(dynamic data) {
    return Account(
      username: data['username'],
      password: data['password'],
      name: data['name'],
      gender: data['gender'],
      profile: data['profile'],
    );
  }
}
