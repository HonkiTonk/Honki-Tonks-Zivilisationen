pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeStadtGebaut, SchreibeEinheitenGebaut;
with LeseEinheitenGebaut, LeseStadtGebaut;

with KartenfelderBewerten;

package body RasseEntfernen is

   procedure RasseEntfernen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert));
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         
      end loop StadtSchleife;
            
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop         
         
         GlobaleVariablen.Diplomatie (RasseExtern, DiplomatieSchleifenwert) := GlobaleKonstanten.LeerDiplomatie;
         GlobaleVariablen.Diplomatie (DiplomatieSchleifenwert, RasseExtern) := GlobaleKonstanten.LeerDiplomatie;
         
      end loop DiplomatieSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern) := GlobaleKonstanten.LeerCursor;
      GlobaleVariablen.Wichtiges (RasseExtern) := GlobaleKonstanten.LeerWichtigesZeug;
      
      GlobaleVariablen.RassenImSpiel (RasseExtern) := GlobaleDatentypen.Leer;
      
   end RasseEntfernen;
   
   
   
   procedure RasseExistenzPrüfen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when GlobaleKonstanten.LeerEinheitenID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when GlobaleKonstanten.LeerStadtID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop StadtSchleife;
      
      RasseEntfernen (RasseExtern => RasseExtern);
      
   end RasseExistenzPrüfen;
   
   
   
   procedure RasseAufKISetzen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      GlobaleVariablen.RassenImSpiel (RasseExtern) := GlobaleDatentypen.Spieler_KI;
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => RasseExtern);
      
   end RasseAufKISetzen;

end RasseEntfernen;
