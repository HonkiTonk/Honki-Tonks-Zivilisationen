pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SonstigeVariablen;

with KartengeneratorVariablen;

------------------------------------ Überall mal Gen => hinzufügen, z. B. während P&P.
package body ZufallsgeneratorenSpieleinstellungen is
   
   function ZufälligeVordefinierteKartengröße
     return RueckgabeDatentypen.Kartengrößen_Standard_Enum
   is begin
      
      ZufälligeVordefinierteKartengrößeWählen.Reset (ZufälligeVordefinierteKartengrößeGewählt);
      return ZufälligeVordefinierteKartengrößeWählen.Random (ZufälligeVordefinierteKartengrößeGewählt);
        
   end ZufälligeVordefinierteKartengröße;
   
   
   
   function ZufälligeKartengröße
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
      
      ZufälligeKartengrößeWählen.Reset (Gen => ZufälligeKartengrößeGewählt);
      
      YAchseBestimmenSchleife:
      loop
         
         YAchse := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
         
         if
           YAchse >= 20
         then
            exit YAchseBestimmenSchleife;

         else
            null;
         end if;

      end loop YAchseBestimmenSchleife;

      XAchseBestimmenSchleife:
      loop

         XAchse := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
         
         if
           XAchse >= 20
         then
            exit XAchseBestimmenSchleife;

         else
            null;
         end if;

      end loop XAchseBestimmenSchleife;
      
      return (YAchse, XAchse);
      
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
            
      KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben := ZufälligerEAchsenÜbergangWählen.Random (ZufälligerEAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten := ZufälligerEAchsenÜbergangWählen.Random (ZufälligerEAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden := ZufälligerYAchsenÜbergangWählen.Random (ZufälligerYAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden := ZufälligerYAchsenÜbergangWählen.Random (ZufälligerYAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten := ZufälligerXAchsenÜbergangWählen.Random (ZufälligerXAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten := ZufälligerXAchsenÜbergangWählen.Random (ZufälligerXAchsenÜbergangGewählt);
      
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
   
   
   
   function ZufälligeRasse
     return RassenDatentypen.Rassen_Verwendet_Enum
   is begin
      
      ZufälligeRasseWählen.Reset (Gen => ZufälligeRasseGewählt);
      return ZufälligeRasseWählen.Random (Gen => ZufälligeRasseGewählt);
      
   end ZufälligeRasse;
   
   
   
   procedure ZufälligeRassenbelegung
   is begin
      
      SpielerVorhanden := False;
      SonstigeVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      ZufälligeRassenbelegungWählen.Reset (ZufälligeRassenbelegungGewählt);
      
      SpielerSchleife:
      while SpielerVorhanden = False loop
         RassenSchleife:
         for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
            RasseImSpiel := ZufälligeRassenbelegungWählen.Random (ZufälligeRassenbelegungGewählt);

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
      
      ZufälligeRassenbelegungWählen.Reset (ZufälligeRassenbelegungGewählt);
      
      MenschFestlegenSchleife:
      loop
         MenschlicherSpielerSchleife:
         for MenschlicheRasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

            if
              SonstigeVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) = RassenDatentypen.Spieler_KI_Enum
            then
               RasseImSpiel := ZufälligeRassenbelegungWählen.Random (ZufälligeRassenbelegungGewählt);
               
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
      
   end ZufälligeRassenbelegung;
   
   
   
   function ZufälligerSchwiewrigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum
   is begin
      
      ZufälligenSchwierigkeitsgradWählen.Reset (ZufälligerSchwierigkeitsgradGewählt);
      return ZufälligenSchwierigkeitsgradWählen.Random (ZufälligerSchwierigkeitsgradGewählt);
      
   end ZufälligerSchwiewrigkeitsgrad;
   
   
   
   procedure ZufälligePole
   is begin
      
      null;
      
   end ZufälligePole;

end ZufallsgeneratorenSpieleinstellungen;
