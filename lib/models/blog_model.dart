class Blog {
  final int? id;
  final String title;
  final String description;
  Blog({this.id, required this.title, required this.description});

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        title: json['title'],
        description: json['description'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
