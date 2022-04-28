pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KartenDatenbank is
   
   procedure StandardKartengrundDatenbankLaden
   is begin
      
      Kartengrundliste := KartengrundlisteStandard;
      
   end StandardKartengrundDatenbankLaden;
   
   
   
   procedure StandardKartenflussDatenbankLaden
   is begin
      
      Kartenflussliste := KartenflusslisteStandard;
      
   end StandardKartenflussDatenbankLaden;
   
   
   
   procedure StandardKartenRessourcenDatenbankLaden
   is begin
      
      KartenRessourcenListe := KartenRessourcenListeStandard;
      
   end StandardKartenRessourcenDatenbankLaden;

end KartenDatenbank;
