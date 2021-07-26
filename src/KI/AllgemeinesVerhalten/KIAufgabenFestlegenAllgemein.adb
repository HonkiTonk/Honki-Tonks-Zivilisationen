pragma SPARK_Mode (On);

with KIDatentypen;

package body KIAufgabenFestlegenAllgemein is

   procedure Heilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Heilen;
      
   end Heilen;
   
   
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Verbessern;
      
   end EinheitVerbessern;

end KIAufgabenFestlegenAllgemein;
