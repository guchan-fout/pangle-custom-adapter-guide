# 2. Native Ads

Here is the common methods and delegate to use for building pangle's native adapter.


* [Create placement](#start/native_ad_origin)
* [Loading Ads](#start/native_ad_load)
* [All elements for native Ads](#start/native_ad_element)


Please [initialize the Pangle SDK](1_prerequisites_initialize) before loading ads.

<a name="start/native_ad_origin"></a>
## Create placement


On Pangle platform, create an **Origin** ad in the app, you will get a **placement ID** for ad's loading.

<img src="pics/native_origin.png" alt="drawing" width="200"/>



<a name="start/native_ad_load"></a>
### Loading Ads

#### 1.Load a banner

Create a `AdSlot` instance with the placementID.

In your application, create a `slot` for setting size and type for the ad and  use `TTAdNative` to load ads.

```java
AdSlot adSlot = new AdSlot.Builder()
        .setCodeId("Your_Ad_Placement_Id")
        .build();
```

Use `TTAdNative createAdNative(Context var1);` in `TTAdManager` to create a TTAdNative's instance.

Use ` void loadFeedAd(AdSlot var1, @NonNull TTAdNative.FeedAdListener var2);` in the TTAdNative's instance to load the ad.

`TTAdNative.FeedAdListener` will be informed about the load status.

#### 2.Get callback from the ad loader listener

`TTAdNative.FeedAdListener` indicates the result of ad's load.

| methods | description |
| :--- | :--- |
| onError(i: Int, msg: String) | This method is invoked when an ad fails to load.  |
| void onFeedAdLoad(List<TTFeedAd> var1);| Ad load succeeded. TTFeedAd is the intance of the native ad |


<a name="start/native_ad_element"></a>
### All elements for native Ads

From `void onFeedAdLoad(List<TTFeedAd> var1);`,<br> you can get a list of **`TTFeedAd`** instance. All contents for the native ad are in this instance.

#### Elements in TTFeedAd

| parameters/methods | description |
| :--- | :--- |
| Bitmap getAdLogo();| Ad provider(Pangle)'s logo. |
| String getTitle();| Ad's description.  |
| String getDescription(); | Ad's description.  |
| String getButtonText(); | The text for the button. |
| int getImageMode(); | Type of ad's main content.<br> If type is equal to `IMAGE_MODE_VIDEO`/`IMAGE_MODE_VIDEO_SQUARE`/`IMAGE_MODE_VIDEO_VERTICAL` in the `TTAdConstant`, it means main content is a video, and video content is in the `View getAdView();`. Otherwise it's an image ad. |
| List<TTImage> getImageList(); | You can get image ad's image url from here. |
| View getAdLogoView(); | You can get ad's icon url from here. |
| void registerViewForInteraction(@NonNull ViewGroup var1, @NonNull View var2, TTNativeAd.AdInteractionListener var3); |  This is a **must be** set method to enable ad's click action |

`TTNativeAd.AdInteractionListener` in the registerViewForInteraction is the listener to get ad's action callback.

| parameters | when be called by pangle sdk |
| :--- | :--- |
| void onAdClicked(View var1, TTNativeAd var2); | When the ad is clicked |
|  void onAdCreativeClick(View var1, TTNativeAd var2); | When the ad's creatvie is clicked |
| void onAdShow(TTNativeAd var1); | When the ad is showed |
