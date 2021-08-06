pragma SPARK_Mode (On);

package body StadtMeldungenSetzen is

   procedure StadtMeldungenSetzenRundenEnde
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtSchleifenwert).Meldungen := (others => GlobaleDatentypen.Leer);
                  
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end StadtMeldungenSetzenRundenEnde;
   
   
   
   procedure StadtMeldungSetzenEreignis
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EreignisExtern : in GlobaleDatentypen.Stadt_Meldungen_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when GlobaleDatentypen.Produktion_Abgeschlossen | GlobaleDatentypen.Einheit_Unplatzierbar =>
            ArtDerMeldung := GlobaleDatentypen.Produktion_Fertig;
            
         when GlobaleDatentypen.Einwohner_Wachstum | GlobaleDatentypen.Einwohner_Reduktion =>
            ArtDerMeldung := GlobaleDatentypen.Hungersnot;
            
         when GlobaleDatentypen.Fremde_Einheit_Nahe_Stadt =>
            ArtDerMeldung := GlobaleDatentypen.Einheit_In_Der_Nähe;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Meldungen (ArtDerMeldung) := EreignisExtern;
      
   end StadtMeldungSetzenEreignis;

end StadtMeldungenSetzen;
