class ChatRoom {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastTimestamp;
  final String receiverName;
  final String receiverImage;

  ChatRoom({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastTimestamp,
    this.receiverName = '',
    this.receiverImage = '',
  });

  factory ChatRoom.fromJson(Map<dynamic, dynamic> json) {
    return ChatRoom(
      id: json['id'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      lastTimestamp: DateTime.fromMillisecondsSinceEpoch(json['lastTimestamp'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastTimestamp': lastTimestamp.millisecondsSinceEpoch,
    };
  }
}
