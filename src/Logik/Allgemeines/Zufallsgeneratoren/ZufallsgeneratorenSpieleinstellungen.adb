pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

with KartengeneratorVariablen;

package body ZufallsgeneratorenSpieleinstellungen is
   
   function ZufälligeVordefinierteKartengröße
     return RueckgabeDatentypen.Kartengrößen_Standard_Enum
   is begin
      
      ZufälligeVordefinierteKartengrößeWählen.Reset (Gen => ZufälligeVordefinierteKartengrößeGewählt);
      return ZufälligeVordefinierteKartengrößeWählen.Random (Gen => ZufälligeVordefinierteKartengrößeGewählt);
        
   end ZufälligeVordefinierteKartengröße;
   
   
   
   function ZufälligeKartengröße
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
      
      ZufälligeKartengrößeWählen.Reset (Gen => ZufälligeKartengrößeGewählt);
      
      return (ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                 First => 20,
                                                     Last  => KartenDatentypen.KartenfeldPositiv'Last),
              
              ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                     First => 20,
                                                     Last  => KartenDatentypen.KartenfeldPositiv'Last));
      
   end ZufälligeKartengröße;
   
   
   
   function ZufälligeKartenart
     return KartenDatentypen.Kartenart_Enum
   is begin
      
      ZufälligeKartenartWählen.Reset (Gen => ZufälligeKartenartGewählt);
      return ZufälligeKartenartWählen.Random (Gen => ZufälligeKartenartGewählt);
      
   end ZufälligeKartenart;
   
   
   
   procedure ZufälligeKartenform
   is begin
      
      --------------------------- In drei Teile aufteilen damit man jede Achsen einzeln zufällig zuweisen kann?
      ZufälligerEAchsenÜbergangWählen.Reset (Gen => ZufälligerEAchsenÜbergangGewählt);
      ZufälligerYAchsenÜbergangWählen.Reset (Gen => ZufälligerYAchsenÜbergangGewählt);
      ZufälligerXAchsenÜbergangWählen.Reset (Gen => ZufälligerXAchsenÜbergangGewählt);
            
      KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben := ZufälligerEAchsenÜbergangWählen.Random (Gen => ZufälligerEAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten := ZufälligerEAchsenÜbergangWählen.Random (Gen => ZufälligerEAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden := ZufälligerYAchsenÜbergangWählen.Random (Gen => ZufälligerYAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden := ZufälligerYAchsenÜbergangWählen.Random (Gen => ZufälligerYAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten := ZufälligerXAchsenÜbergangWählen.Random (Gen => ZufälligerXAchsenÜbergangGewählt);
      KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten := ZufälligerXAchsenÜbergangWählen.Random (Gen => ZufälligerXAchsenÜbergangGewählt);
      
   end ZufälligeKartenform;

   
   
   function ZufälligeKartentemperatur
     return KartenDatentypen.Kartentemperatur_Enum
   is begin
      
      ZufälligeKartentemperaturWählen.Reset (Gen => ZufälligeKartentemperaturGewählt);
      return ZufälligeKartentemperaturWählen.Random (Gen => ZufälligeKartentemperaturGewählt);
      
   end ZufälligeKartentemperatur;

   
   
   function ZufälligeKartenressourcen
     return KartenDatentypen.Kartenressourcen_Enum
   is begin
      
      ZufälligeKartenressourcenWählen.Reset (Gen => ZufälligeKartenressourcenGewählt);
      return ZufälligeKartenressourcenWählen.Random (Gen => ZufälligeKartenressourcenGewählt);
      
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
      SpielVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      ZufälligeRassenbelegungWählen.Reset (Gen => ZufälligeRassenbelegungGewählt);
      
      SpielerSchleife:
      while SpielerVorhanden = False loop
         RassenSchleife:
         for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
            RasseImSpiel := ZufälligeRassenbelegungWählen.Random (Gen => ZufälligeRassenbelegungGewählt);

            if
              RasseImSpiel = RassenDatentypen.KI_Spieler_Enum
            then
               SpielVariablen.RassenImSpiel (RasseSchleifenwert) := RasseImSpiel;
               SpielerVorhanden := True;
            
            else
               null;
            end if;
         
         end loop RassenSchleife;
      end loop SpielerSchleife;
      
      ZufälligeRassenbelegungWählen.Reset (Gen => ZufälligeRassenbelegungGewählt);
      
      MenschFestlegenSchleife:
      loop
         MenschlicherSpielerSchleife:
         for MenschlicheRasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

            if
              SpielVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) = RassenDatentypen.KI_Spieler_Enum
            then
               RasseImSpiel := ZufälligeRassenbelegungWählen.Random (Gen => ZufälligeRassenbelegungGewählt);
               
               case
                 RasseImSpiel
               is
                  when RassenDatentypen.Mensch_Spieler_Enum =>
                     SpielVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) := RassenDatentypen.Mensch_Spieler_Enum;
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
      
      ZufälligenSchwierigkeitsgradWählen.Reset (Gen => ZufälligerSchwierigkeitsgradGewählt);
      return ZufälligenSchwierigkeitsgradWählen.Random (Gen => ZufälligerSchwierigkeitsgradGewählt);
      
   end ZufälligerSchwiewrigkeitsgrad;
   
   
   
   procedure ZufälligePole
   is begin
      
      null;
      
   end ZufälligePole;

end ZufallsgeneratorenSpieleinstellungen;
