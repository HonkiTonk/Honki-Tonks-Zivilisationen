with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with TonRecords;

package EinlesenToneinstellungenLogik is
   pragma Elaborate_Body;
   
   procedure Toneinstelllungen;
   
private
   
   Nullwert : Boolean;
   
   DateiSoundeinstellungen : File_Type;
   
   Soundeinstellungen : TonRecords.SoundeinstellungenRecord;
   
   Musikeinstellungen : TonRecords.MusikeinstellungenRecord;
   
   
   
   function ToneinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenToneinstellungenLogik;
