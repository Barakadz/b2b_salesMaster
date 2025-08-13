class CatalogueOffer {
  int index;
  String name;
  List<OffersCategorie> subServices = [];
  String svgPath;

  CatalogueOffer(
      {required this.index,
      required this.name,
      required this.subServices,
      required this.svgPath});
}

class OffersCategorie {
  int index;
  String name;
  String svgPath;
  OffersCategorie(
      {required this.index, required this.name, required this.svgPath});
}

List<CatalogueOffer> services = [
  CatalogueOffer(
      index: 0,
      name: "Offres",
      svgPath: "assets/offres.svg",
      subServices: [
        // OffersCategorie(index: 0, name: "Djezzy", svgPath: "assets/djezzy.png"),
        // OffersCategorie(
        //     index: 1, name: "Ooredoo", svgPath: "assets/ooredoo.png"),
        // OffersCategorie(
        //     index: 2, name: "Mobilis", svgPath: "assets/mobilis.png"),
        // OffersCategorie(
        //     index: 3,
        //     name: "Algerie telecom",
        //     svgPath: "assets/algerie_telecom.png"),
      ]),
  CatalogueOffer(
      index: 1,
      name: "Services",
      subServices: [],
      svgPath: "assets/services.svg"),
  CatalogueOffer(
      index: 2,
      name: "Roaming",
      subServices: [],
      svgPath: "assets/roaming.svg"),
  CatalogueOffer(
      index: 3,
      name: "International",
      subServices: [],
      svgPath: "assets/international.svg"),
];
