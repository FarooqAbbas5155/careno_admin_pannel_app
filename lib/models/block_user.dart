class BlockUser{
  String uid;

//<editor-fold desc="Data Methods">
  BlockUser({
    required this.uid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockUser &&
          runtimeType == other.runtimeType &&
          uid == other.uid);

  @override
  int get hashCode => uid.hashCode;

  @override
  String toString() {
    return 'BlockUser{' + ' uid: $uid,' + '}';
  }

  BlockUser copyWith({
    String? uid,
  }) {
    return BlockUser(
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
    };
  }

  factory BlockUser.fromMap(Map<String, dynamic> map) {
    return BlockUser(
      uid: map['uid'] as String,
    );
  }

//</editor-fold>
}