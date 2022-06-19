pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with KartenRecords; use KartenRecords;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with KIBewegungDurchfuehren;
with KIAufgabenPlanung;

package body KIEinheitAllgemeines is

   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerID
        or
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) <= EinheitenKonstanten.LeerBewegungspunkte
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen_Enum
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.LeerKoordinate
      then
         return True;
            
      else
         return False;
      end if;
      
   end HandlungBeendet;
   
   
   
   procedure BewegungAufgabenplanung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
      then
         KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Tut_Nichts_Enum
      then
         KIAufgabenPlanung.AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         null;
      end if;
      
   end BewegungAufgabenplanung;

end KIEinheitAllgemeines;
