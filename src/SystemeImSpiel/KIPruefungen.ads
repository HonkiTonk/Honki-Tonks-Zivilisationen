with GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, SchleifenPruefungen;
use GlobaleDatentypen;

package KIPruefungen is
   
   function SpezielleEinheitArtSuchen (RasseExtern, WelcheEinheitArt : in Integer) return Integer;
   function EinheitMitBewegungspunktenSuchen (RasseExtern : in Integer) return GlobaleDatentypen.EinheitStatusRecord;
   
private

   
   
end KIPruefungen;
