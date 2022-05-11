class AppUser {
  final String uid;
  final String name;
  final String username;
  final String email;
  final String notification;
  final List groups;
  AppUser({required this.uid, required this.name, required this.username, required this.email, required this.groups, required this.notification});
}