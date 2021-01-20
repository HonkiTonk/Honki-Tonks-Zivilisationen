with GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, SchleifenPruefungen, KIRecords;
use GlobaleDatentypen;

package KIPruefungen is
   
   function SpezielleEinheitArtSuchen (RasseExtern : in GlobaleDatentypen.Rassen; WelcheEinheitArt : in Positive) return Integer;
   function EinheitMitBewegungspunktenSuchen (RasseExtern : in GlobaleDatentypen.Rassen) return KIRecords.EinheitStatusRecord;
   
private

   
   
end KIPruefungen;
