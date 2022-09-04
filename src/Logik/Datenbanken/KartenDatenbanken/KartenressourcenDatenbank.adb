pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KartenressourcenDatenbank is

   procedure StandardKartenressourcenDatenbankLaden
   is begin
      
      Kartenressourcenliste := KartenressourcenlisteStandard;
      
   end StandardKartenressourcenDatenbankLaden;

end KartenressourcenDatenbank;
