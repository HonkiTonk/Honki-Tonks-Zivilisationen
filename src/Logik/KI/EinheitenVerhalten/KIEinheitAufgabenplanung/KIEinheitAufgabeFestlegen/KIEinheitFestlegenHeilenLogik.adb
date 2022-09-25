pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeEinheitenGebaut;

with KIDatentypen;

package body KIEinheitFestlegenHeilenLogik is

   function Heilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Hier eventuell Zielkoordinaten hinzufügen? Z. B. wenn im Krieg? Eventuell auf mögliche Stadt prüfen und ob es möglich ist diese zu erreichen? äöü
      -- Muss Gefahren und Einheitenart abhängig sein. äöü
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Einheit_Heilen_Enum);
      
      return True;
      
   end Heilen;

end KIEinheitFestlegenHeilenLogik;
