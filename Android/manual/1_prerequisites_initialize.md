# Prerequisites and Initialize

This guide is for you to build Pangle Android SDK's mediation for your adnetwork.

## Prerequisites
* minSdkVersion 14 or higher
* targetSdkVersion 29 or higher
* Create a Pangle account [here](https://www.pangleglobal.com/)(If you do not have one), and add your app and placements.
* From V3.4.0.0, we added a `<queries>` element to support Android 11(API level 30), please upgrade Android Gradle plugin to 4.1+ or following versions.

  |  Support `<queries>` Gradle Versions  |
  | ---- |
  |  4.0.1 |
  |  3.6.4 |
  |  3.5.4 |
  |  3.4.3 |
  |  3.3.3 |

## Update the Android Manifest
  Add following permissions and **provider** to your app's `AndroidManifest.xml`.

  > :warning: Please make sure to add **provider** or ad's loading will not work properly.


  ```xml

  <?xml version="1.0" encoding="utf-8"?>
  <manifest xmlns:android="http://schemas.android.com/apk/res/android"
      package="xxxxxxxx">

      <!--Required  permissions-->
      <uses-permission android:name="android.permission.INTERNET" />
      <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
      <!-- If there is a video ad and it is played with textureView, please be sure to add this, otherwise a black screen will appear -->
      <uses-permission android:name="android.permission.WAKE_LOCK" />

      <application
          ...
          <!--Required->
          <provider
              android:name="com.bytedance.sdk.openadsdk.multipro.TTMultiProvider"
              android:authorities="${applicationId}.TTMultiProvider"
              android:exported="false" />

          ...

      </application>

  </manifest>

  ```

## Initialize

`TTAdConfig` is the class to set the information for SDK's initialize.

| parameters | description |
| :--- | :--- |
| appId | AppID is used to identify your app after you add an app on pangle's platform. |
| appName | Set the value of `Context.getPackageName()` to this parameter.  |
| debug | Set to `true` will show debug logs to help debugging. |
| useTextureView | The default setting is SurfaceView in the SDK. <br> Set to `true` will switch to use TextureView to play the video and you need to add **"WAKE_LOCK"** permission in the manifest.|
| coppa | 0:adult ，1:child |
| setGDPR | 0: disable GDRP Privacy protection ; 1: enable GDRP Privacy protection. |

`public static TTAdManager init(Context var0, TTAdConfig var1` in Class 'TTAdSdk' is the method for initializing Pangle SDK with a Context instance and the `TTAdConfig`'s instance as the arguments.

`TTAdSdk.init()` only need to be called once per app’s lifecycle, we strongly recommend to do this on app launch.
