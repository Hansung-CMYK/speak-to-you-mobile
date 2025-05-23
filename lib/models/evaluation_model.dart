class EvaluationModel {
  final String uid;
  final int egoId;
  final int solvingScore;
  final int talkingScore;
  final int overallScore;

  EvaluationModel({
    required this.uid,
    required this.egoId,
    required this.solvingScore,
    required this.talkingScore,
    required this.overallScore,
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      uid: json['uid'] as String,
      egoId: json['egoId'] as int,
      solvingScore: json['solvingScore'] as int,
      talkingScore: json['talkingScore'] as int,
      overallScore: json['overallScore'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'egoId': egoId,
      'solvingScore': solvingScore,
      'talkingScore': talkingScore,
      'overallScore': overallScore,
    };
  }
}
