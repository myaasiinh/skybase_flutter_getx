import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/chat/chat_list/chat_list_controller.dart';
import 'package:skybase/ui/widgets/base/state_view.dart';

class ChatListView extends GetView<ChatListController> {
  static const String route = '/chat-list';

  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Obx(
        () => StateView.page(
          loadingEnabled: controller.isLoading,
          errorEnabled: controller.isError,
          emptyEnabled: controller.isEmpty,
          onRetry: () => controller.onInit(),
          onRefresh: () => controller.onInit(),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.dataList.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final room = controller.dataList[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    room.receiverName.isNotEmpty ? room.receiverName[0] : 'U',
                  ),
                ),
                title: Text(room.receiverName.isNotEmpty ? room.receiverName : 'Unknown User'),
                subtitle: Text(room.lastMessage),
                onTap: () {
                  // Navigate to chat room
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
