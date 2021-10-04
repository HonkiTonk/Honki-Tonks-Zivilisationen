pragma SPARK_Mode (On);

with SonstigesKonstanten, EinheitenKonstanten, StadtKonstanten;

with SchreibeStadtGebaut, SchreibeEinheitenGebaut;
with LeseEinheitenGebaut, LeseStadtGebaut;

with KartenfelderBewerten;

package body RasseEntfernen is

   procedure RasseEntfernen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
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
      for DiplomatieSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         GlobaleVariablen.Diplomatie (RasseExtern, DiplomatieSchleifenwert) := SonstigesKonstanten.LeerDiplomatie;
         GlobaleVariablen.Diplomatie (DiplomatieSchleifenwert, RasseExtern) := SonstigesKonstanten.LeerDiplomatie;
         
      end loop DiplomatieSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern) := SonstigesKonstanten.LeerCursor;
      GlobaleVariablen.Wichtiges (RasseExtern) := SonstigesKonstanten.LeerWichtigesZeug;
      
      GlobaleVariablen.RassenImSpiel (RasseExtern) := SonstigeDatentypen.Leer;
      
   end RasseEntfernen;
   
   
   
   procedure RasseExistenzPrüfen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
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
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop StadtSchleife;
      
      RasseEntfernen (RasseExtern => RasseExtern);
      
   end RasseExistenzPrüfen;
   
   
   
   procedure RasseAufKISetzen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      GlobaleVariablen.RassenImSpiel (RasseExtern) := SonstigeDatentypen.Spieler_KI;
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => RasseExtern);
      
   end RasseAufKISetzen;

end RasseEntfernen;
