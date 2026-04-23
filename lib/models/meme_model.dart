class Meme{
   final String postLink;
  final  String subreddit;
  final String title;
  final String url;
  final bool nsfw;
  final bool spoiler;
  final int ups;
  final List<String> preview;
  Meme({
    required this.postLink,
    required this.subreddit,
    required this.title,
    required this.url,
    required this.nsfw,
    required this.ups,
    required this.spoiler,
    required this.preview,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      postLink: json['postLink'] as String,
      subreddit: json['subreddit'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      nsfw: json['nsfw'] as bool,
      ups: json['ups'] as int,
      spoiler: json['spoiler'] as bool,
      preview: List<String>.from(json['preview'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postLink': postLink,
      'subreddit': subreddit,
      'title': title,
      'url': url,
      'nsfw': nsfw,
      'ups': ups,
      'spoiler': spoiler,
      'preview': preview,
    };
  }

}