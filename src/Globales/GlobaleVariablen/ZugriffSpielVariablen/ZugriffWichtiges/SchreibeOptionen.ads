with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecords;
with ZahlenDatentypen;

package SchreibeOptionen is
   pragma Elaborate_Body;

   procedure Sprache
     (SpracheExtern : in Unbounded_Wide_Wide_String);
   
   procedure AnzahlAutospeichern
     (AutospeicheranzahlExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure RundenAutospeichern
     (RundenanzahlExtern : in ZahlenDatentypen.EigenesPositive);

   procedure GanzerEintrag
     (EintragExtern : in SystemRecords.NutzerEinstellungenRecord);

end SchreibeOptionen;
