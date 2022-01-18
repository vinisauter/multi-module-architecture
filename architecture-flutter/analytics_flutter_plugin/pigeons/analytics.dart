import 'package:pigeon/pigeon.dart';

class Version {
  String? string;
}

@HostApi()
abstract class ExampleApi {
  Version getPlatformVersion();
}

@HostApi()
abstract class AnalyticsApi {
  void sendScreenView(String eventName);
  void sendInteraction(String category, String action, String label);
}
