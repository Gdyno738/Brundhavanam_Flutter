import '../models/SavedAddress.dart';
import '../models/profile_model.dart';


class MockProfileService {
  static ProfileModel _profile = ProfileModel(
    name: 'Pavan',
    phone: '+91 1234567890',
    email: 'xyz@gmail.com',
    address: 'hyd...', // current address only
  );

  static final List<SavedAddress> savedAddresses = [
    SavedAddress(
      name: "Ravi",
      address: "DLP Cyber City, Indira Nagar, Gachibowli, Hyderabad",
    ),
    SavedAddress(
      name: "Ravi",
      address: "Madhapur, Hi-tech City, Hyderabad",
    ),
  ];

  static Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _profile;
  }

  static Future<List<SavedAddress>> getSavedAddresses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return savedAddresses;
  }

  static Future<void> updateProfile(ProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _profile = profile;
  }
}
