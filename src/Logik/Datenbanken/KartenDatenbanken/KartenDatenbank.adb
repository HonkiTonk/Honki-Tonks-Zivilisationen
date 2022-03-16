pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KartenDatenbank is
   
   procedure StandardKartenGrundDatenbankLaden
   is begin
      
      KartenGrundListe := KartenGrundListeStandard;
      
   end StandardKartenGrundDatenbankLaden;
   
   
   
   procedure StandardKartenFlussDatenbankLaden
   is begin
      
      KartenFlussListe := KartenFlussListeStandard;
      
   end StandardKartenFlussDatenbankLaden;
   
   
   
   procedure StandardKartenRessourcenDatenbankLaden
   is begin
      
      KartenRessourcenListe := KartenRessourcenListeStandard;
      
   end StandardKartenRessourcenDatenbankLaden;

end KartenDatenbank;
