with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SpezieseinstellungenGrafik;
private with SystemRecords;
private with TexteinstellungenGrafik;
private with GrafikRecords;
private with TonRecords;

package EinlesenEinstellungenLogik is
   pragma Elaborate_Body;

   procedure EinlesenEinstellungen;
   
private
   
   Nullwert : Boolean;
      
   DateiNutzereinstellungen : File_Type;
   DateiGrafikeinstellungen : File_Type;
   DateiSoundeinstellungen : File_Type;
   DateiSonstigeEinstellungen : File_Type;
         
   ZwischenspeicherNutzereinstellungen : SystemRecords.NutzerEinstellungenRecord;
   
   Fenstereinstellungen : GrafikRecords.FensterRecord;
   
   ZwischenspeicherSonstigeEinstellungen : SystemRecords.SonstigeEinstellungenRecord;
   
   ZwischenspeicherGrafikeinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   Schriftgrößen : TexteinstellungenGrafik.SchriftgrößenArray;
   
   Schriftfarben : TexteinstellungenGrafik.SchriftfarbenArray;
   
   Speziesfarben : SpezieseinstellungenGrafik.SpeziesFarbenArray;
   Rahmenfarben : SpezieseinstellungenGrafik.SpeziesFarbenArray;
   
   Soundeinstellungen : TonRecords.SoundeinstellungenRecord;
   
   Musikeinstellungen : TonRecords.MusikeinstellungenRecord;
   
   procedure Nutzereinstellungen;
   procedure Grafikeinstellungen;
   procedure Toneinstelllungen;
   procedure SonstigeEinstellungen;
   
   
   
   function NutzereinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function GrafikeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function ToneinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function SonstigeEinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenEinstellungenLogik;
