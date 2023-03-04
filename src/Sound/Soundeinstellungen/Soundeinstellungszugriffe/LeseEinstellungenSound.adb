with EinstellungenSound;

package body LeseEinstellungenSound is

   function Lautstärke
     return Float
   is begin
      
      return EinstellungenSound.Soundeinstellungen.Lautstärke;
      
   end Lautstärke;
   
   
   
   function GanzerEintrag
     return TonRecords.SoundeinstellungenRecord
   is begin
      
      return EinstellungenSound.Soundeinstellungen;
      
   end GanzerEintrag;

end LeseEinstellungenSound;
