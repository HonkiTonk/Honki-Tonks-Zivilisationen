with GlobaleVariablen, SchleifenPruefungen, GlobaleDatentypen;
use GlobaleDatentypen;

package StadtWerteFestlegen is

   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; Rasse, StadtNummer : in Integer);

   function StadtumgebungsgrößeFestlegen (Rasse, StadtNummer : in Integer) return GlobaleDatentypen.Kartenfeld;

private
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   KartenWert : GlobaleDatentypen.YWertXWertAusKartenfeld;

end StadtWerteFestlegen;
