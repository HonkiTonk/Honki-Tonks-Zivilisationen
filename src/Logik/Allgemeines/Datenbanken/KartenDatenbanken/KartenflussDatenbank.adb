pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KartenflussDatenbank is

   procedure StandardKartenflussDatenbankLaden
   is begin
      
      Kartenflussliste := KartenflusslisteStandard;
      
   end StandardKartenflussDatenbankLaden;

end KartenflussDatenbank;
