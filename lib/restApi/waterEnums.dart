enum WaterStationType { manual, smart }

enum OfferedWatertype {
  mineral,
  tap,
  mineralAndTap,
}

WaterStationType getWaterStationType(String typeString) {

  switch (typeString) {
    case "MANUAL":
      return WaterStationType.manual;
    case "SMART":
      return WaterStationType.smart;
    default:
      throw Exception("Invalid water station type: $typeString");
  }
}

OfferedWatertype getOfferedWatertype(String typeString) {
  switch (typeString) {
    case "MINERAL":
      return OfferedWatertype.mineral;
    case "TAP":
      return OfferedWatertype.tap;
    case "MINERALTAP":
      return OfferedWatertype.mineralAndTap;
    default:
      throw Exception("Invalid water type: $typeString");
  }
}

String offeredWaterTypeToString(OfferedWatertype waterType) {
  String waterTypeAsString;
  switch (waterType) {
    case OfferedWatertype.mineral:
      return waterTypeAsString = "Mineralwasser";
    case OfferedWatertype.tap:
      return waterTypeAsString = "Leitungswasser";
    case OfferedWatertype.mineralAndTap:
      return waterTypeAsString = "Mineralwasser, Leitungswasser";
  }
}

String waterStationTypeToString(WaterStationType waterType) {
  String waterTypeAsString;
  switch (waterType) {
    case WaterStationType.manual:
      return waterTypeAsString = "Manuele Wasserstation";
    case WaterStationType.smart:
      return waterTypeAsString = "Smarte Wasserstation";
  }
}
