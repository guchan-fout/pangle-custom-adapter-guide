//
//  PangleAdapterConfig.m
//  CustomEventAdapterSample
//
//  Created by Chan Gu on 2021/05/17.
//

#import <Foundation/Foundation.h>
#import "PangleAdapterConfig.h"
#import <BUAdSDK/BUAdSDKManager.h>

@implementation PangleAdapterConfig

static NSString * const errorDomain = @"pangle";
static int const errorCode = 123;

- (void)initPangleWith:(NSString *)appId collectPersonalInfo:(BOOL)collectPersonalInfo complete:(void(^)(NSError *))complete {
    if (!(appId && [appId isKindOfClass:[NSString class]] && appId.length > 0)) {
        NSError *error = [NSError errorWithDomain:errorDomain
                                             code:errorCode
                                         userInfo:@{NSLocalizedDescriptionKey:
                                                        @"invalid pangle appId"}];
        if (complete != nil) {
            complete(error);
        }
    } else {
        [BUAdSDKManager setGDPR:collectPersonalInfo ? 0 : 1];
        
        [BUAdSDKManager setUserExtData:@"[{\"name\":\"mediation\",\"value\":\"your_network_name\"},{\"name\":\"adapter_version\",\"value\":\"this_adapter_name\"}]"];

        [BUAdSDKManager setAppID:appId];
        if (complete != nil) {
            complete(nil);
        }
    }
}

@end
