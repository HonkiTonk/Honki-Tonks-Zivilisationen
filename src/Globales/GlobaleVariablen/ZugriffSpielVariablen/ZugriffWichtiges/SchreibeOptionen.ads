with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecords;
with ZahlenDatentypen;

package SchreibeOptionen is
   pragma Elaborate_Body;

   procedure Sprache
     (SpracheExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => SpracheExtern)'Length >= 1
              );
   pragma Inline (Sprache);
   
   procedure AnzahlAutospeichern
     (AutospeicheranzahlExtern : in ZahlenDatentypen.EigenesNatural);
   pragma Inline (AnzahlAutospeichern);
   
   procedure RundenAutospeichern
     (RundenanzahlExtern : in ZahlenDatentypen.EigenesPositive);
   pragma Inline (RundenAutospeichern);

   procedure GanzerEintrag
     (EintragExtern : in SystemRecords.NutzerEinstellungenRecord);
   pragma Inline (GanzerEintrag);

end SchreibeOptionen;
