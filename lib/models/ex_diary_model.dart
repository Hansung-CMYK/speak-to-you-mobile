import 'dart:convert';
import 'dart:typed_data';

class Diary {
  final String id;
  final String date;
  final String subject;
  final String content;
  final Uint8List image;

  Diary({
    required this.id,
    required this.date,
    required this.subject,
    required this.content,
    required this.image,
  });

  // JSON 변환 함수 (fromJson)
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'],
      date: json['date'],
      subject: json['subject'],
      content: json['content'],
      image: base64Decode(json['image']),
    );
  }

  // JSON 변환 함수 (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'subject': subject,
      'content': content,
      'image': base64Encode(image),
    };
  }
}
