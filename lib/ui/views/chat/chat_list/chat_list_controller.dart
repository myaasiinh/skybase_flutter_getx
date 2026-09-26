import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/config/base/base_stream_controller.dart';
import 'package:skybase/data/models/chat/chat_room.dart';
import 'package:skybase/data/repositories/chat/chat_repository.dart';

class ChatListController extends BaseStreamController<ChatRoom> {
  final ChatRepository repository;

  ChatListController({required this.repository});

  @override
  void onInit() {
    final userId = AuthManager.find.user?.id.toString() ?? '';
    if (userId.isNotEmpty) {
      bindListDataStream(repository.getChatRooms(userId));
    }
    super.onInit();
  }
}
