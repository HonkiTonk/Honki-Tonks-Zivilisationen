with GlobaleVariablen, SchleifenPruefungen, GlobaleDatentypen, Karten;
use GlobaleDatentypen;

package StadtWerteFestlegen is

   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;

   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; Rasse, StadtNummer : in Integer);
   procedure StadtUmgebungGrößeFestlegen (Rasse, StadtNummer : in Integer);

private
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   KartenWert : GlobaleDatentypen.AchsenAusKartenfeld;

end StadtWerteFestlegen;
