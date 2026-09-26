import 'package:flutter/widgets.dart';
import './main.dart' as main_app;
import 'config/environment/app_env.dart';
import 'config/environment/config_data.dart';
import 'config/network/api_token_manager.dart';
import 'dev/dev_token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnv.set(
    environment: Environment.DEVELOPMENT,
    configuration: ConfigData(
      baseUrl: 'https://api.github.com',
      tokenType: TokenType.ACCESS_TOKEN,
      clientToken: gitToken,
    ),
  );
}