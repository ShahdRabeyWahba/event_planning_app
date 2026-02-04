class Event {
  static const String collectionName = 'Events';
  ///Attributes
  String id;
  String title;
  String description;
  String date; // Stored as Timestamp or formatted String? Keeping String for now based on usage.
  String time;
  String category;
  String imagePath;
  bool isFavorite;

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.imagePath,
    this.isFavorite = false,
  });

  /// object => json
  Event.fromFirestore(Map<String, dynamic>? data)
      : this(
          id: data?['id'] as String? ?? '',
          category: data?['category'] as String? ?? '',
          date: data?['date'] as String? ?? '',
          description: data?['description'] as String? ?? '',
          imagePath: data?['imagePath'] as String? ?? '',
          time: data?['time'] as String? ?? '',
          title: data?['title'] as String? ?? '',
          isFavorite: data?['isFavorite'] as bool? ?? false,
        );

  /// json => object
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'time': time,
      'date': date,
      'title': title,
      'description': description,
      'category': category,
      'imagePath': imagePath,
      'isFavorite': isFavorite,
    };
  }
}
