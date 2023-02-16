with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecords;
with ZahlenDatentypen;

package LeseOptionen is
   pragma Elaborate_Body;
   
   function Sprache
     return Unbounded_Wide_Wide_String;
   
   function AnzahlAutospeichern
     return ZahlenDatentypen.EigenesNatural;
   
   function RundenAutospeichern
     return ZahlenDatentypen.EigenesPositive;

   function GanzerEintrag
     return SystemRecords.NutzerEinstellungenRecord;

end LeseOptionen;
