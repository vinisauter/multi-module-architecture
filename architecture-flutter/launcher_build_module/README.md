# Para obter dependências

cd ../home_business_module ; flutter clean ; \
   cd ../profile_business_module ; flutter clean ; \
   cd ../analytics_flutter_plugin ; flutter clean ; \
   cd ../launcher_build_module ; flutter clean

cd ../home_business_module ; flutter pub get ; \
   cd ../profile_business_module ; flutter pub get ; \
   cd ../analytics_flutter_plugin ; flutter pub get ; \
   cd ../launcher_build_module ; flutter pub get

# Para buildar AARs (ANDROID)

cd ../launcher_build_module ; flutter build aar --no-debug --no-profile

# Para buildar XC-FRAMEWORKS (iOS)

cd ../launcher_build_module ; flutter build ios-framework --no-debug --no-profile
