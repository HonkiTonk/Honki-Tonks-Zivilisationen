pragma SPARK_Mode (On);

with SchreibeStadtGebaut;

package body StadtMeldungenSetzen is

   procedure StadtMeldungenSetzenRundenEnde
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemKonstanten.LeerSpielerKonstante =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtSchleifenwert).Meldungen := (others => EinheitStadtDatentypen.Leer);
                  
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end StadtMeldungenSetzenRundenEnde;
   
   
   
   procedure StadtMeldungSetzenEreignis
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EreignisExtern : in EinheitStadtDatentypen.Stadt_Meldungen_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when EinheitStadtDatentypen.Produktion_Abgeschlossen | EinheitStadtDatentypen.Einheit_Unplatzierbar =>
            ArtDerMeldung := EinheitStadtDatentypen.Produktion_Fertig;
            
         when EinheitStadtDatentypen.Einwohner_Wachstum | EinheitStadtDatentypen.Einwohner_Reduktion =>
            ArtDerMeldung := EinheitStadtDatentypen.Hungersnot;
            
         when EinheitStadtDatentypen.Fremde_Einheit_Nahe_Stadt =>
            ArtDerMeldung := EinheitStadtDatentypen.Einheit_In_Der_Nähe;
      end case;
      
      SchreibeStadtGebaut.Meldungen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                     WelcheMeldungExtern    => ArtDerMeldung,
                                     MeldungExtern          => EreignisExtern);
      
   end StadtMeldungSetzenEreignis;

end StadtMeldungenSetzen;
