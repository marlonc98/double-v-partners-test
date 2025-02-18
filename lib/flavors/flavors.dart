enum Flavor {
  dev,
  fake,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '[DEV] Secret Locations';
      case Flavor.fake:
        return '[FAKE] Secret Locations';
      case Flavor.prod:
        return 'Secret Locations';
      default:
        return 'title';
    }
  }

}
