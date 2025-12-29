// lib/config/supabase/supabase_client.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SupabaseClientManager {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] as String,
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] as String,
    );
  }

  static SupabaseClient get instance => Supabase.instance.client;
}

// Provider para Riverpod

final supabaseClientProvider = Provider<SupabaseClient>(
  (_) => SupabaseClientManager.instance,
);
