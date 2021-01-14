with GlobaleVariablen, SchleifenPruefungen, GlobaleDatentypen, Karten;
use GlobaleDatentypen;

package StadtWerteFestlegen is

   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;

   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; RasseExtern, StadtNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure StadtUmgebungGrößeFestlegen (RasseExtern, StadtNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

private
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   KartenWert : GlobaleDatentypen.AchsenAusKartenfeld;

end StadtWerteFestlegen;
