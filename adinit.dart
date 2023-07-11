import 'package:google_mobile_ads/google_mobile_ads.dart';

class Adinit {
  static BannerAd banner = BannerAd(
      size: AdSize.banner,
      adUnitId: 'xxxxxxxxxxxxxxxxxxxxxxxxxx',
      listener: BannerAdListener(),
      request: AdRequest());
}
