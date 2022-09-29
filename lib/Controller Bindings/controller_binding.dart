import 'package:e_learning/Controller/auth_controller.dart';
import 'package:e_learning/Controller/main_screen_controller.dart';
import 'package:e_learning/Controller/upload_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainscreenController());
    Get.put(AuthFunctions());
    Get.put(UpladController());
  }
}
