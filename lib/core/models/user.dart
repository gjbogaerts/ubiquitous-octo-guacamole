import 'dart:core';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class User extends ParseUser implements ParseCloneable {
  User(String username, String password, String emailAddress)
      : super(username, password, emailAddress);

  User.clone() : this(null, null, null);

  @override
  User clone(Map<String, dynamic> map) => User.clone()..fromJson(map);

  static const String keyNix = 'nix';
  static const String keyDisplayName = 'displayName';
  static const String keyProfilePicUri = 'profilePicUri';

  num get nix => get<num>(keyNix);
  set nix(num nix) => set<num>(keyNix, nix);

  String get displayName => get<String>(keyDisplayName);
  set displayName(String displayName) =>
      set<String>(keyDisplayName, displayName);

  String get profilePicUri => get<String>(keyProfilePicUri);
  set profilePicUri(String profilePicUri) =>
      set<String>(keyProfilePicUri, profilePicUri);
}
