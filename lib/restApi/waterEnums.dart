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