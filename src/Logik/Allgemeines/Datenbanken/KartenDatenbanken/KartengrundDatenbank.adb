pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KartengrundDatenbank is
   
   procedure StandardKartengrundDatenbankLaden
   is begin
      
      Kartengrundliste := KartengrundlisteStandard;
      
   end StandardKartengrundDatenbankLaden;

end KartengrundDatenbank;
