with SchreibeEinheitenGebaut;

with KIDatentypen;

package body KIEinheitFestlegenBefestigenLogik is

   function Befestigen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Hier auch ein Ziel festlegen lassen? Z. B. auf einer besseren Position mit mehr Vorteilen? äöü
      -- Muss Gefahren und Einheitenart abhängig sein. äöü
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                             AufgabeExtern              => KIDatentypen.Einheit_Festsetzen_Enum);
      
      return True;
      
   end Befestigen;

end KIEinheitFestlegenBefestigenLogik;
