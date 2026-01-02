class ProfileModel {
  final String name;
  final String phone;
  final String email;
  final String address;

  ProfileModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  ProfileModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? address,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }
}
