pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeEinheitenGebaut;

package body EinheitenMeldungenSetzen is

   procedure EinheitenMeldungenSetzenRundenEnde
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
                  
                  SpielVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitSchleifenwert).Meldungen := (others => EinheitStadtDatentypen.Leer_Enum);
                  
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end EinheitenMeldungenSetzenRundenEnde;
   
   
   procedure EinheitMeldungSetzenEreignis
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EreignisExtern : in EinheitStadtDatentypen.Einheit_Meldung_Verwendet_Enum)
   is begin
      
      case
        EreignisExtern
      is
         when EinheitStadtDatentypen.Aufgabe_Abgeschlossen_Enum =>
            ArtDerMeldung := EinheitStadtDatentypen.Aufgabe_Fertig_Enum;
            
         when EinheitStadtDatentypen.Fremde_Einheit_Nahe_Enum =>
            ArtDerMeldung := EinheitStadtDatentypen.Einheit_In_Der_Nähe_Enum;
      end case;
      
      SchreibeEinheitenGebaut.Meldungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         MeldungExtern            => EreignisExtern,
                                         WelcheMeldungExtern      => ArtDerMeldung);
      
   end EinheitMeldungSetzenEreignis;

end EinheitenMeldungenSetzen;
