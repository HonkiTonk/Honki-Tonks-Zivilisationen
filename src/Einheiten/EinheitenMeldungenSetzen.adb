pragma SPARK_Mode (On);

with SystemDatentypen;

with SchreibeEinheitenGebaut;

package body EinheitenMeldungenSetzen is

   procedure EinheitenMeldungenSetzenRundenEnde
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
                  
                  GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitSchleifenwert).Meldungen := (others => EinheitStadtDatentypen.Leer);
                  
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
         when EinheitStadtDatentypen.Aufgabe_Abgeschlossen =>
            ArtDerMeldung := EinheitStadtDatentypen.Aufgabe_Fertig;
            
         when EinheitStadtDatentypen.Fremde_Einheit_Nahe =>
            ArtDerMeldung := EinheitStadtDatentypen.Einheit_In_Der_Nähe;
      end case;
      
      SchreibeEinheitenGebaut.Meldungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         MeldungExtern            => EreignisExtern,
                                         WelcheMeldungExtern      => ArtDerMeldung);
      
   end EinheitMeldungSetzenEreignis;

end EinheitenMeldungenSetzen;
