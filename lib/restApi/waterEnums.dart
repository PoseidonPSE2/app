enum WaterStationType { manual, smart }

enum OfferedWatertype {
  mineral,
  tap,
  mineralAndTap,
}

WaterStationType getWaterStationType(String typeString) {
  switch (typeString) {
    case "manual":
      return WaterStationType.manual;
    case "smart":
      return WaterStationType.smart;
    default:
      throw Exception("Invalid water station type: $typeString");
  }
}

OfferedWatertype getOfferedWatertype(String typeString) {
  switch (typeString) {
    case "mineral":
      return OfferedWatertype.mineral;
    case "tap":
      return OfferedWatertype.tap;
    case "both":
      return OfferedWatertype.mineralAndTap;
    default:
      throw Exception("Invalid water type: $typeString");
  }
}

String offeredWaterTypeToString(OfferedWatertype waterType) {
  switch (waterType) {
    case OfferedWatertype.mineral:
      return "Mineralwasser";
    case OfferedWatertype.tap:
      return "Leitungswasser";
    case OfferedWatertype.mineralAndTap:
      return "Mineralwasser, Leitungswasser";
  }
}

String waterStationTypeToString(WaterStationType waterType) {
  switch (waterType) {
    case WaterStationType.manual:
      return "Manuele Wasserstation";
    case WaterStationType.smart:
      return "Smarte Wasserstation";
  }
}
