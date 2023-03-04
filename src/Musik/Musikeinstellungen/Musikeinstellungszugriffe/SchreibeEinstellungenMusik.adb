with EinstellungenMusik;

package body SchreibeEinstellungenMusik is

   procedure Lautstärke
     (LautstärkeExtern : in Float)
   is begin
      
      EinstellungenMusik.Musikeinstellungen.Lautstärke := LautstärkeExtern;
      
   end Lautstärke;
   
   
   
   procedure GanzerEintrag
     (EintrageExtern : in TonRecords.MusikeinstellungenRecord)
   is begin
      
      EinstellungenMusik.Musikeinstellungen := EintrageExtern;
      
   end GanzerEintrag;

end SchreibeEinstellungenMusik;
