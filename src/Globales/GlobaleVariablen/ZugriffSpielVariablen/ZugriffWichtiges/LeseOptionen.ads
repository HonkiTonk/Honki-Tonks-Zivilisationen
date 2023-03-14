with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecords;
with ZahlenDatentypen;

package LeseOptionen is
   pragma Elaborate_Body;
   
   function Sprache
     return Unbounded_Wide_Wide_String;
   pragma Inline (Sprache);
   
   function AnzahlAutospeichern
     return ZahlenDatentypen.EigenesNatural;
   pragma Inline (AnzahlAutospeichern);
   
   function RundenAutospeichern
     return ZahlenDatentypen.EigenesPositive;
   pragma Inline (RundenAutospeichern);

   function GanzerEintrag
     return SystemRecords.NutzerEinstellungenRecord;
   pragma Inline (GanzerEintrag);

end LeseOptionen;
