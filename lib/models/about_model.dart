class AboutMe {
  final String title;
  final String description;
  final String imageUrl;
  final Bio bio;
  final String paragraph1;
  final String paragraph2;

  AboutMe({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.bio,
    required this.paragraph1,
    required this.paragraph2,
  });

  factory AboutMe.fromJson(Map<String, dynamic> json) {
    return AboutMe(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      bio: Bio.fromJson(json['bio']),
      paragraph1: json['paragraph1'],
      paragraph2: json['paragraph2'],
    );
  }
}

class Bio {
  final String intro;
  final String highlight1;
  final String connector;
  final String highlight2;
  final String outro;

  Bio({
    required this.intro,
    required this.highlight1,
    required this.connector,
    required this.highlight2,
    required this.outro,
  });

  factory Bio.fromJson(Map<String, dynamic> json) {
    return Bio(
      intro: json['intro'],
      highlight1: json['highlight1'],
      connector: json['connector'],
      highlight2: json['highlight2'],
      outro: json['outro'],
    );
  }
}
