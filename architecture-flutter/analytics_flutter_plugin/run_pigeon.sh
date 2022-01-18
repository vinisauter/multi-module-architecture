flutter pub run pigeon \
  --input pigeons/analytics.dart \
  --dart_out lib/analytics.dart \
  --objc_header_out ios/Classes/analytics.h \
  --objc_source_out ios/Classes/analytics.m \
  --objc_prefix FLT \
  --java_out android/src/main/java/com/example/analytics/analytics_flutter_plugin/Analytics.java \
  --java_package "com.example.analytics.analytics_flutter_plugin"