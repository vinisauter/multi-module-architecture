// Autogenerated from Pigeon (v1.0.10), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class FLTVersion;

@interface FLTVersion : NSObject
@property(nonatomic, copy, nullable) NSString * string;
@end

/// The codec used by FLTExampleApi.
NSObject<FlutterMessageCodec> *FLTExampleApiGetCodec(void);

@protocol FLTExampleApi
- (nullable FLTVersion *)getPlatformVersionWithError:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FLTExampleApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTExampleApi> *_Nullable api);

/// The codec used by FLTAnalyticsApi.
NSObject<FlutterMessageCodec> *FLTAnalyticsApiGetCodec(void);

@protocol FLTAnalyticsApi
- (void)sendScreenViewEventName:(NSString *)eventName error:(FlutterError *_Nullable *_Nonnull)error;
- (void)sendInteractionCategory:(NSString *)category action:(NSString *)action label:(NSString *)label error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FLTAnalyticsApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTAnalyticsApi> *_Nullable api);

NS_ASSUME_NONNULL_END
