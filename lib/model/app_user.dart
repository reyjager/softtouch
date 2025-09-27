import 'package:hive/hive.dart';

part 'app_user.g.dart';


@HiveType(typeId: 0) // unique ID
enum UserRole {
  @HiveField(0)
  client,

  @HiveField(1)
  stylist,

  @HiveField(2)
  admin,
}

@HiveType(typeId: 1)
class AppUser extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String? profileImage;

  @HiveField(5)
  UserRole role;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;


  
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.role = UserRole.client,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

@override
  String toString() {
    return 'AppUser{id: $id, name: $name, email: $email, phone: $phone, profileImage: $profileImage, role: $role, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

}

