// ignore_for_file: file_names

class UserModel {
  late String name;
  late String email;
  late String uid;
  late String phone;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phone': phone,
    };
  }
}
