with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

with SchreibeEinheitenGebaut;

package body KIEinheitFestlegenNichtsLogik is

   procedure NichtsTun
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern      => EinheitenKonstanten.LeerBeschäftigung);
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                               RechnenSetzenExtern      => False);
      
   end NichtsTun;

end KIEinheitFestlegenNichtsLogik;
