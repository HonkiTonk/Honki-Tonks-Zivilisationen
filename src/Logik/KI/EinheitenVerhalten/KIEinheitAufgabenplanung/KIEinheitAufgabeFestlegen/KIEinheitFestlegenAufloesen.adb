pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeEinheitenGebaut;

with KIDatentypen;

package body KIEinheitFestlegenAufloesen is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     return Boolean
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Einheit_Auflösen_Enum);
      
      return True;
      
   end EinheitAuflösen;

end KIEinheitFestlegenAufloesen;
