import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/network/supabase_client.dart';
import '../models/couple_model.dart';
import '../models/user_model.dart';

part 'couple_service.g.dart';

@riverpod
CoupleService coupleService(CoupleServiceRef ref) {
  return CoupleService(ref.watch(supabaseClientProvider));
}

class CoupleService {
  final SupabaseClient _supabase;

  CoupleService(this._supabase);

  String _generateInviteCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  Future<CoupleModel> createCouple() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Not logged in');

    // Generate unique code (retry if collision occurs)
    String inviteCode = _generateInviteCode();
    
    // Insert new couple
    final response = await _supabase.from('couples').insert({
      'invite_code': inviteCode,
      'partner_1_id': user.id,
      'is_active': true,
    }).select().single();

    final couple = CoupleModel.fromJson(response);

    // Update current user's couple_id
    await _supabase.from('users').update({
      'couple_id': couple.id,
    }).eq('id', user.id);

    return couple;
  }

  Future<CoupleModel> joinCouple(String inviteCode) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Not logged in');

    try {
      final response = await _supabase.rpc('join_couple', params: {
        'invite_code_input': inviteCode.toUpperCase(),
      });

      final updatedCouple = CoupleModel.fromJson(response);
      return updatedCouple;
    } catch (e) {
      if (e.toString().contains('Invalid invite code')) {
        throw Exception('Invalid invite code. Please check and try again.');
      } else if (e.toString().contains('already full')) {
        throw Exception('This couple is already full.');
      } else if (e.toString().contains('already in this couple')) {
        throw Exception('You are already in this couple.');
      }
      throw Exception('Failed to join couple: $e');
    }
  }

  Future<UserModel?> getCurrentUserProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final response = await _supabase
        .from('users')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;
    return UserModel.fromJson(response);
  }
}
