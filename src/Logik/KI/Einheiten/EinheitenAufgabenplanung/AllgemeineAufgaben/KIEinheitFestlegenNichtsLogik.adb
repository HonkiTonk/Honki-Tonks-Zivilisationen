
with SchreibeEinheitenGebaut;

with KIDatentypen;

package body KIEinheitFestlegenNichtsLogik is

   procedure NichtsTun
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              AufgabeExtern              => KIDatentypen.Leer_Aufgabe_Enum);
      SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              BeschäftigungExtern        => EinheitenKonstanten.LeerBeschäftigung);
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               BewegungspunkteExtern      => EinheitenKonstanten.LeerBewegungspunkte,
                                               RechnenSetzenExtern        => False);
      
   end NichtsTun;

end KIEinheitFestlegenNichtsLogik;
