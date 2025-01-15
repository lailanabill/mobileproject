// UserSession represents the state of a user's session within the application.
// It includes details such as the session ID and the associated email.
class UserSession {
  final String? sessionId; // Unique identifier for the session (nullable).
  final String? email; // Email address of the user associated with the session (nullable).

  // Constructor for creating a UserSession instance.
  //
  // Parameters:
  // - sessionId: The unique session ID (nullable). Represents the session token or identifier.
  // - email: The email address of the user (nullable). Can be used to identify the user in the session.
  UserSession({this.sessionId, this.email});
}
