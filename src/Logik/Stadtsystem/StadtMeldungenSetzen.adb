pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeStadtGebaut;

package body StadtMeldungenSetzen is

   procedure StadtMeldungenSetzenRundenEnde
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  SpielVariablen.StadtGebaut (RasseSchleifenwert, StadtSchleifenwert).Meldungen := (others => StadtDatentypen.Leer_Stadt_Meldung_Enum);
                  
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end StadtMeldungenSetzenRundenEnde;
   
   
   
   procedure StadtMeldungSetzenEreignis
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EreignisExtern : in StadtDatentypen.Stadt_Meldungen_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when StadtDatentypen.Produktion_Abgeschlossen_Enum | StadtDatentypen.Einheit_Unplatzierbar_Enum =>
            ArtDerMeldung := StadtDatentypen.Produktion_Fertig_Enum;
            
         when StadtDatentypen.Einwohner_Wachstum_Enum | StadtDatentypen.Einwohner_Reduktion_Enum =>
            ArtDerMeldung := StadtDatentypen.Hungersnot_Enum;
            
         when StadtDatentypen.Fremde_Einheit_Nahe_Stadt_Enum =>
            ArtDerMeldung := StadtDatentypen.Einheit_In_Stadtnähe_Enum;
      end case;
      
      SchreibeStadtGebaut.Meldungen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                     WelcheMeldungExtern    => ArtDerMeldung,
                                     MeldungExtern          => EreignisExtern);
      
   end StadtMeldungSetzenEreignis;

end StadtMeldungenSetzen;
