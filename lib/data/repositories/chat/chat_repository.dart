import 'package:skybase/data/models/chat/chat_message.dart';
import 'package:skybase/data/models/chat/chat_room.dart';

abstract class ChatRepository {
  Stream<List<ChatRoom>> getChatRooms(String userId);
  Stream<List<ChatMessage>> getMessages(String roomId);
  Future<void> sendMessage(String roomId, ChatMessage message);
}
