// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

class Profile {
  int? id;
  String? email;
  String? username;
  int? roleId;
  String? nik;
  String? firstname;
  String? lastname;
  String? phone;
  String? profilePic;
  String? identityPic;
  int? statusId;
  String? lastLogin;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? emailVerifiedAt;

  Profile({
    this.id,
    this.email,
    this.username,
    this.roleId,
    this.nik,
    this.firstname,
    this.lastname,
    this.phone,
    this.profilePic,
    this.identityPic,
    this.statusId,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.emailVerifiedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    email: json["email"],
    username: json["username"],
    roleId: json["role_id"],
    nik: json["nik"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    profilePic: json["profile_pic"],
    identityPic: json["identity_pic"],
    statusId: json["status_id"],
    lastLogin: json["last_login"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "username": username,
    "role_id": roleId,
    "nik": nik,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "profile_pic": profilePic,
    "identity_pic": identityPic,
    "status_id": statusId,
    "last_login": lastLogin,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
  };
}
