import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class User extends ParseUser implements ParseCloneable {
  User(
    username,
    password,
    emailAddress,
  ) : super(username, password, emailAddress);

  static const _keyNix = 'nix';
  static const _keyDisplayName = 'displayName';
  static const _keyProfilePicUri = 'profilePicUri';

  int get nix => get<int>(_keyNix);
  set nix(int nix) => set<int>(_keyNix, nix);

  String get displayName => get<String>(_keyDisplayName);
  set displayName(String displayName) =>
      set<String>(_keyDisplayName, displayName);

  String get profilePicUri => get<String>(_keyProfilePicUri);
  set profilePicUri(String profilePicUri) =>
      set<String>(_keyProfilePicUri, profilePicUri);
}
