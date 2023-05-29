with EffekteDatenbank;
with EffekteStandard;

package body StandardEffekteDatenbank is

   procedure StandardEffekteDatenbankLaden
   is begin
      
      EffekteSchleife:
      for EffekteSchleifenwert in EffekteDatenbank.EffektelisteArray'Range loop
         
         EffekteDatenbank.Effekteliste (EffekteSchleifenwert) := EffekteStandard.Effekteliste (EffekteSchleifenwert);
         
      end loop EffekteSchleife;
      
   end StandardEffekteDatenbankLaden;

end StandardEffekteDatenbank;
