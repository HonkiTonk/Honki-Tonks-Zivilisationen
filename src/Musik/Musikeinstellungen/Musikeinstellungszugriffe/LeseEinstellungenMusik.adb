with EinstellungenMusik;

package body LeseEinstellungenMusik is

   function Lautstärke
     return Float
   is begin
      
      return EinstellungenMusik.Musikeinstellungen.Lautstärke;
      
   end Lautstärke;
   
   
   
   function GanzerEintrag
     return TonRecords.MusikeinstellungenRecord
   is begin
      
      return EinstellungenMusik.Musikeinstellungen;
      
   end GanzerEintrag;

end LeseEinstellungenMusik;
