import 'package:facebook_audience_network/facebook_audience_network.dart';

import '../Helper/Constant.dart';

bool isInterstitialAdLoaded = false;
bool isRewardedAdLoaded = false;

class FaceBookAdds {
  innitialize() {
    FacebookAudienceNetwork.init(
      testingId: facebockID,
      iOSAdvertiserTrackingEnabled: true,
    );
  }

  void loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
          /// Once a Rewarded Ad has been closed and becomes invalidated,
          /// load a fresh Ad by calling this function.
          if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
              (value == true || value["invalidated"] == true)) {
            isRewardedAdLoaded = false;
            loadRewardedVideoAd();
          }
        }
      },
    );
  }

  void loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          isInterstitialAdLoaded = true;
        }

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
        
          isInterstitialAdLoaded = false;
          loadInterstitialAd();
        }
      },
    );
  }

  showInterstitialAd() {
    if (isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
    } else {
     }
  }


}
