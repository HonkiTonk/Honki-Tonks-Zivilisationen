with GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, SchleifenPruefungen;
use GlobaleDatentypen;

package KIPruefungen is
   
   function SpezielleEinheitArtSuchen (RasseExtern, WelcheEinheitArt : in Integer) return Integer
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   function EinheitMitBewegungspunktenSuchen (RasseExtern : in Integer) return GlobaleDatentypen.EinheitStatusRecord
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   
private

   
   
end KIPruefungen;
