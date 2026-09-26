import 'package:get/get.dart';
import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_controller.dart';

class ProfileController extends BaseController<User> {
  /* 
    --- INTERVIEW PREP: GETX & BASE ---
    1. BaseController<User>: Menyediakan status (loading, error, success) & dataObj.
    2. requestParams: Berisi cancelToken & cachedKey untuk pass ke repository.
    3. loadData: Fungsi helper base untuk memulai pemuatan data.
  */
  final AuthRepository repository;

  ProfileController({required this.repository});

  @override
  void onReady() {
    loadData(() => onGetProfile());
    super.onReady();
  }

  @override
  Future<void> onRefresh() async {
    await Get.find<ProfileRepositoryController>().onRefresh();
    super.onRefresh();
  }

  @override
  bool get keepAlive => false;

  Future<void> onGetProfile() async {
    try {
      final response = await repository.getProfile(
        requestParams: requestParams,
        username: 'nandakista',
      );
      loadFinish(data: response);
    } catch (e) {
      loadError(e.toString());
    }
  }
}
