pragma SPARK_Mode (On);

with EinheitenDatenbank;

package body DatenbankVereinfachung is -- Im Prinzip für alles Möglichkeiten eine Vereinfachung, oder? Nach verschiedenen Bereichen aufteilen?

   function EinheitenIDVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenID
   is begin
      
      EinheitID := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID;
      
      return EinheitID;
      
   end EinheitenIDVereinfachung;
   
   
   
   function EinheitenListeGrafikVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Wide_Wide_Character
   is begin
      
      EinheitID := EinheitenIDVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      EinheitenGrafik := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).EinheitenGrafik;
      
      return EinheitenGrafik;
      
   end EinheitenListeGrafikVereinfachung;

end DatenbankVereinfachung;
