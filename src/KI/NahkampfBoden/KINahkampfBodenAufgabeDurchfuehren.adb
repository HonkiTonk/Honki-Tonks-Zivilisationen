pragma SPARK_Mode (On);

with KIDatentypen;

with Verbesserungen;

package body KINahkampfBodenAufgabeDurchfuehren is

   procedure NahkampfBodenAufgabeDurchfuehren
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt
      is
         when KIDatentypen.Stadt_Bewachen =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Verschanzen);
            
         when KIDatentypen.Verbesserung_Zerstören =>
            null;
            
         when KIDatentypen.Flucht =>
            null;
            
         when KIDatentypen.Einheit_Heilen =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Heilen);
            
         when KIDatentypen.Einheit_Festsetzen =>
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => GlobaleDatentypen.Verschanzen);
            
         when KIDatentypen.Einheit_Verbessern =>
            null;
            
         when KIDatentypen.Angreifen =>
            null;
            
         when others =>
            null;
      end case;
      
   end NahkampfBodenAufgabeDurchfuehren;

end KINahkampfBodenAufgabeDurchfuehren;
