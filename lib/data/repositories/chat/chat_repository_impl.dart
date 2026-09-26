import 'package:firebase_database/firebase_database.dart';
import 'package:skybase/data/models/chat/chat_message.dart';
import 'package:skybase/data/models/chat/chat_room.dart';
import 'package:skybase/data/repositories/chat/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  @override
  Stream<List<ChatRoom>> getChatRooms(String userId) {
    return _db
        .ref('chat_rooms')
        .orderByChild('participants/$userId')
        .equalTo(true)
        .onValue
        .map((event) {
      final Map<dynamic, dynamic>? data =
          event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];
      return data.entries.map((e) => ChatRoom.fromJson(e.value)).toList()
        ..sort((a, b) => b.lastTimestamp.compareTo(a.lastTimestamp));
    });
  }

  @override
  Stream<List<ChatMessage>> getMessages(String roomId) {
    return _db.ref('messages/$roomId').onValue.map((event) {
      final Map<dynamic, dynamic>? data =
          event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];
      return data.entries.map((e) => ChatMessage.fromJson(e.value)).toList()
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    });
  }

  @override
  Future<void> sendMessage(String roomId, ChatMessage message) async {
    final messageRef = _db.ref('messages/$roomId').push();
    final messageData = message.toJson()..['id'] = messageRef.key;
    await messageRef.set(messageData);

    // Update last message in room
    await _db.ref('chat_rooms/$roomId').update({
      'lastMessage': message.message,
      'lastTimestamp': message.timestamp.millisecondsSinceEpoch,
    });
  }
}
