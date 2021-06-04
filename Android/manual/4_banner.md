# Banner Ads

Here is the common methods and delegate to use for building pangle's banner adapter.

  * [Create placement](#start/create_placement)
  * [Loading Ads](#start/template_banner_ad_load)


Please [initialize the Pangle SDK](1_prerequisites_initialize) before loading ads.


<a name="start/create_placement"></a>
### Create the placement for banner ad

On Pangle platform, create an **Banner Ads** ad in the app.

Plase set **Template** at [Native type].

You will get a **placement ID** for ad's loading.

<img src="pics/template_banner_add.png" alt="drawing" width="200"/>

**Please select 300 * 250 (600 * 500 px)  for 300*250.**

<img src="pics/template_banner_set_300.png" alt="drawing" width="200"/>

**Please select 320 * 50 (640 * 100 px)  for 320*50.**

<img src="pics/template_banner_set_320.png" alt="drawing" width="200"/>

<a name="start/template_banner_ad_load"></a>
### Loading Ads

#### 1.Load a banner

Create a `AdSlot` instance with the placementID.

`setExpressViewAcceptedSize` is **required**. Please set the banner's width and height here.

```java
AdSlot adSlot = new AdSlot.Builder()
        .setCodeId("Your_Ad_Placement_Id")
        .setExpressViewAcceptedSize(banner's width, banner's height)
        .build();
```

Use `TTAdNative createAdNative(Context var1);` in `TTAdManager` to create a TTAdNative's instance.

Use ` void loadBannerExpressAd(AdSlot var1, @NonNull TTAdNative.NativeExpressAdListener var2);` in the TTAdNative's instance to load the ad.

`TTAdNative.NativeExpressAdListener` will be informed about the load status.


#### 2.Get callback from the ad loader listener

`TTAdNative.NativeExpressAdListener` indicates the result of ad's load.

| methods | description |
| :--- | :--- |
| onError(i: Int, msg: String) | This method is invoked when an ad fails to load.  |
| void onNativeExpressAdLoad(List<TTNativeExpressAd> var1);| A banner list loaded, get the element in it and **must** call `void render();` and set `void setExpressInteractionListener(TTNativeExpressAd.ExpressAdInteractionListener var1);` to render the ad and get render status. |

* The TTNativeExpressAd's instance here is not ready to be displayed. Need to call `render()`. Rendering status will be informed from `TTNativeExpressAd.ExpressAdInteractionListener`.

#### 3.Get callback from the ad render listener

`TTNativeExpressAd.ExpressAdInteractionListener` indicates the result of ad's load.

| methods | when be called by pangle sdk |
| :--- | :--- |
| void onRenderSuccess(View var1, float var2, float var3); | Ad rendering succeeded, the view can be added and displayed. |
| void onRenderFail(View var1, String var2, int var3); | Ad rendering failed |
| void onAdShow(View var1, int var2); | When the ad is showed |
| void onAdClicked(View var1, int var2); | When the ad is clicked  |


##### Basic callback for common use:

| methods | when be called by pangle sdk |
| :--- | :--- |
| - (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView; | Ad load succeed but not rendered yet |
| - (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error; | Ad load failed |
| - (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView; | Ad rendered successfully and `bannerAdView` ready to be show |
| - (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error; | Ad failed on render   |
| - (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView; | When the ad is clicked |

##### All callback interface

```obj-c
@protocol BUNativeExpressBannerViewDelegate <NSObject>

@optional
/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 */
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView;

/**
 This method is called when bannerAdView ad slot failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView;

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error;

/**
 This method is called when bannerAdView ad slot showed new ad.
 */
- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView;

/**
 This method is called when bannerAdView is clicked.
 */
- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView;

/**
 This method is called when the user clicked dislike button and chose dislike reasons.
 @param filterwords : the array of reasons for dislike.
 */
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType;

@end
```
