class BooksModel {
  final String id;
  final String title;
  final String auther;
  final String category;
  final String imageUrl;
  final List<dynamic> bookMarks;
  final List<dynamic> likes;

  BooksModel({
    required this.id,
    required this.title,
    required this.auther,
    required this.category,
    required this.imageUrl,
    required this.bookMarks,
    required this.likes
  });
}
