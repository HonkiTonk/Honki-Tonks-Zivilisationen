with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RassenDatentypen;
with ZahlenDatentypen;
with SpielDatentypen;

package LeseAllgemeines is
   pragma Elaborate_Body;

   function Gewonnen
     return Boolean;
   
   function Weiterspielen
     return Boolean;
   
   function RasseAmzugNachLaden
     return RassenDatentypen.Rassen_Enum;
   
   function Schwierigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum;
   
   function Rundenanzahl
     return ZahlenDatentypen.EigenesPositive;
   
   function Rundengrenze
     return ZahlenDatentypen.EigenesNatural;
   
   function Ironman
     return Unbounded_Wide_Wide_String;
   
   function PlanetVernichtet
     return RassenDatentypen.Rassen_Enum;
   
   function Zusammenbruchszeit
     return ZahlenDatentypen.EigenerInteger;
   
   function AnzahlEingesetzterPZB
     return ZahlenDatentypen.EigenesNatural;

end LeseAllgemeines;
