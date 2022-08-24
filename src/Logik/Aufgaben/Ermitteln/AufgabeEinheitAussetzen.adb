pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;

with SchreibeEinheitenGebaut;

package body AufgabeEinheitAussetzen is

   function RundeAussetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                               RechnenSetzenExtern      => 0);
      
      return True;
      
   end RundeAussetzen;

end AufgabeEinheitAussetzen;
