class Percentage{
  String id,percentage;

//<editor-fold desc="Data Methods">
  Percentage({
    required this.id,
    required this.percentage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Percentage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          percentage == other.percentage);

  @override
  int get hashCode => id.hashCode ^ percentage.hashCode;

  @override
  String toString() {
    return 'Percentage{' + ' id: $id,' + ' percentage: $percentage,' + '}';
  }

  Percentage copyWith({
    String? id,
    String? percentage,
  }) {
    return Percentage(
      id: id ?? this.id,
      percentage: percentage ?? this.percentage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'percentage': this.percentage,
    };
  }

  factory Percentage.fromMap(Map<String, dynamic> map) {
    return Percentage(
      id: map['id'] as String,
      percentage: map['percentage'] as String,
    );
  }

//</editor-fold>
}