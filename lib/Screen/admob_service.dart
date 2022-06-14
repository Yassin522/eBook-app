import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Helper/Constant.dart';

// const String testDevice = '0b60a0dc8901ca7b635b7294ef48b01a';

///https://stackoverflow.com/questions/50972863/admob-banner-how-to-show-only-on-home
///
class AdmobService {
  static BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? rewardadd;
  static BannerAd get bannerAd => _bannerAd!;
  static String get bannerAdUnitId =>
      Platform.isAndroid ? bannerAdUnitIdAdnroid : bannerAdUnitIdIos;

  static String get iOSInterstitialAdUnitID => Platform.isAndroid
      ? interstitialAdUnitIDAndroid
      : interstitialAdUnitIDIos;

  static BannerAd createBannerAd() {
    BannerAd ad = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.largeBanner,
      request: const AdRequest(
        // keywords: <String>['foo', 'bar'],
        // contentUrl: 'http://foo.com/bar.html',
        nonPersonalizedAds: true,
      ),
      //listener: null,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed'),
      ),
    );

    return ad;
  }

  static void showBannerAd() {
    if (_bannerAd != null) {
      return;
    }
    _bannerAd = createBannerAd();
    _bannerAd!.load();
  }

  void disposeAds() {
    if (_bannerAd != null) {
      _bannerAd?.dispose();
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: iOSInterstitialAdUnitID,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd = null;
            _createInterstitialAd();
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      };
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      };
      
      }
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(
        nonPersonalizedAds: true,
      ),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardadd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          rewardadd = null;
          createRewardedAd();
        },
      ),
    );
  }
}
