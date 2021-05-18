# Rewarded Video Ads

Here is the common methods and delegate to use for building pangle 's reward video's adapter.

  * [Create placement](#start/create_placement)
  * [Loading Ads and display](#start/reward_ad_load)
  * [Determining load events](#start/reward_ad_loadevent)


Please [initialize the Pangle SDK](1_prerequisites_initialize) before loading ads.


<a name="start/create_placement"></a>
### Create the placement for reward video ad
On Pangle platform, create an **Rewarded Video Ads** ad in the app, you will get a **placement ID** for ad's loading.

Please set the ad's `Orientation` to fit for the app.
`rewards name` and `rewards quantity` can be random if not needed.


<img src="pics/reward_video_add.png" alt="drawing" width="300"/>  <br>

<img src="pics/reward_video_set.png" alt="drawing" width="300"/>

<a name="start/reward_ad_load"></a>
### Loading Ads


#### 1.Create a model for setting requset data
Create a `BURewardedVideoModel` first for setting userId or other information you want to distinguish the reward. The data will be sent back by `BURewardedVideoAdDelegate`.

| parameter | description |
| :--- | :--- |
| userId | (Optional) For targeting the user if you need |
| extra | (Optional) For sending extra information |
| rewardName | (Optional) Reward name |
| rewardAmount | (Optional) Reward amount |



#### 2.Load an ad and display it

Init a `BURewardedVideoAd` instance, and set the info and placementID o load a reward video ad.

`BURewardedVideoAdDelegate` will be called when ad's load succeed and use `showAdFromRootViewController` to show the ad.


| method | description |
| :--- | :--- |
| - (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(BURewardedVideoModel *)model; | Create a object with soltID(placementID) and model  |
| @property (nonatomic, weak, nullable) id<BURewardedVideoAdDelegate> delegate; | This is a **must be** set parameter to get callback from ad load|
| - (void)loadAdData; | Use this to load an ad after `initWithSlotID` |
| - (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController; | Use this to show the ad if ad load succeed |


#### 3.Get callback from the delegate

The `BURewardedVideoAdDelegate`'s instance you set in the ad load, will give you the callback of load and display status.

##### Basic callback for common use:

| parameter | when be called by pangle sdk |
| :--- | :--- |
| - (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd; | Ad load succeed(video content is no cached), can show ad after here |
| - (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error; | Ad load failed |
| - (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd; | Ad load succeed and video content is cached, recommend to show ad after here |
| - (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd; | When the ad on the front and become visible  |
| - (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd; | When the ad become invisible |
| - (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd; | When the ad is clicked |

##### All callback interface

```obj-c
@protocol BURewardedVideoAdDelegate <NSObject>

@optional

/**
 This method is called when video ad material loaded successfully.
 */
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 This method is called when cached successfully.
 */
- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad slot will be showing.
 */
- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad slot has been shown.
 */
- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is about to close.
 */
- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is closed.
 */
- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is clicked.
 */
- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd;


/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 Server verification which is requested asynchronously is succeeded.
 @param verify :return YES when return value is 2000.
 */
- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify;

/**
 Server verification which is requested asynchronously is failed.
 Return value is not 2000.
 */
- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd __attribute__((deprecated("Use rewardedVideoAdServerRewardDidFail: error: instead.")));

/**
  Server verification which is requested asynchronously is failed.
  @param rewardedVideoAd rewarded Video ad
  @param error request error info
 */
- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd error:(NSError *)error;

/**
 This method is called when the user clicked skip button.
 */
- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd;

/**
 this method is used to get type of rewarded video Ad
 */
- (void)rewardedVideoAdCallback:(BURewardedVideoAd *)rewardedVideoAd withType:(BURewardedVideoAdType)rewardedVideoAdType;

@end

```
