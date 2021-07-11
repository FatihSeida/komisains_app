part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends UserProfileEvent {}

class UpdateProfile extends UserProfileEvent {
  final Map<String, dynamic> profileData;
  UpdateProfile({
    required this.profileData,
  });

  @override
  List<Object> get props => [profileData];
}

class EditPassword extends UserProfileEvent {
  final Map<String, dynamic> newPasswordData;
  EditPassword({
    required this.newPasswordData,
  });

  @override
  List<Object> get props => [newPasswordData];
}

class UploadPhotoProfile extends UserProfileEvent {
  final File photoProfile;

  UploadPhotoProfile({required this.photoProfile});

  @override
  List<Object> get props => [photoProfile];
}
