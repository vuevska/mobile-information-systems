class Exam {
  final int id;
  final String name;
  final DateTime dateTime;
  final double long;
  final double lat;

  Exam(this.id, this.name, this.dateTime, this.long, this.lat);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateTime': dateTime.toIso8601String(),
      'long': long,
      'lat': lat
    };
  }
}
