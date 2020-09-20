with GlobaleVariablen;

package StadtWerteFestlegen is

   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; Rasse, StadtNummer : in Integer);

   function StadtumgebungsgrößeFestlegen (Rasse, StadtNummer : in Integer) return Integer;

private
   
   NutzbarerBereich : Integer;

end StadtWerteFestlegen;
