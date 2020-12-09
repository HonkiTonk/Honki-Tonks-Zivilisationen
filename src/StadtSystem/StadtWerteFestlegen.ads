with GlobaleVariablen, SchleifenPruefungen, GlobaleDatentypen;

package StadtWerteFestlegen is

   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; Rasse, StadtNummer : in Integer);

   function StadtumgebungsgrößeFestlegen (Rasse, StadtNummer : in Integer) return Integer;

private
   
   NutzbarerBereich : Integer;
   KartenWert : GlobaleDatentypen.YWertXWertAusKartenfeld;

end StadtWerteFestlegen;
