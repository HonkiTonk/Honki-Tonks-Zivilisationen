with EinstellungenSound;

package body SchreibeEinstellungenSound is

   procedure Lautstärke
     (LautstärkeExtern : in Float)
   is begin
      
      EinstellungenSound.Soundeinstellungen.Lautstärke := LautstärkeExtern;
      
   end Lautstärke;
   
   
   
   procedure GanzerEintrag
     (EintragExtern : in TonRecords.SoundeinstellungenRecord)
   is begin
      
      EinstellungenSound.Soundeinstellungen := EintragExtern;
      
   end GanzerEintrag;

end SchreibeEinstellungenSound;
