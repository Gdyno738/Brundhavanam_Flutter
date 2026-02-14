class SavedAddress {
  final String name;
  final String address;

  SavedAddress({
    required this.name,
    required this.address,
  });

  factory SavedAddress.fromJson(Map<String, dynamic> json) {
    return SavedAddress(
      name: json['name'],
      address: json['address'],
    );
  }
}
