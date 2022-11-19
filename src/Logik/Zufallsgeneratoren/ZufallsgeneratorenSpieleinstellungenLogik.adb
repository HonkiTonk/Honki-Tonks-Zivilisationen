with SpielVariablen;
with WichtigesRecordKonstanten;

with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;
with KartentestsLogik;

package body ZufallsgeneratorenSpieleinstellungenLogik is
   
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
   
   
   
   function ZufälligeVordefinierteKartenart
     return KartenartDatentypen.Kartenart_Normal_Enum
   is begin
      
      ZufälligeKartenartWählen.Reset (Gen => ZufälligeKartenartGewählt);
      return ZufälligeKartenartWählen.Random (Gen => ZufälligeKartenartGewählt);
      
   end ZufälligeVordefinierteKartenart;
   
   
   
   procedure ZufälligeKartenart
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      ZufälligeKartengrößeWählen.Reset (Gen => ZufälligeKartengrößeGewählt);
      
      KartengeneratorVariablenLogik.Landgrößen.MinimaleYAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                     First => 1,
                                                                                                     Last  => LeseWeltkarteneinstellungen.YAchse / 2);
      
      KartengeneratorVariablenLogik.Landgrößen.MaximaleYAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                     First => KartengeneratorVariablenLogik.Landgrößen.MinimaleYAchse,
                                                                                                     Last  => LeseWeltkarteneinstellungen.YAchse / 2);
      
      KartengeneratorVariablenLogik.Landgrößen.MinimaleXAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                     First => 1,
                                                                                                     Last  => LeseWeltkarteneinstellungen.XAchse / 2);
      
      KartengeneratorVariablenLogik.Landgrößen.MaximaleXAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                     First => KartengeneratorVariablenLogik.Landgrößen.MinimaleXAchse,
                                                                                                     Last  => LeseWeltkarteneinstellungen.XAchse / 2);
      
   end ZufälligeKartenart;
   
   
   
   procedure ZufälligeKartenform
   is begin
      
      ZufälligerEAchsenÜbergangWählen.Reset (Gen => ZufälligerEAchsenÜbergangGewählt);
      ZufälligerYAchsenÜbergangWählen.Reset (Gen => ZufälligerYAchsenÜbergangGewählt);
      ZufälligerXAchsenÜbergangWählen.Reset (Gen => ZufälligerXAchsenÜbergangGewählt);
            
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben := ZufälligerEAchsenÜbergangWählen.Random (Gen => ZufälligerEAchsenÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten := ZufälligerEAchsenÜbergangWählen.Random (Gen => ZufälligerEAchsenÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden := ZufälligerYAchsenÜbergangWählen.Random (Gen => ZufälligerYAchsenÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden := ZufälligerYAchsenÜbergangWählen.Random (Gen => ZufälligerYAchsenÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten := ZufälligerXAchsenÜbergangWählen.Random (Gen => ZufälligerXAchsenÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten := ZufälligerXAchsenÜbergangWählen.Random (Gen => ZufälligerXAchsenÜbergangGewählt);
      
   end ZufälligeKartenform;

   
   
   function ZufälligeKartentemperatur
     return KartenartDatentypen.Kartentemperatur_Enum
   is begin
      
      ZufälligeKartentemperaturWählen.Reset (Gen => ZufälligeKartentemperaturGewählt);
      return ZufälligeKartentemperaturWählen.Random (Gen => ZufälligeKartentemperaturGewählt);
      
   end ZufälligeKartentemperatur;

   
   
   function ZufälligeKartenressourcen
     return KartenartDatentypen.Kartenressourcen_Enum
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
   is
      use type RassenDatentypen.Spieler_Enum;
   begin
      
      SpielerVorhanden := False;
      SpielVariablen.Rassenbelegung := (others => WichtigesRecordKonstanten.LeerRassenbelegung);
      ZufälligeRassenbelegungWählen.Reset (Gen => ZufälligeRassenbelegungGewählt);
      
      SpielerSchleife:
      while SpielerVorhanden = False loop
         RassenSchleife:
         for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
            RasseImSpiel := ZufälligeRassenbelegungWählen.Random (Gen => ZufälligeRassenbelegungGewählt);

            if
              RasseImSpiel = RassenDatentypen.KI_Spieler_Enum
            then
               SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung := RasseImSpiel;
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
              SpielVariablen.Rassenbelegung (MenschlicheRasseSchleifenwert).Belegung = RassenDatentypen.KI_Spieler_Enum
            then
               RasseImSpiel := ZufälligeRassenbelegungWählen.Random (Gen => ZufälligeRassenbelegungGewählt);
               
               case
                 RasseImSpiel
               is
                  when RassenDatentypen.Mensch_Spieler_Enum =>
                     SpielVariablen.Rassenbelegung (MenschlicheRasseSchleifenwert).Belegung := RassenDatentypen.Mensch_Spieler_Enum;
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
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      -- Die Pole mal in ein Array basteln? äöü
      ZufälligePolgrößenWählen.Reset (Gen => ZufälligePolgrößeGewählt);
      
      
      KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum) := ZufälligePolgrößenWählen.Random (Gen   => ZufälligePolgrößeGewählt,
                                                                                                                       First => 0,
                                                                                                                       Last  => LeseWeltkarteneinstellungen.YAchse / 2);
      
      KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Nordpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum));
      
      
      
      KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum) := ZufälligePolgrößenWählen.Random (Gen   => ZufälligePolgrößeGewählt,
                                                                                                                       First => 0,
                                                                                                                       Last  => LeseWeltkarteneinstellungen.YAchse / 2);
      
      KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Südpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum));
            
      
      
      KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum) := ZufälligePolgrößenWählen.Random (Gen   => ZufälligePolgrößeGewählt,
                                                                                                                       First => 0,
                                                                                                                       Last  => LeseWeltkarteneinstellungen.YAchse / 2);
      
      KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Westpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum));
      
      
      
      KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum) := ZufälligePolgrößenWählen.Random (Gen   => ZufälligePolgrößeGewählt,
                                                                                                                      First => 0,
                                                                                                                      Last  => LeseWeltkarteneinstellungen.YAchse / 2);
      
      KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Ostpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum));
      
   end ZufälligePole;

end ZufallsgeneratorenSpieleinstellungenLogik;
