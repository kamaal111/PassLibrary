#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>


@interface RCT_EXTERN_MODULE(RNPassLibrary, NSObject)

RCT_EXTERN_METHOD(
    getRemotePKPassAndPresentPKPassView: (NSString *)string
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject
    )

@end
