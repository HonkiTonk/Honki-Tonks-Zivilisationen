with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecords;
with SystemDatentypenHTSEB;

package SchreibeOptionen is
   pragma Elaborate_Body;

   procedure Sprache
     (SpracheExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => SpracheExtern)'Length >= 1
              );
   pragma Inline (Sprache);
   
   procedure Texturen
     (TexturenExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => TexturenExtern)'Length >= 1
              );
   pragma Inline (Texturen);
   
   procedure Musik
     (MusikExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => MusikExtern)'Length >= 1
              );
   pragma Inline (Musik);
   
   procedure Sound
     (SoundExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => SoundExtern)'Length >= 1
              );
   pragma Inline (Sound);
   
   procedure AnzahlAutospeichern
     (AutospeicheranzahlExtern : in SystemDatentypenHTSEB.EigenesNatural);
   pragma Inline (AnzahlAutospeichern);
   
   procedure RundenAutospeichern
     (RundenanzahlExtern : in SystemDatentypenHTSEB.EigenesPositive);
   pragma Inline (RundenAutospeichern);
   
   procedure Dezimaltrennzeichen
     (ZeichenExtern : in Wide_Wide_Character);
   pragma Inline (Dezimaltrennzeichen);
   
   procedure SicherheitsfragenAnzeigen
     (JaNeinExtern : in Boolean);
   pragma Inline (SicherheitsfragenAnzeigen);

   procedure GanzeSpieleinstellungen
     (EinstellungenExtern : in SystemRecords.NutzerEinstellungenRecord);
   pragma Inline (GanzeSpieleinstellungen);
   
   procedure AktuellerAutospeichernwert
     (AutospeichernwertExtern : in SystemDatentypenHTSEB.EigenesPositive);
   pragma Inline (AktuellerAutospeichernwert);
   
   procedure GanzeSpielendeEinstellungen
     (EinstellungenExtern : in SystemRecords.SpielendeEinstellungenRecord);
   pragma Inline (GanzeSpielendeEinstellungen);

end SchreibeOptionen;
