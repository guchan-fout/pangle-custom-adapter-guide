# Interstitial Video Ads

Here is the common methods and delegate to use for building pangle 's Interstitial video's adapter.

  * [Create placement](#start/create_placement)
  * [Loading ads and display](#start/fullscreen_ad_load)


Please [initialize the Pangle SDK](1_prerequisites_initialize) before loading ads.


<a name="start/create_placement"></a>
### Create the placement for full screen video ad
On Pangle platform, create an **Interstitial Video Ads** ad in the app, you will get a **placement ID** for ad's loading.

Please set the ad's `Orientation` to fit for the app.

<img src="pics/fullscreen_add.png" alt="drawing" width="300"/>  <br>

<img src="pics/fullscreen_set.png" alt="drawing" width="300"/>

<a name="start/fullscreen_ad_load"></a>
### Loading Ads


#### 1.Load a interstitial video ad and display

Create a `AdSlot` instance with the placementID.

```java
AdSlot adSlot = new AdSlot.Builder()
        .setCodeId("Your_Ad_Placement_Id")
        .build();
```


Use `TTAdNative createAdNative(Context var1);` in `TTAdManager` to create a TTAdNative's instance.

Use `void loadFullScreenVideoAd(AdSlot var1, @NonNull TTAdNative.FullScreenVideoAdListener var2);` in the TTAdNative's instance to load the ad.

After get the ad's load succeed callback by the listener, use `TTFullScreenVideoAd`'s `void showFullScreenVideoAd(Activity var1);` to show the ad.

#### 2.Get load's callback from the listener

`FullScreenVideoAdListener` is the listener indicates the result of ad's load.

| methods | description |
| :--- | :--- |
| onError(i: Int, msg: String) | This method is invoked when an ad fails to load.  |
| void onFullScreenVideoAdLoad(TTFullScreenVideoAd var1); | Ad load succeed(video content is no cached), can show ad after here. |
| onFullScreenVideoCached(); | Ad load succeed and video content is cached, recommend to show ad after here. |


#### 3.Indicates interstitial video's status

When getting callback from `FullScreenVideoAdListener`, a `TTFullScreenVideoAd` will be sent in the callback method if load succeed.

`FullScreenVideoAdInteractionListener` in the `TTFullScreenVideoAd` is the listener to indicates the interstitial video's status.

| methods | description |
| :--- | :--- |
| onAdShow() |  This method is called when video has been shown. |
| onAdVideoBarClick() | This method is called when video ad is clicked. |
| onAdClose() | This method is called when video ad is closed. |
| onVideoComplete() | This method is called when video ad play completed. |
| onSkippedVideo() | This method is called when the user clicked skip button. |
