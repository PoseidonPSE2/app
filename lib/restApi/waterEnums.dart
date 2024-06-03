enum WaterStationType { manual, smart }

enum OfferedWatertype {
  mineral,
  tap,
  mineralAndTap,
}

WaterStationType getWaterStationType(String typeString) {
  String type = typeString.toLowerCase();
  switch (type) {
    case "manual":
      return WaterStationType.manual;
    case "smart":
      return WaterStationType.smart;
    default:
      throw Exception("Invalid water station type: $typeString");
  }
}

OfferedWatertype getOfferedWatertype(String typeString) {
  String type = typeString.toLowerCase();
  switch (type) {
    case "mineral":
      return OfferedWatertype.mineral;
    case "tap":
      return OfferedWatertype.tap;
    case "mineral, tap":
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
