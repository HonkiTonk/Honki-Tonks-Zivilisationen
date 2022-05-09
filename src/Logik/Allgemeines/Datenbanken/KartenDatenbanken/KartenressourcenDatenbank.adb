pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KartenressourcenDatenbank is

   procedure StandardKartenRessourcenDatenbankLaden
   is begin
      
      KartenRessourcenListe := KartenRessourcenListeStandard;
      
   end StandardKartenRessourcenDatenbankLaden;

end KartenressourcenDatenbank;
