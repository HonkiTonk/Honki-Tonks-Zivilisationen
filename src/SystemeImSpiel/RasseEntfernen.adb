pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartenfelderBewerten, LeseEinheitenGebaut;

package body RasseEntfernen is

   procedure RasseEntfernen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert) := GlobaleKonstanten.LeerEinheit;
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert) := GlobaleKonstanten.LeerStadt;
         
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
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).ID
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
