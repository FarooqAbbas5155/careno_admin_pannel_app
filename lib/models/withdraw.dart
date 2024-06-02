class WithDrawan{
  String hostId,status;
  int timeStamp;
  double witdrawBalance;
  bool isVerified;

//<editor-fold desc="Data Methods">
  WithDrawan({
    required this.hostId,
    required this.status,
    required this.timeStamp,
    required this.witdrawBalance,
    required this.isVerified,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WithDrawan &&
          runtimeType == other.runtimeType &&
          hostId == other.hostId &&
          status == other.status &&
          timeStamp == other.timeStamp &&
          witdrawBalance == other.witdrawBalance &&
          isVerified == other.isVerified);

  @override
  int get hashCode =>
      hostId.hashCode ^
      status.hashCode ^
      timeStamp.hashCode ^
      witdrawBalance.hashCode ^
      isVerified.hashCode;

  @override
  String toString() {
    return 'WithDrawan{' +
        ' hostId: $hostId,' +
        ' status: $status,' +
        ' timeStamp: $timeStamp,' +
        ' witdrawBalance: $witdrawBalance,' +
        ' isVerified: $isVerified,' +
        '}';
  }

  WithDrawan copyWith({
    String? hostId,
    String? status,
    int? timeStamp,
    double? witdrawBalance,
    bool? isVerified,
  }) {
    return WithDrawan(
      hostId: hostId ?? this.hostId,
      status: status ?? this.status,
      timeStamp: timeStamp ?? this.timeStamp,
      witdrawBalance: witdrawBalance ?? this.witdrawBalance,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hostId': this.hostId,
      'status': this.status,
      'timeStamp': this.timeStamp,
      'witdrawBalance': this.witdrawBalance,
      'isVerified': this.isVerified,
    };
  }

  factory WithDrawan.fromMap(Map<String, dynamic> map) {
    return WithDrawan(
      hostId: map['hostId'] as String,
      status: map['status'] as String,
      timeStamp: map['timeStamp'] as int,
      witdrawBalance: map['witdrawBalance'] as double,
      isVerified: map['isVerified'] as bool,
    );
  }

//</editor-fold>
}