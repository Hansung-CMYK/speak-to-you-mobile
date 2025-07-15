import 'dart:convert';
import 'dart:typed_data';

class EgoRelationship {
  final int egoRelationshipId;
  final String uid;
  final int egoId;
  final int relationshipId;
  final DateTime createdAt;
  final String relationshipContent;
  final String egoName;
  final Uint8List? profileImage;

  EgoRelationship({
    required this.egoRelationshipId,
    required this.uid,
    required this.egoId,
    required this.relationshipId,
    required this.createdAt,
    required this.relationshipContent,
    required this.egoName,
    required this.profileImage
  });

  factory EgoRelationship.fromJson(Map<String, dynamic> json) {
    return EgoRelationship(
      egoRelationshipId: json['egoRelationshipId'],
      uid: json['uid'],
      egoId: json['egoId'],
      relationshipId: json['relationshipId'],
      createdAt: DateTime.parse(json['createdAt']),
      relationshipContent: json['relationshipContent'],
      egoName: json['egoName'],
      profileImage: json['profileImage'] != null
          ? base64Decode(json['profileImage'])
          : null,
    );
  }
}