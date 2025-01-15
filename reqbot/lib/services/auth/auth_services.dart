import 'package:supabase_flutter/supabase_flutter.dart';

// AuthServices provides methods for managing user authentication, including sign-in, sign-up, and sign-out.
// It integrates with Supabase for authentication and user management.
class AuthServices {
  final SupabaseClient _supabase = Supabase.instance.client; // Supabase client instance.

  // Sign in using email and password.
  //
  // Parameters:
  // - email: The user's email address.
  // - password: The user's password.
  //
  // Returns:
  // - An AuthResponse containing the session and user details upon successful sign-in.
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up a new user with email, password, and additional details.
  //
  // Parameters:
  // - name: Full name of the user.
  // - email: Email address of the user.
  // - phone: Phone number of the user.
  // - password: Password for the user.
  // - company: The company associated with the user.
  // - position: Job title or position of the user within the company.
  //
  // Process:
  // 1. Creates a new user in the authentication system.
  // 2. Inserts additional user details into a custom 'users' table in the database.
  //
  // Returns:
  // - An AuthResponse containing user and session details upon successful sign-up.
  Future<AuthResponse> signUpWithEmailPassword(String name, String email, String phone, String password, String company, String position) async {
    try {
      // Sign up the user in the authentication system.
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Insert additional user data into the custom 'users' table.
        final userId = response.user!.id; // Retrieve the user ID from auth.
        await _supabase.from('users').insert({
          'id': userId, // Match the ID with the auth user ID.
          'name': name,
          'phone': phone,
          'company': company,
          'position': position,
        });

        print("User data saved successfully in the 'users' table.");
      } else if (response.error != null) {
        // Handle errors returned during sign-up.
        throw Exception(response.error!.message);
      }

      return response;
    } catch (e) {
      print("Error during sign-up: $e");
      rethrow; // Re-throw the exception to be handled by the caller.
    }
  }

  // Sign out the currently authenticated user.
  //
  // This method clears the user's session and logs them out of the app.
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}

// Extension for AuthResponse to safely access error properties.
// Currently, this extension is a placeholder and does not provide additional functionality.
extension on AuthResponse {
  get error => null;
}
