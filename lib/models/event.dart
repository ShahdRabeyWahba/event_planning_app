class Event {
  final String title;
  final String description;
  final String date;
  final String time;
  final String category;
  final String imagePath;
  bool isFavorite;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.imagePath,
    this.isFavorite = false,
  });
}
