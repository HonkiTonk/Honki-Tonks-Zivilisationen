with SpielVariablen;

package body LeseAllgemeines is

   function Gewonnen
     return Boolean
   is begin
      
      return SpielVariablen.Allgemeines.Gewonnen;
      
   end Gewonnen;
   
   
   
   function Weiterspielen
     return Boolean
   is begin
      
      return SpielVariablen.Allgemeines.Weiterspielen;
      
   end Weiterspielen;
   
   
   
   function RasseAmzugNachLaden
     return RassenDatentypen.Rassen_Enum
   is begin
      
      return SpielVariablen.Allgemeines.RasseAmZugNachLaden;
      
   end RasseAmzugNachLaden;
   
   
   
   function Schwierigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum
   is begin
      
      return SpielVariablen.Allgemeines.Schwierigkeitsgrad;
      
   end Schwierigkeitsgrad;
   
   
   
   function Rundenanzahl
     return ZahlenDatentypen.EigenesPositive
   is begin
      
      return SpielVariablen.Allgemeines.Rundenanzahl;
      
   end Rundenanzahl;
   
   
   
   function Rundengrenze
     return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Allgemeines.Rundengrenze;
      
   end Rundengrenze;
   
   
   
   function Ironman
     return Unbounded_Wide_Wide_String
   is begin
      
      return SpielVariablen.Allgemeines.IronmanName;
      
   end Ironman;
   
   
   
   function PlanetVernichtet
     return RassenDatentypen.Rassen_Enum
   is begin
      
      return SpielVariablen.Allgemeines.PlanetVernichtet;
      
   end PlanetVernichtet;
   
   
   
   function AnzahlEingesetzterPZB
     return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Allgemeines.AnzahlEingesetzterPZB;
      
   end AnzahlEingesetzterPZB;
   
   
   
   function Zusammenbruchszeit
     return ZahlenDatentypen.EigenerInteger
   is begin
      
      return SpielVariablen.Allgemeines.Zusammenbruchszeit;
      
   end Zusammenbruchszeit;

end LeseAllgemeines;
