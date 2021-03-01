import 'dart:convert';

class User {
  String objectId;
  String createdAt;
  String updatedAt;
  String username;
  String email;
  int nix;
  String profilePicUri;
  String displayName;
  bool emailVerified;
  String sessionToken;
  String password;

  User(
    this.username,
    this.password,
    this.email, {
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.displayName,
    this.nix,
    this.profilePicUri,
    this.emailVerified,
    this.sessionToken,
  });

  @override
  String toString() {
    return 'User(objectId: $objectId, createdAt: $createdAt, updatedAt: $updatedAt, username: $username, email: $email, nix: $nix, profilePicUri: $profilePicUri, displayName: $displayName, emailVerified: $emailVerified, sessionToken: $sessionToken, password: $password)';
  }

  Map<String, dynamic> toMap() {
    return {
      'objectId': objectId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'username': username,
      'email': email,
      'nix': nix,
      'profilePicUri': profilePicUri,
      'displayName': displayName,
      'emailVerified': emailVerified,
      'sessionToken': sessionToken,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      map['username'],
      map['password'],
      map['email'],
      objectId: map['objectId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      nix: map['nix'],
      profilePicUri: map['profilePicUri'],
      displayName: map['displayName'],
      emailVerified: map['emailVerified'],
      sessionToken: map['sessionToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
