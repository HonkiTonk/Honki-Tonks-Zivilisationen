pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SonstigeVariablen;

with Karten;

package body ZufallsgeneratorenSpieleinstellungen is
   
   function ZufälligeVordefinierteKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum
   is begin
      
      ZufälligeVordefinierteKartengrößeWählen.Reset (ZufälligeVordefinierteKartengrößeGewählt);
      return ZufälligeVordefinierteKartengrößeWählen.Random (ZufälligeVordefinierteKartengrößeGewählt);
        
   end ZufälligeVordefinierteKartengröße;
   
   
   
   function ZufälligeKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum
   is begin
      
      ------------------------ Überall mal Gen => hinzufügen, z. B. während P&P.
      ZufälligeKartengrößeWählen.Reset (Gen => ZufälligeKartengrößeGewählt);
      
      YAchseBestimmenSchleife:
      loop
         
         AuswahlGröße := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
         
         if
           AuswahlGröße >= 20
         then
            Karten.Kartengrößen (KartenDatentypen.Kartengröße_Nutzer_Enum).YAchsenGröße := AuswahlGröße;
            exit YAchseBestimmenSchleife;

         else
            null;
         end if;

      end loop YAchseBestimmenSchleife;

      XAchseBestimmenSchleife:
      loop

         AuswahlGröße := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
         
         if
           AuswahlGröße >= 20
         then
            Karten.Kartengrößen (KartenDatentypen.Kartengröße_Nutzer_Enum).XAchsenGröße := AuswahlGröße;
            exit XAchseBestimmenSchleife;

         else
            null;
         end if;

      end loop XAchseBestimmenSchleife;
      
      return KartenDatentypen.Kartengröße_Nutzer_Enum;
      
   end ZufälligeKartengröße;
   
   
   
   function ZufälligeKartenart
     return KartenDatentypen.Kartenart_Enum
   is begin
      
      ZufälligeKartenartWählen.Reset (ZufälligeKartenartGewählt);
      return ZufälligeKartenartWählen.Random (ZufälligeKartenartGewählt);
      
   end ZufälligeKartenart;
   
   
   
   procedure ZufälligeKartenform
   is begin
      
      --------------------------- In drei Teile aufteilen damit man jede Achsen einzeln zufällig zuweisen kann?
      ZufälligerEAchsenÜbergangWählen.Reset (ZufälligerEAchsenÜbergangGewählt);
      ZufälligerYAchsenÜbergangWählen.Reset (ZufälligerYAchsenÜbergangGewählt);
      ZufälligerXAchsenÜbergangWählen.Reset (ZufälligerXAchsenÜbergangGewählt);
            
      Karten.Kartenparameter.Kartenform.EAchseOben := ZufälligerEAchsenÜbergangWählen.Random (ZufälligerEAchsenÜbergangGewählt);
      Karten.Kartenparameter.Kartenform.EAchseUnten := ZufälligerEAchsenÜbergangWählen.Random (ZufälligerEAchsenÜbergangGewählt);
      Karten.Kartenparameter.Kartenform.YAchseNorden := ZufälligerYAchsenÜbergangWählen.Random (ZufälligerYAchsenÜbergangGewählt);
      Karten.Kartenparameter.Kartenform.YAchseSüden := ZufälligerYAchsenÜbergangWählen.Random (ZufälligerYAchsenÜbergangGewählt);
      Karten.Kartenparameter.Kartenform.XAchseWesten := ZufälligerXAchsenÜbergangWählen.Random (ZufälligerXAchsenÜbergangGewählt);
      Karten.Kartenparameter.Kartenform.XAchseOsten := ZufälligerXAchsenÜbergangWählen.Random (ZufälligerXAchsenÜbergangGewählt);
      
   end ZufälligeKartenform;

   
   
   function ZufälligeKartentemperatur
     return KartenDatentypen.Kartentemperatur_Enum
   is begin
      
      ZufälligeKartentemperaturWählen.Reset (ZufälligeKartentemperaturGewählt);
      return ZufälligeKartentemperaturWählen.Random (ZufälligeKartentemperaturGewählt);
      
   end ZufälligeKartentemperatur;

   
   
   function ZufälligeKartenressourcen
     return KartenDatentypen.Kartenressourcen_Enum
   is begin
      
      ZufälligeKartenressourcenWählen.Reset (ZufälligeKartenressourcenGewählt);
      return ZufälligeKartenressourcenWählen.Random (ZufälligeKartenressourcenGewählt);
      
   end ZufälligeKartenressourcen;
   
   
   
   procedure ZufälligeRassen
   is begin
      
      SpielerVorhanden := False;
      SonstigeVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      ZufälligeRassenWählen.Reset (ZufälligeRassenGewählt);
      
      SpielerSchleife:
      while SpielerVorhanden = False loop
         RassenSchleife:
         for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
            RasseImSpiel := ZufälligeRassenWählen.Random (ZufälligeRassenGewählt);

            if
              RasseImSpiel = RassenDatentypen.Spieler_KI_Enum
            then
               SonstigeVariablen.RassenImSpiel (RasseSchleifenwert) := RasseImSpiel;
               SpielerVorhanden := True;
            
            else
               null;
            end if;
         
         end loop RassenSchleife;
      end loop SpielerSchleife;
      
      ZufälligeRassenWählen.Reset (ZufälligeRassenGewählt);
      
      MenschFestlegenSchleife:
      loop
         MenschlicherSpielerSchleife:
         for MenschlicheRasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

            if
              SonstigeVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) = RassenDatentypen.Spieler_KI_Enum
            then
               RasseImSpiel := ZufälligeRassenWählen.Random (ZufälligeRassenGewählt);
               
               case
                 RasseImSpiel
               is
                  when RassenDatentypen.Spieler_Mensch_Enum =>
                     SonstigeVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) := RassenDatentypen.Spieler_Mensch_Enum;
                     return;
                     
                  when others =>
                     null;
               end case;
            
            else
               null;
            end if;
         
         end loop MenschlicherSpielerSchleife;
      end loop MenschFestlegenSchleife;
      
   end ZufälligeRassen;
   
   
   
   function ZufälligerSchwiewrigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum
   is begin
      
      ZufälligenSchwierigkeitsgradWählen.Reset (ZufälligerSchwierigkeitsgradGewählt);
      return ZufälligenSchwierigkeitsgradWählen.Random (ZufälligerSchwierigkeitsgradGewählt);
      
   end ZufälligerSchwiewrigkeitsgrad;

end ZufallsgeneratorenSpieleinstellungen;
