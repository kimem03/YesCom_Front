class User{
  final String phone;
  final String id;
  final String password;

  User({required this.phone, required this.id, required this.password});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        phone: json['phone'],
        id: json['id'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'id': id,
    'password': password,
  };

}