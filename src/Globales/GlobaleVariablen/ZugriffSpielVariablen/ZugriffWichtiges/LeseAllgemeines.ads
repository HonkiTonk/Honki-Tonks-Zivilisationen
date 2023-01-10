with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SpeziesDatentypen;
with ZahlenDatentypen;
with SpielDatentypen;
with SpielRecords;

package LeseAllgemeines is
   pragma Elaborate_Body;

   function Gewonnen
     return Boolean;
   
   function Weiterspielen
     return Boolean;
   
   function SpeziesAmzugNachLaden
     return SpeziesDatentypen.Spezies_Enum;
   
   function Schwierigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum;
   
   function Rundenanzahl
     return ZahlenDatentypen.EigenesPositive;
   
   function Rundengrenze
     return ZahlenDatentypen.EigenesNatural;
   
   function Ironman
     return Unbounded_Wide_Wide_String;
   
   function PlanetVernichtet
     return SpeziesDatentypen.Spezies_Enum;
   
   function Zusammenbruchszeit
     return ZahlenDatentypen.EigenerInteger;
   
   function AnzahlEingesetzterPZB
     return ZahlenDatentypen.EigenesNatural;
   
   function GanzerEintrag
     return SpielRecords.AllgemeinesRecord;

end LeseAllgemeines;
