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
   
   
   
   function ZufälligeKartenebenen
     return KartenRecords.KartenebenenVorhandenRecord
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      ZufälligeKartenebenenWählen.Reset (Gen => ZufälligeKartenebenenGewählt);
      
      Ebenen.EbeneAnfang := ZufälligeKartenebenenWählen.Random (Gen   => ZufälligeKartenebenenGewählt,
                                                                  First => KartenKonstanten.KernKonstante,
                                                                  Last  => KartenKonstanten.OberflächeKonstante);
      
      case
        Ebenen.EbeneAnfang
      is
         when KartenKonstanten.KernKonstante =>
            Ebenen.EbeneEnde := ZufälligeKartenebenenWählen.Random (Gen   => ZufälligeKartenebenenGewählt,
                                                                      First => KartenKonstanten.UnterflächeKonstante,
                                                                      Last  => KartenKonstanten.OrbitKonstante);
         
         when others =>
            Ebenen.EbeneEnde := ZufälligeKartenebenenWählen.Random (Gen   => ZufälligeKartenebenenGewählt,
                                                                      First => Ebenen.EbeneAnfang,
                                                                      Last  => KartenKonstanten.OrbitKonstante);
      end case;
      
      return Ebenen;
      
   end ZufälligeKartenebenen;
   
   
   
   function ZufälligeVordefinierteKartenart
     return KartenartDatentypen.Kartenart_Normal_Enum
   is begin
      
      ZufälligeKartenartWählen.Reset (Gen => ZufälligeKartenartGewählt);
      return ZufälligeKartenartWählen.Random (Gen => ZufälligeKartenartGewählt);
      
   end ZufälligeVordefinierteKartenart;
   
   
   
   procedure ZufälligeKartenart
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      ZufälligeKartensenkrechteWählen.Reset (Gen => ZufälligeKartensenkrechteGewählt);
      ZufälligeKartenwaagerechteWählen.Reset (Gen => ZufälligeKartenwaagerechteGewählt);
      
      Landgröße.MinimaleSenkrechte := ZufälligeKartensenkrechteWählen.Random (Gen   => ZufälligeKartensenkrechteGewählt,
                                                                                  First => KartenDatentypen.SenkrechtePositiv'First,
                                                                                  Last  => LeseWeltkarteneinstellungen.Senkrechte / 2);
      
      Landgröße.MaximaleSenkrechte := ZufälligeKartensenkrechteWählen.Random (Gen   => ZufälligeKartensenkrechteGewählt,
                                                                                  First => Landgröße.MinimaleSenkrechte,
                                                                                  Last  => LeseWeltkarteneinstellungen.Senkrechte / 2);
      
      Landgröße.MinimaleWaagerechte := ZufälligeKartenwaagerechteWählen.Random (Gen   => ZufälligeKartenwaagerechteGewählt,
                                                                                    First => KartenDatentypen.WaagerechtePositiv'First,
                                                                                    Last  => LeseWeltkarteneinstellungen.Waagerechte / 2);
      
      Landgröße.MaximaleWaagerechte := ZufälligeKartenwaagerechteWählen.Random (Gen   => ZufälligeKartenwaagerechteGewählt,
                                                                                    First => Landgröße.MinimaleWaagerechte,
                                                                                    Last  => LeseWeltkarteneinstellungen.Waagerechte / 2);
      
      KartengeneratorVariablenLogik.LandgrößenSchreiben (GrößeExtern => Landgröße);
      
   end ZufälligeKartenart;
   
   
   
   procedure ZufälligeKartenform
   is begin
      
      ZufälligerEbeneÜbergangWählen.Reset (Gen => ZufälligerEbeneÜbergangGewählt);
      ZufälligerSenkrechteÜbergangWählen.Reset (Gen => ZufälligerSenkrechteÜbergangGewählt);
      ZufälligerWaagerechteÜbergangWählen.Reset (Gen => ZufälligerWaagerechteÜbergangGewählt);
      
      KartengeneratorVariablenLogik.KartenformSchreiben (FormExtern => (ZufälligerEbeneÜbergangWählen.Random (Gen => ZufälligerEbeneÜbergangGewählt),
                                                                        ZufälligerEbeneÜbergangWählen.Random (Gen => ZufälligerEbeneÜbergangGewählt),
                                                                        ZufälligerSenkrechteÜbergangWählen.Random (Gen => ZufälligerSenkrechteÜbergangGewählt),
                                                                        ZufälligerSenkrechteÜbergangWählen.Random (Gen => ZufälligerSenkrechteÜbergangGewählt),
                                                                        ZufälligerWaagerechteÜbergangWählen.Random (Gen => ZufälligerWaagerechteÜbergangGewählt),
                                                                        ZufälligerWaagerechteÜbergangWählen.Random (Gen => ZufälligerWaagerechteÜbergangGewählt)));
      
   end ZufälligeKartenform;

   
   
   function ZufälligeKartentemperatur
     return KartenartDatentypen.Kartentemperatur_Enum
   is begin
      
      ZufälligeKartentemperaturWählen.Reset (Gen => ZufälligeKartentemperaturGewählt);
      return ZufälligeKartentemperaturWählen.Random (Gen => ZufälligeKartentemperaturGewählt);
      
   end ZufälligeKartentemperatur;

   
   
   function ZufälligeKartenrohstoffe
     return KartenartDatentypen.Kartenrohstoffemenge_Enum
   is begin
      
      ZufälligeKartenrohstoffeWählen.Reset (Gen => ZufälligeKartenrohstoffeGewählt);
      return ZufälligeKartenrohstoffeWählen.Random (Gen => ZufälligeKartenrohstoffeGewählt);
      
   end ZufälligeKartenrohstoffe;
   
   
   
   function ZufälligeSpezies
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return SpeziesDatentypen.Spezies_Vorhanden_Enum
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      ZufälligeSpeziesWählen.Reset (Gen => ZufälligeSpeziesGewählt);
      
      if
        EbenenExtern.EbeneAnfang > KartenKonstanten.UnterflächeKonstante
      then
         return ZufälligeSpeziesWählen.Random (Gen   => ZufälligeSpeziesGewählt,
                                                 First => SpeziesDatentypen.Spezies_Oberfläche_Enum'First,
                                                 Last  => SpeziesDatentypen.Spezies_Oberfläche_Enum'Last);
         
      elsif
        EbenenExtern.EbeneEnde < KartenKonstanten.OberflächeKonstante
      then
         return ZufälligeSpeziesWählen.Random (Gen   => ZufälligeSpeziesGewählt,
                                                 First => SpeziesDatentypen.Spezies_Unterfläche_Enum'First,
                                                 Last  => SpeziesDatentypen.Spezies_Unterfläche_Enum'Last);
      
      else
         return ZufälligeSpeziesWählen.Random (Gen => ZufälligeSpeziesGewählt);
      end if;
      
   end ZufälligeSpezies;
   
   
   
   procedure ZufälligeSpeziesbelegung
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
   is
      use type SpeziesDatentypen.Spieler_Enum;
      use type KartenDatentypen.EbeneBasis;
   begin
      
      SpielerVorhanden := False;
      SchreibeSpeziesbelegung.Standardeinstellungen;
      ZufälligeSpeziesbelegungWählen.Reset (Gen => ZufälligeSpeziesbelegungGewählt);
      
      SpielerSchleife:
      while SpielerVorhanden = False loop
         SpeziesSchleife:
         for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
            if
              EbenenExtern.EbeneAnfang > KartenKonstanten.UnterflächeKonstante
              and
                SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Unterfläche_Enum'Range
            then
               null;
         
            elsif
              EbenenExtern.EbeneEnde < KartenKonstanten.OberflächeKonstante
              and
                SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Oberfläche_Enum'Range
            then
               null;
      
            else
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
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      -- Die Pole mal in ein Array basteln? äöü
      ZufälligeSenkrechtePolgrößenWählen.Reset (Gen => ZufälligeSenkrechtePolgrößeGewählt);
      ZufälligeWaagerechtePolgrößenWählen.Reset (Gen => ZufälligeWaagerechtePolgrößeGewählt);
      
      KartengeneratorVariablenLogik.SenkrechterPolSchreiben (SenkrechteExtern      => ZufälligeSenkrechtePolgrößenWählen.Random (Gen   => ZufälligeSenkrechtePolgrößeGewählt,
                                                                                                                                     First => KartenDatentypen.SenkrechteNatural'First,
                                                                                                                                     Last  => LeseWeltkarteneinstellungen.Senkrechte / 2),
                                                             HimmelsrichtungExtern => KartenartDatentypen.Norden_Enum);
      
      Kartenpole.Nordpol := KartentestsLogik.SenkrechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Norden_Enum));
      
      
            
      KartengeneratorVariablenLogik.SenkrechterPolSchreiben (SenkrechteExtern      => ZufälligeSenkrechtePolgrößenWählen.Random (Gen   => ZufälligeSenkrechtePolgrößeGewählt,
                                                                                                                                     First => KartenDatentypen.SenkrechteNatural'First,
                                                                                                                                     Last  => LeseWeltkarteneinstellungen.Senkrechte / 2),
                                                             HimmelsrichtungExtern => KartenartDatentypen.Süden_Enum);
      
      Kartenpole.Südpol := KartentestsLogik.SenkrechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Süden_Enum));
      
            
      
      KartengeneratorVariablenLogik.WaagerechterPolSchreiben (WaagerechteExtern     => ZufälligeWaagerechtePolgrößenWählen.Random (Gen   => ZufälligeWaagerechtePolgrößeGewählt,
                                                                                                                                       First => KartenDatentypen.WaagerechteNatural'First,
                                                                                                                                       Last  => LeseWeltkarteneinstellungen.Waagerechte / 2),
                                                              HimmelsrichtungExtern => KartenartDatentypen.Westen_Enum);
      
      Kartenpole.Westpol := KartentestsLogik.WaagerechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Westen_Enum));
      
            
      
      KartengeneratorVariablenLogik.WaagerechterPolSchreiben (WaagerechteExtern     => ZufälligeWaagerechtePolgrößenWählen.Random (Gen   => ZufälligeWaagerechtePolgrößeGewählt,
                                                                                                                                       First => KartenDatentypen.WaagerechteNatural'First,
                                                                                                                                       Last  => LeseWeltkarteneinstellungen.Waagerechte / 2),
                                                              HimmelsrichtungExtern => KartenartDatentypen.Osten_Enum);
      
      Kartenpole.Ostpol := KartentestsLogik.WaagerechteKartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Osten_Enum));
      
      KartengeneratorVariablenLogik.KartenpoleSchreiben (PoleExtern => Kartenpole);
      
   end ZufälligePole;

end ZufallsgeneratorenSpieleinstellungenLogik;
