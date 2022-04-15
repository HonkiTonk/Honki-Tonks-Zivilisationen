pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeStadtGebaut;

package body StadtMeldungenSetzen is

   procedure StadtMeldungenSetzenRundenEnde
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtSchleifenwert).Meldungen := (others => EinheitStadtDatentypen.Leer_Enum);
                  
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
         when EinheitStadtDatentypen.Produktion_Abgeschlossen_Enum | EinheitStadtDatentypen.Einheit_Unplatzierbar_Enum =>
            ArtDerMeldung := EinheitStadtDatentypen.Produktion_Fertig_Enum;
            
         when EinheitStadtDatentypen.Einwohner_Wachstum_Enum | EinheitStadtDatentypen.Einwohner_Reduktion_Enum =>
            ArtDerMeldung := EinheitStadtDatentypen.Hungersnot_Enum;
            
         when EinheitStadtDatentypen.Fremde_Einheit_Nahe_Stadt_Enum =>
            ArtDerMeldung := EinheitStadtDatentypen.Einheit_In_Der_Nähe_Enum;
      end case;
      
      SchreibeStadtGebaut.Meldungen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                     WelcheMeldungExtern    => ArtDerMeldung,
                                     MeldungExtern          => EreignisExtern);
      
   end StadtMeldungSetzenEreignis;

end StadtMeldungenSetzen;
