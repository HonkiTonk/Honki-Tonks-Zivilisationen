private with Ada.Streams.Stream_IO;

package EinlesenToneinstellungenLogik is
   pragma Elaborate_Body;
   
   procedure Toneinstelllungen;
   
private
   use Ada.Streams.Stream_IO;
   
   Nullwert : Boolean;
   
   DateiToneinstellungen : File_Type;
   
   Soundlautstärke : Float;
   Musiklautstärke : Float;
   
   
   function ToneinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenToneinstellungenLogik;
