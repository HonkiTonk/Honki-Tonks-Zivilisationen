with SystemRecordKonstanten;

package body OptionenVariablen is

   procedure StandardeinstellungenLaden
   is begin
      
      NutzerEinstellungen := SystemRecordKonstanten.StandardNutzereinstellungen;
      
   end StandardeinstellungenLaden;

end OptionenVariablen;
