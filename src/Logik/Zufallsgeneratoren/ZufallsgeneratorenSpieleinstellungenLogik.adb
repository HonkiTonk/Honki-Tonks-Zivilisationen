with KartenKonstanten;

with LeseWeltkarteneinstellungen;
with SchreibeSpeziesbelegung;
with LeseSpeziesbelegung;

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
     return KartenRecords.KartenfeldumgebungPositivRecord
   is begin
      
      ZufälligeKartensenkrechteWählen.Reset (Gen => ZufälligeKartensenkrechteGewählt);
      ZufälligeKartenwaagerechteWählen.Reset (Gen => ZufälligeKartenwaagerechteGewählt);
      
      return (ZufälligeKartensenkrechteWählen.Random (Gen   => ZufälligeKartensenkrechteGewählt,
                                                        First => KartenKonstanten.MinimaleKartengröße.Senkrechte,
                                                        Last  => KartenDatentypen.SenkrechtePositiv'Last),
              
              ZufälligeKartenwaagerechteWählen.Random (Gen   => ZufälligeKartenwaagerechteGewählt,
                                                         First => KartenKonstanten.MinimaleKartengröße.Waagerechte,
                                                         Last  => KartenDatentypen.WaagerechtePositiv'Last));
      
   end ZufälligeKartengröße;
   
   
   
   function ZufälligeVordefinierteKartenart
     return KartenartDatentypen.Kartenart_Normal_Enum
   is begin
      
      ZufälligeKartenartWählen.Reset (Gen => ZufälligeKartenartGewählt);
      return ZufälligeKartenartWählen.Random (Gen => ZufälligeKartenartGewählt);
      
   end ZufälligeVordefinierteKartenart;
   
   
   
   procedure ZufälligeKartenart
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      ZufälligeKartensenkrechteWählen.Reset (Gen => ZufälligeKartensenkrechteGewählt);
      ZufälligeKartenwaagerechteWählen.Reset (Gen => ZufälligeKartenwaagerechteGewählt);
      
      KartengeneratorVariablenLogik.Landgrößen.MinimaleSenkrechte := ZufälligeKartensenkrechteWählen.Random (Gen   => ZufälligeKartensenkrechteGewählt,
                                                                                                             First => KartenDatentypen.SenkrechtePositiv'First,
                                                                                                             Last  => LeseWeltkarteneinstellungen.Senkrechte / 2);
      
      KartengeneratorVariablenLogik.Landgrößen.MaximaleSenkrechte := ZufälligeKartensenkrechteWählen.Random (Gen   => ZufälligeKartensenkrechteGewählt,
                                                                                                             First => KartengeneratorVariablenLogik.Landgrößen.MinimaleSenkrechte,
                                                                                                             Last  => LeseWeltkarteneinstellungen.Senkrechte / 2);
      
      KartengeneratorVariablenLogik.Landgrößen.MinimaleWaagerechte := ZufälligeKartenwaagerechteWählen.Random (Gen   => ZufälligeKartenwaagerechteGewählt,
                                                                                                              First => KartenDatentypen.WaagerechtePositiv'First,
                                                                                                              Last  => LeseWeltkarteneinstellungen.Waagerechte / 2);
      
      KartengeneratorVariablenLogik.Landgrößen.MaximaleWaagerechte := ZufälligeKartenwaagerechteWählen.Random (Gen   => ZufälligeKartenwaagerechteGewählt,
                                                                                                              First => KartengeneratorVariablenLogik.Landgrößen.MinimaleWaagerechte,
                                                                                                              Last  => LeseWeltkarteneinstellungen.Waagerechte / 2);
      
   end ZufälligeKartenart;
   
   
   
   procedure ZufälligeKartenform
   is begin
      
      ZufälligerEbeneÜbergangWählen.Reset (Gen => ZufälligerEbeneÜbergangGewählt);
      ZufälligerSenkrechteÜbergangWählen.Reset (Gen => ZufälligerSenkrechteÜbergangGewählt);
      ZufälligerWaagerechteÜbergangWählen.Reset (Gen => ZufälligerWaagerechteÜbergangGewählt);
            
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneOben := ZufälligerEbeneÜbergangWählen.Random (Gen => ZufälligerEbeneÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneUnten := ZufälligerEbeneÜbergangWählen.Random (Gen => ZufälligerEbeneÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden := ZufälligerSenkrechteÜbergangWählen.Random (Gen => ZufälligerSenkrechteÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden := ZufälligerSenkrechteÜbergangWählen.Random (Gen => ZufälligerSenkrechteÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten := ZufälligerWaagerechteÜbergangWählen.Random (Gen => ZufälligerWaagerechteÜbergangGewählt);
      KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten := ZufälligerWaagerechteÜbergangWählen.Random (Gen => ZufälligerWaagerechteÜbergangGewählt);
      
   end ZufälligeKartenform;

   
   
   function ZufälligeKartentemperatur
     return KartenartDatentypen.Kartentemperatur_Enum
   is begin
      
      ZufälligeKartentemperaturWählen.Reset (Gen => ZufälligeKartentemperaturGewählt);
      return ZufälligeKartentemperaturWählen.Random (Gen => ZufälligeKartentemperaturGewählt);
      
   end ZufälligeKartentemperatur;

   
   
   function ZufälligeKartenressourcen
     return KartenartDatentypen.Kartenressourcenmenge_Enum
   is begin
      
      ZufälligeKartenressourcenWählen.Reset (Gen => ZufälligeKartenressourcenGewählt);
      return ZufälligeKartenressourcenWählen.Random (Gen => ZufälligeKartenressourcenGewählt);
      
   end ZufälligeKartenressourcen;
   
   
   
   function ZufälligeSpezies
     return SpeziesDatentypen.Spezies_Vorhanden_Enum
   is begin
      
      ZufälligeSpeziesWählen.Reset (Gen => ZufälligeSpeziesGewählt);
      return ZufälligeSpeziesWählen.Random (Gen => ZufälligeSpeziesGewählt);
      
   end ZufälligeSpezies;
   
   
   
   procedure ZufälligeSpeziesbelegung
   is
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      SpielerVorhanden := False;
      SchreibeSpeziesbelegung.Standardeinstellungen;
      ZufälligeSpeziesbelegungWählen.Reset (Gen => ZufälligeSpeziesbelegungGewählt);
      
      SpielerSchleife:
      while SpielerVorhanden = False loop
         SpeziesSchleife:
         for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
            SpeziesImSpiel := ZufälligeSpeziesbelegungWählen.Random (Gen => ZufälligeSpeziesbelegungGewählt);

            if
              SpeziesImSpiel = SpeziesDatentypen.KI_Spieler_Enum
            then
               SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesSchleifenwert,
                                                 BelegungExtern => SpeziesImSpiel);
               SpielerVorhanden := True;
            
            else
               null;
            end if;
         
         end loop SpeziesSchleife;
      end loop SpielerSchleife;
      
      ZufälligeSpeziesbelegungWählen.Reset (Gen => ZufälligeSpeziesbelegungGewählt);
      
      MenschFestlegenSchleife:
      loop
         MenschlicherSpielerSchleife:
         for MenschlicheSpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop

            if
              LeseSpeziesbelegung.Belegung (SpeziesExtern => MenschlicheSpeziesSchleifenwert) = SpeziesDatentypen.KI_Spieler_Enum
            then
               SpeziesImSpiel := ZufälligeSpeziesbelegungWählen.Random (Gen => ZufälligeSpeziesbelegungGewählt);
               
               case
                 SpeziesImSpiel
               is
                  when SpeziesDatentypen.Mensch_Spieler_Enum =>
                     SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => MenschlicheSpeziesSchleifenwert,
                                                       BelegungExtern => SpeziesDatentypen.Mensch_Spieler_Enum);
                     return;
                     
                  when others =>
                     null;
               end case;
            
            else
               null;
            end if;
         
         end loop MenschlicherSpielerSchleife;
      end loop MenschFestlegenSchleife;
      
   end ZufälligeSpeziesbelegung;
   
   
   
   function ZufälligerSchwiewrigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum
   is begin
      
      ZufälligenSchwierigkeitsgradWählen.Reset (Gen => ZufälligerSchwierigkeitsgradGewählt);
      return ZufälligenSchwierigkeitsgradWählen.Random (Gen => ZufälligerSchwierigkeitsgradGewählt);
      
   end ZufälligerSchwiewrigkeitsgrad;
   
   
   
   procedure ZufälligePole
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      -- Die Pole mal in ein Array basteln? äöü
      ZufälligeSenkrechtePolgrößenWählen.Reset (Gen => ZufälligeSenkrechtePolgrößeGewählt);
      ZufälligeWaagerechtePolgrößenWählen.Reset (Gen => ZufälligeWaagerechtePolgrößeGewählt);
      
      
      KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Norden_Enum) := ZufälligeSenkrechtePolgrößenWählen.Random (Gen   => ZufälligeSenkrechtePolgrößeGewählt,
                                                                                                                                              First => KartenDatentypen.SenkrechteNatural'First,
                                                                                                                                              Last  => LeseWeltkarteneinstellungen.Senkrechte / 2);
      
      KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Nordpol := KartentestsLogik.SenkrechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Norden_Enum));
      
      
      
      KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Süden_Enum) := ZufälligeSenkrechtePolgrößenWählen.Random (Gen   => ZufälligeSenkrechtePolgrößeGewählt,
                                                                                                                                              First => KartenDatentypen.SenkrechteNatural'First,
                                                                                                                                              Last  => LeseWeltkarteneinstellungen.Senkrechte / 2);
      
      KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Südpol := KartentestsLogik.SenkrechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Süden_Enum));
      
      
      
      KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Westen_Enum) := ZufälligeWaagerechtePolgrößenWählen.Random (Gen   => ZufälligeWaagerechtePolgrößeGewählt,
                                                                                                                                                First => KartenDatentypen.WaagerechteNatural'First,
                                                                                                                                                Last  => LeseWeltkarteneinstellungen.Waagerechte / 2);
      
      KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Westpol
        := KartentestsLogik.WaagerechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Westen_Enum));
      
      
      
      KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Osten_Enum) := ZufälligeWaagerechtePolgrößenWählen.Random (Gen   => ZufälligeWaagerechtePolgrößeGewählt,
                                                                                                                                               First => KartenDatentypen.WaagerechteNatural'First,
                                                                                                                                               Last  => LeseWeltkarteneinstellungen.Waagerechte / 2);
      
      KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Ostpol
        := KartentestsLogik.WaagerechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Osten_Enum));
      
   end ZufälligePole;

end ZufallsgeneratorenSpieleinstellungenLogik;
