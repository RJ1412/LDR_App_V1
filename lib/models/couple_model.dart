class CoupleModel {
  final String id;
  final DateTime createdAt;
  final String inviteCode;
  final String? partner1Id;
  final String? partner2Id;
  final bool isActive;
  final String? spaceName;
  final DateTime? anniversaryDate;
  final String? welcomeMessage;
  final String? coverPhotoUrl;

  const CoupleModel({
    required this.id,
    required this.createdAt,
    required this.inviteCode,
    this.partner1Id,
    this.partner2Id,
    required this.isActive,
    this.spaceName,
    this.anniversaryDate,
    this.welcomeMessage,
    this.coverPhotoUrl,
  });

  factory CoupleModel.fromJson(Map<String, dynamic> json) {
    return CoupleModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      inviteCode: json['invite_code'] as String,
      partner1Id: json['partner_1_id'] as String?,
      partner2Id: json['partner_2_id'] as String?,
      isActive: json['is_active'] as bool,
      spaceName: json['space_name'] as String?,
      anniversaryDate: json['anniversary_date'] != null 
          ? DateTime.parse(json['anniversary_date'] as String) 
          : null,
      welcomeMessage: json['welcome_message'] as String?,
      coverPhotoUrl: json['cover_photo_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'invite_code': inviteCode,
      'partner_1_id': partner1Id,
      'partner_2_id': partner2Id,
      'is_active': isActive,
      'space_name': spaceName,
      'anniversary_date': anniversaryDate?.toIso8601String(),
      'welcome_message': welcomeMessage,
      'cover_photo_url': coverPhotoUrl,
    };
  }
}
