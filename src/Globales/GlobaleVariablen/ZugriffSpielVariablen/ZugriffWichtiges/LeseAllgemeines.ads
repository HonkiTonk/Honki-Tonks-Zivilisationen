with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SpeziesDatentypen;
with ZahlenDatentypen;
with SpielDatentypen;
with SpielRecords;

package LeseAllgemeines is
   pragma Elaborate_Body;

   function Gewonnen
     return Boolean;
   pragma Inline (Gewonnen);
   
   function Weiterspielen
     return Boolean;
   pragma Inline (Weiterspielen);
   
   function SpeziesAmzugNachLaden
     return SpeziesDatentypen.Spezies_Enum;
   pragma Inline (SpeziesAmzugNachLaden);
   
   function Schwierigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum;
   pragma Inline (Schwierigkeitsgrad);
   
   function Rundenanzahl
     return ZahlenDatentypen.EigenesPositive;
   pragma Inline (Rundenanzahl);
   
   function Rundengrenze
     return ZahlenDatentypen.EigenesNatural;
   pragma Inline (Rundengrenze);
   
   function Ironman
     return Unbounded_Wide_Wide_String;
   pragma Inline (Ironman);
   
   function PlanetVernichtet
     return SpeziesDatentypen.Spezies_Enum;
   pragma Inline (PlanetVernichtet);
   
   function Zusammenbruchszeit
     return ZahlenDatentypen.EigenerInteger;
   pragma Inline (Zusammenbruchszeit);
   
   function AnzahlEingesetzterPZB
     return ZahlenDatentypen.EigenesNatural;
   pragma Inline (AnzahlEingesetzterPZB);
   
   function GanzerEintrag
     return SpielRecords.AllgemeinesRecord;
   pragma Inline (GanzerEintrag);

end LeseAllgemeines;
