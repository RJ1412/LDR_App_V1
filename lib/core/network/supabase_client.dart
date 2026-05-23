import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_client.g.dart';

/// Exposes the global Supabase client instance.
/// 
/// This client facilitates all auth, database, real-time channels, and edge functions.
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// Helper extension to easily check connection status or manage error transitions.
extension SupabaseClientX on SupabaseClient {
  /// Simple helper to check if a user is currently signed in.
  bool get isUserSignedIn => auth.currentSession != null;

  /// Returns the current user ID or null if unauthenticated.
  String? get currentUserId => auth.currentUser?.id;
}
