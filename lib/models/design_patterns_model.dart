

import 'dart:convert';

// ignore: non_constant_identifier_names
DesignPatterns DesignPatternsFromMap(String str) => DesignPatterns.fromMap(json.decode(str));

// ignore: non_constant_identifier_names
String DesignPatternsToMap(DesignPatterns data) => json.encode(data.toMap());

class DesignPatterns {
    DesignPatterns({
        required this.title,
        required this.content,
    });

    final String title;
    final String content;

    factory DesignPatterns.fromMap(Map<String, dynamic> json) => DesignPatterns(
        title: json["title"],
        content: json["content"],

    );

    Map<String, dynamic> toMap() => {
        "title": title,
        "content": content,

    };
}
