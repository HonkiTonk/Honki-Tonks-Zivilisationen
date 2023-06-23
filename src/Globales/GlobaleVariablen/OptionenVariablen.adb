with SystemRecordKonstanten;

package body OptionenVariablen is

   procedure StandardNutzereinstellungenLaden
   is begin
      
      NutzerEinstellungen := SystemRecordKonstanten.StandardNutzereinstellungen;
      
   end StandardNutzereinstellungenLaden;
   
   
   
   procedure SpielendeStandardeinstellungenLaden
   is begin
      
      SpielendeEinstellungen := SystemRecordKonstanten.StandardSpielendeEinstellungen;
      
   end SpielendeStandardeinstellungenLaden;

end OptionenVariablen;
