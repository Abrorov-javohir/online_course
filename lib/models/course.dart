class Course {
  String id;
  String title;
  String description;
  String imageUrl;
  List<String> lessons;
  double price;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.lessons,
    required this.price,
  });
}