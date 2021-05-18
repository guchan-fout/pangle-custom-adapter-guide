# Prerequisites and Initialize

This guide is for you to build Pangle iOS SDK's mediation for your adnetwork.

## Prerequisites
- Please following [iOS 14 actions](https://www.pangleglobal.com/help/doc/5f4dc4271de305000ece82aa) to enable SKAdNetwork and add Pangle's SKAdNetwork ID.

- Use Xcode 12.0 or higher
- Target iOS 9.0 or higher
- Create a Pangle account [here](https://www.pangleglobal.com/)(If you do not have one), and add your app and placements.



## Initialize

`+ (void)setAppID:(NSString *)appID;` is the method for initializing Pangle SDK with the `AppID` as the argument.

* `AppID` is used to identify your app after you add an app on pangle's platform.


**If you need to set `GDPR` or `COPPA`. We strongly recommend to set it before calling `setAppID`.**

This is a sample for initialize
```obj-c
@interface PangleAdapterConfig : YourMediationAdapterConfig

- (void)initMediationAdnetworkWith:(NSString *)appId collectPersonalInfo:(BOOL)collectPersonalInfo complete:(void(^)(NSError *))complete;

@end

@implementation PangleAdapterConfig

static NSString * const errorDomain = @"pangle";
static int const errorCode = 123;

- (void)initMediationAdnetworkWith:(NSString *)appId collectPersonalInfo:(BOOL)collectPersonalInfo complete:(void(^)(NSError *))complete {
    if (!(appId && [appId isKindOfClass:[NSString class]] && appId.length > 0)) {
        NSError *error = [NSError errorWithDomain:errorDomain
                                             code:errorCode
                                         userInfo:@{NSLocalizedDescriptionKey:
                                                        @"invalid pangle appId"}];
        if (complete != nil) {
            complete(error);
        }
    } else {
        //Best set before sdk's init
        [BUAdSDKManager setGDPR:collectPersonalInfo ? 0 : 1];

        //set your adnetwork's info to pangle
        [BUAdSDKManager setUserExtData:@"[{\"name\":\"mediation\",\"value\":\"your_network_name\"},{\"name\":\"adapter_version\",\"value\":\"this_adapter_name\"}]"];

        [BUAdSDKManager setAppID:appId];
        if (complete != nil) {
            complete(nil);
        }
    }
}

@end

```

### Interface Instruction

`BUAdSDKManager` also provides the following class methods for using.

```obj-c
@property (nonatomic, copy, readonly, class) NSString *SDKVersion;

/// Register the App key that’s already been applied before requesting an ad from Pangle Plarform.                                                       @param appID : the unique identifier of the App
+ (void)setAppID:(NSString *)appID;

///This property should be set when integrating non-China areas at the same time, otherwise it does not need to be set.you‘d better set Territory first,  if you need to set them.                                                      @param territory : Regional value: 1.BUAdSDKTerritory_CN  2.BUAdSDKTerritory_NO_CN
+ (void)setTerritory:(BUAdSDKTerritory)territory;

 ///Configure development mode.                                            @param level : default BUAdSDKLogLevelNone
+ (void)setLoglevel:(BUAdSDKLogLevel)level;

///Set the COPPA of the user, COPPA is the short of Children's Online Privacy Protection Rule, the interface only works in the United States.              @params Coppa 0 adult, 1 child
+ (void)setCoppa:(NSUInteger)Coppa;

/// Set the user's keywords, such as interests and hobbies, etc.
/// Must obtain the consent of the user before incoming.
+ (void)setUserKeywords:(NSString *)keywords;

/// set additional user information.
+ (void)setUserExtData:(NSString *)data;

/// get appID
+ (NSString *)appID;


```
