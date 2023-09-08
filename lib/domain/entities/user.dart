class User {
  final int? id;
  final String fullName;
  final String? projectName;
  final String? profilePhoto;
  final int? categoryId;
  final String phoneNumber;
  final String? address;

  User({
    required this.id,
    required this.fullName,
    required this.projectName,
    required this.categoryId,
    required this.phoneNumber,
    required this.address,
    required this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      fullName: json['full_name'] as String,
      projectName: json['project_name'] as String?,
      categoryId: json['category_id'] as int?,
      phoneNumber: json['phone_number'] as String,
      address: json['address'] as String?,
      profilePhoto: json['profile_photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'project_name': projectName,
      'category_id': categoryId,
      'phone_number': phoneNumber,
      'address': address,
    };
  }
}
