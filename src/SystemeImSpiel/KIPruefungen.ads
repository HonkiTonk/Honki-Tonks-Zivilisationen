with GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, SchleifenPruefungen;
use GlobaleDatentypen;

package KIPruefungen is
   
   function SpezielleEinheitArtSuchen (Rasse, WelcheEinheitArt : in Integer) return Integer;
   function EinheitMitBewegungspunktenSuchen (Rasse : in Integer) return GlobaleDatentypen.EinheitStatusRecord;
   
private
   
end KIPruefungen;
