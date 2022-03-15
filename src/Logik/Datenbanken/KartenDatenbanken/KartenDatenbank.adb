pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KartenDatenbank is
   
   procedure StandardKartenDatenbankLaden
   is begin
      
      KartenFelderListe := KartenFelderListeStandard;
      
   end StandardKartenDatenbankLaden;

end KartenDatenbank;
