import '../models/profile_model.dart';

class MockProfileService {
  static ProfileModel _profile = ProfileModel(
    name: 'Aisha',
    phone: '+91 1234567890',
    email: 'xyz@gmail.com',
    address: 'hyd...',
  );

  static Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _profile;
  }

  static Future<void> updateProfile(ProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _profile = profile;
  }
}
