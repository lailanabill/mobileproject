// UserModel represents a structured data model for user information.
// It encapsulates user details typically required for registration, authentication, or profile management.
class UserModel {
  final String name; // The user's full name.
  final String email; // The user's email address.
  final String phone; // The user's phone number.
  final String company; // The company associated with the user.
  final String position; // The user's position or job title within the company.
  final String password; // The user's password (should be handled securely).

  // Constructor for creating a new UserModel instance.
  //
  // Parameters:
  // - name: Full name of the user.
  // - email: Email address of the user.
  // - phone: Phone number of the user.
  // - company: Company associated with the user.
  // - position: Job title or position of the user within the company.
  // - password: User's password.
  //
  // Note: Ensure that passwords are never stored in plain text for security reasons.
  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.position,
    required this.password,
  });
}
