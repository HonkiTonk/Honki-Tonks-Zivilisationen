pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with WichtigesRecordKonstanten;

with KartengeneratorVariablen;
with Karten;
with Kartentest;

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
   
   
   
   function ZufälligeVordefinierteKartenart
     return KartenDatentypen.Kartenart_Normal_Enum
   is begin
      
      ZufälligeKartenartWählen.Reset (Gen => ZufälligeKartenartGewählt);
      return ZufälligeKartenartWählen.Random (Gen => ZufälligeKartenartGewählt);
      
   end ZufälligeVordefinierteKartenart;
   
   
   
   procedure ZufälligeKartenart
   is begin
      
      ZufälligeKartengrößeWählen.Reset (Gen => ZufälligeKartengrößeGewählt);
      
      KartengeneratorVariablen.Landgrößen.MinimaleYAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                     First => 1,
                                                                                                     Last  => Karten.Karteneinstellungen.Kartengröße.YAchse / 2);
      
      KartengeneratorVariablen.Landgrößen.MaximaleYAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                     First => KartengeneratorVariablen.Landgrößen.MinimaleYAchse,
                                                                                                     Last  => Karten.Karteneinstellungen.Kartengröße.YAchse / 2);
      
      KartengeneratorVariablen.Landgrößen.MinimaleXAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                     First => 1,
                                                                                                     Last  => Karten.Karteneinstellungen.Kartengröße.XAchse / 2);
      
      KartengeneratorVariablen.Landgrößen.MaximaleXAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                     First => KartengeneratorVariablen.Landgrößen.MinimaleXAchse,
                                                                                                     Last  => Karten.Karteneinstellungen.Kartengröße.XAchse / 2);
      


      KartengeneratorVariablen.Abstände.MinimaleYAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                  First => KartengeneratorVariablen.Landgrößen.MaximaleYAchse,
                                                                                                  Last  => KartengeneratorVariablen.Landgrößen.MaximaleYAchse + 10);
      
      KartengeneratorVariablen.Abstände.MaximaleYAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                  First => KartengeneratorVariablen.Abstände.MinimaleYAchse,
                                                                                                  Last  => KartengeneratorVariablen.Landgrößen.MaximaleYAchse + 10);
      
      KartengeneratorVariablen.Abstände.MinimaleXAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                  First => KartengeneratorVariablen.Landgrößen.MaximaleXAchse,
                                                                                                  Last  => KartengeneratorVariablen.Landgrößen.MaximaleXAchse + 10);
      
      KartengeneratorVariablen.Abstände.MaximaleXAchse := ZufälligeKartengrößeWählen.Random (Gen   => ZufälligeKartengrößeGewählt,
                                                                                                  First => KartengeneratorVariablen.Abstände.MinimaleXAchse,
                                                                                                  Last  => KartengeneratorVariablen.Landgrößen.MaximaleXAchse + 10);
      
   end ZufälligeKartenart;
   
   
   
   procedure ZufälligeKartenform
   is begin
      
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
   is begin
      
      -- Die Pole mal in ein Array basteln? äöü
      ZufälligePolgrößenWählen.Reset (Gen => ZufälligePolgrößeGewählt);
      
      
      KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum) := ZufälligePolgrößenWählen.Random (Gen   => ZufälligePolgrößeGewählt,
                                                                                                                  First => 0,
                                                                                                                  Last  => Karten.Karteneinstellungen.Kartengröße.YAchse / 2);
      
      KartengeneratorVariablen.Kartenparameter.Kartenpole.Nordpol := Kartentest.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum));
      
      
      
      KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum) := ZufälligePolgrößenWählen.Random (Gen   => ZufälligePolgrößeGewählt,
                                                                                                                  First => 0,
                                                                                                                  Last  => Karten.Karteneinstellungen.Kartengröße.YAchse / 2);
      
      KartengeneratorVariablen.Kartenparameter.Kartenpole.Südpol := Kartentest.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum));
            
      
      
      KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum) := ZufälligePolgrößenWählen.Random (Gen   => ZufälligePolgrößeGewählt,
                                                                                                                  First => 0,
                                                                                                                  Last  => Karten.Karteneinstellungen.Kartengröße.YAchse / 2);
      
      KartengeneratorVariablen.Kartenparameter.Kartenpole.Westpol := Kartentest.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum));
      
      
      
      KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum) := ZufälligePolgrößenWählen.Random (Gen   => ZufälligePolgrößeGewählt,
                                                                                                                 First => 0,
                                                                                                                 Last  => Karten.Karteneinstellungen.Kartengröße.YAchse / 2);
      
      KartengeneratorVariablen.Kartenparameter.Kartenpole.Ostpol := Kartentest.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum));
      
   end ZufälligePole;

end ZufallsgeneratorenSpieleinstellungen;
