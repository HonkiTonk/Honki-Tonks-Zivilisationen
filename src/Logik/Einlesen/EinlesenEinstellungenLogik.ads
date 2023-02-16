with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SpezieseinstellungenGrafik;
private with SystemRecords;
private with TexteinstellungenGrafik;
private with GrafikRecords;

package EinlesenEinstellungenLogik is
   pragma Elaborate_Body;

   procedure EinlesenEinstellungen;
   
private
   
   Nullwert : Boolean;
   PrüfungErfolgreich : Boolean;
      
   DateiNutzereinstellungen : File_Type;
   DateiGrafikeinstellungen : File_Type;
   DateiSoundeinstellungen : File_Type;
      
   ZwischenspeicherNutzereinstellungen : SystemRecords.NutzerEinstellungenRecord;
   
   Fenstereinstellungen : GrafikRecords.FensterRecord;
   
   ZwischenspeicherGrafikeinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   Schriftgrößen : TexteinstellungenGrafik.SchriftgrößenArray;
   
   Schriftfarben : TexteinstellungenGrafik.SchriftfarbenArray;
   
   Speziesfarben : SpezieseinstellungenGrafik.SpeziesFarbenArray;
   Rahmenfarben : SpezieseinstellungenGrafik.SpeziesFarbenArray;
   
   procedure Nutzereinstellungen;
   procedure Grafikeinstellungen;
   procedure Soundeinstelllungen;
   
   
   
   function NutzereinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function GrafikeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function SoundeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;

end EinlesenEinstellungenLogik;
