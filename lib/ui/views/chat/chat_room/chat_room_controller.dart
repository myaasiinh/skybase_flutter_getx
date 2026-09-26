import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/config/base/base_stream_controller.dart';
import 'package:skybase/data/models/chat/chat_message.dart';
import 'package:skybase/data/repositories/chat/chat_repository.dart';

class ChatRoomController extends BaseStreamController<ChatMessage> {
  final ChatRepository repository;
  final String roomId;
  final String receiverId;

  ChatRoomController({
    required this.repository,
    required this.roomId,
    required this.receiverId,
  });

  final messageController = TextEditingController();

  @override
  void onInit() {
    bindListDataStream(repository.getMessages(roomId));
    super.onInit();
  }

  void onSendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final user = AuthManager.find.user;
    if (user == null) return;

    final message = ChatMessage(
      id: '',
      senderId: user.id.toString(),
      receiverId: receiverId,
      message: text,
      timestamp: DateTime.now(),
    );

    messageController.clear();
    await repository.sendMessage(roomId, message);
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
