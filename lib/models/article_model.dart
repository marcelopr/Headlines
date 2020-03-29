class Article {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;
  final String source;
  final String publishedAt;

  Article({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
    this.source,
    this.publishedAt,
  });

  factory Article.fromJson(dynamic json) {
    String _parseDate(dynamic date) {
      return '${date.substring(8, 10)}/${date.substring(5, 7)} • ${date.substring(11, 13)}:${date.substring(14, 16)}';
    }

    return Article(
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      source: json['source']['name'] as String,
      publishedAt: _parseDate(json['publishedAt']),
      content: json['content'],
    );
  }
}
