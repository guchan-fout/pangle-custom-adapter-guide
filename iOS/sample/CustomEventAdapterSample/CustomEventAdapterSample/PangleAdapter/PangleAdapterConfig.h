//
//  PangleAdapterConfig.h
//  CustomEventAdapterSample
//
//  Created by Chan Gu on 2021/05/17.
//

#ifndef PangleAdapterConfig_h
#define PangleAdapterConfig_h


#endif /* PangleAdapterConfig_h */

@interface PangleAdapterConfig : NSObject 

@property (nonatomic, copy, readonly) NSString * adapterVersion;
@property (nonatomic, copy, readonly) NSString * networkName;

extern NSString * const kPangleNetworkName;
extern NSString * const kPangleAppIdKey;
extern NSString * const kPanglePlacementIdKey;

- (void)initPangleWith:(NSString *)appId collectPersonalInfo:(BOOL)collectPersonalInfo complete:(void(^)(NSError *))complete;

@end
