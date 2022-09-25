pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

with SchreibeEinheitenGebaut;

package body KIEinheitFestlegenNichtsLogik is

   function NichtsTun
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Tut_Nichts_Enum);
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern      => EinheitenKonstanten.LeerBeschäftigung);
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                               RechnenSetzenExtern      => 0);
      
      return True;
      
   end NichtsTun;

end KIEinheitFestlegenNichtsLogik;
