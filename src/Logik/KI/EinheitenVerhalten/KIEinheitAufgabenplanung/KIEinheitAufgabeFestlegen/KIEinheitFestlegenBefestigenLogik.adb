pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeEinheitenGebaut;

with KIDatentypen;

package body KIEinheitFestlegenBefestigenLogik is

   function Befestigen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     return Boolean
   is begin
      
      -- Hier auch ein Ziel festlegen lassen? Z. B. auf einer besseren Position mit mehr Vorteilen? äöü
      -- Muss Gefahren und Einheitenart abhängig sein. äöü
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Einheit_Festsetzen_Enum);
      
      return True;
      
   end Befestigen;

end KIEinheitFestlegenBefestigenLogik;
