
class PredSize {
  final String class_name;
  final int predicted_class;

  PredSize({
    required this.class_name,
    required this.predicted_class,

  });

  factory PredSize.fromJson(Map<String, dynamic> json) {
    return PredSize(
      class_name: json['class_name'],
      predicted_class: json['predicted_class'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'class_name': class_name,
      'predicted_class':predicted_class ,
    };
  }
}
