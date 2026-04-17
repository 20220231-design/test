class UserModel {
  final String uid;
  final String email;
  final String name;
  final String role;
  final String phone;
  final String address;
  final String imageUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.phone,
    required this.address,
    required this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? 'customer',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'role': role,
      'phone': phone,
      'address': address,
      'imageUrl': imageUrl,
    };
  }
}