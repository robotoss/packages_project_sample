enum Flavor {
  HELLO,
  GOODBYE,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.HELLO:
        return 'Hello App';
      case Flavor.GOODBYE:
        return 'Goodbye App';
      default:
        return 'title';
    }
  }

}
