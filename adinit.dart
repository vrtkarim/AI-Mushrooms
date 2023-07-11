import 'package:google_mobile_ads/google_mobile_ads.dart';

class Adinit {
  static BannerAd banner = BannerAd(
      size: AdSize.banner,
      //ca-app-pub-1082671244415442/8652708889
      adUnitId: 'ca-app-pub-1082671244415442/6851486133',
      listener: BannerAdListener(),
      request: AdRequest());
}
