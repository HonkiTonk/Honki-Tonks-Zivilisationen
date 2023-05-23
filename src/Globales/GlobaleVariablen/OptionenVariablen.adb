with SystemRecordKonstanten;

package body OptionenVariablen is

   procedure StandardNutzereinstellungenLaden
   is begin
      
      NutzerEinstellungen := SystemRecordKonstanten.StandardNutzereinstellungen;
      
   end StandardNutzereinstellungenLaden;
   
   
   
   procedure SonstigeStandardeinstellungenLaden
   is begin
      
      SonstigeEinstellungen := SystemRecordKonstanten.StandardSonstigeEinstellungen;
      
   end SonstigeStandardeinstellungenLaden;

end OptionenVariablen;
