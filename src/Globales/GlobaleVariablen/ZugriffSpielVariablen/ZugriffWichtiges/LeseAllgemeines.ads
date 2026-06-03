with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypenHTSEB;

with SpeziesDatentypen;
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
   
   function SpezieszugNachLaden
     return SpeziesDatentypen.Spezies_Enum;
   pragma Inline (SpezieszugNachLaden);
   
   function Schwierigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum;
   pragma Inline (Schwierigkeitsgrad);
   
   function Rundenanzahl
     return SystemDatentypenHTSEB.EigenesPositive;
   pragma Inline (Rundenanzahl);
   
   function Rundengrenze
     return SystemDatentypenHTSEB.EigenesNatural;
   pragma Inline (Rundengrenze);
   
   function Ironman
     return Unbounded_Wide_Wide_String;
   pragma Inline (Ironman);
   
   function PlanetVernichtet
     return SpeziesDatentypen.Spezies_Enum;
   pragma Inline (PlanetVernichtet);
   
   function Zusammenbruchszeit
     return SystemDatentypenHTSEB.EigenerInteger;
   pragma Inline (Zusammenbruchszeit);
   
   function EingesetztePZB
     return SystemDatentypenHTSEB.EigenesNatural;
   pragma Inline (EingesetztePZB);
   
   function GanzerEintrag
     return SpielRecords.AllgemeinesRecord;
   pragma Inline (GanzerEintrag);

end LeseAllgemeines;
