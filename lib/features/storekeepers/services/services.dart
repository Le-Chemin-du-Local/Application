mixin Services {
  static const String clickAndCollect = "CLICKANDCOLLECT"; 
  static const String paniers = "PANIERS"; 

  static bool hasClickAndCollect(List<String> services) {
    return services.contains(clickAndCollect + "_M")
      || services.contains(clickAndCollect + "_M_UPDATE")
      || services.contains(clickAndCollect + "_M_REMOVE") 
      || services.contains(clickAndCollect + "_T");
  }
  
  static bool hasPaniers(List<String> services) {
    return services.contains(paniers + "_M")
      || services.contains(paniers + "_M_UPDATE")
      || services.contains(paniers + "_M_REMOVE") 
      || services.contains(paniers + "_T");
  }
}