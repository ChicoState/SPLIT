class AppUser {
  final String uid;
  final String name;
  final String username;
  final String email;
  final String notification;
  String groupId;
  AppUser(
      {required this.uid,
      required this.name,
      required this.username,
      required this.email,
      required this.notification,
      required this.groupId});
}
