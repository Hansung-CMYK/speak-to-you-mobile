class Diary {
  final int? diaryId;
  final String uid;
  final int egoId;
  final String feeling;
  final String dailyComment;
  final String createdAt;
  final List<String> keywords; // String으로 수정 필요
  final List<Topic> topics;

  Diary({
    this.diaryId,
    required this.uid,
    required this.egoId,
    required this.feeling,
    required this.dailyComment,
    required this.createdAt,
    required this.keywords,
    required this.topics,
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      diaryId: json['diaryId'],
      uid: json['uid'],
      egoId: json['egoId'],
      feeling: json['feeling'],
      dailyComment: json['dailyComment'],
      createdAt: json['createdAt'],
      keywords: List<String>.from(json['keywords']),
      topics:
          (json['topics'] as List)
              .map((topicJson) => Topic.fromJson(topicJson))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diaryId': diaryId,
      'uid': uid,
      'egoId': egoId,
      'feeling': feeling,
      'dailyComment': dailyComment,
      'createdAt': createdAt,
      'keywords': keywords,
      'topics': topics.map((t) => t.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return '''
📓 Diary {
  🆔 diaryId: $diaryId
  👤 uid: $uid
  🧠 egoId: $egoId
  😊 feeling: $feeling
  💬 dailyComment: $dailyComment
  🕒 createdAt: $createdAt
  🏷️ keywords: ${keywords.join(', ')}
  📝 topics:
${topics.map((t) => t.toString()).join('\n')}
}''';
  }
}

class Topic {
  final int? topicId;
  final int? diaryId;
  final String title;
  String content;
  String? url;
  bool? isDeleted;

  Topic({
    this.topicId,
    this.diaryId,
    required this.title,
    required this.content,
    this.url,
    this.isDeleted,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: json['topicId'],
      diaryId: json['diaryId'],
      title: json['title'],
      content: json['content'],
      url: json['url'],
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'diaryId': diaryId,
      'title': title,
      'content': content,
      'url': url,
      'isDeleted': isDeleted,
    };
  }

  @override
  String toString() {
    return '''
    📌 Topic {
      🆔 topicId: $topicId
      📘 diaryId: $diaryId
      🏷️ title: $title
      ✍️ content: $content
      🌐 url: $url
      ❌ isDeleted: $isDeleted
    }''';
  }
}
