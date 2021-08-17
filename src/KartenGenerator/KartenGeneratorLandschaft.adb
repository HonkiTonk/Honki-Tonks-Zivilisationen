pragma SPARK_Mode (On);

with GlobaleKonstanten;

with ZufallGeneratorenKarten, KartePositionPruefen, LeseKarten, SchreibeKarten;

package body KartenGeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin

      Karten.GeneratorKarte := (others => (others => GlobaleDatentypen.Leer));
      Karten.GeneratorGrund := (others => (others => False));

      YAbstandObereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisschild (Karten.Kartengröße) loop
         XAbstandObereEisschichtSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.GeneratorKarte (YAchseSchleifenwert, XAchseSchleifenwert) := GlobaleDatentypen.Tundra;
            
         end loop XAbstandObereEisschichtSchleife;
      end loop YAbstandObereEisschichtSchleife;

      YAbstandUntereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisschild (Karten.Kartengröße) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAbstandUntereEisschichtSchleife:
         for XAchseSchleifenwert in Karten.Weltkarte'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.GeneratorKarte (YAchseSchleifenwert, XAchseSchleifenwert) := GlobaleDatentypen.Tundra;
            
         end loop XAbstandUntereEisschichtSchleife;
      end loop YAbstandUntereEisschichtSchleife;
            
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if
              LeseKarten.Grund (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert)) in GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
            then
               Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) := True;
               
            elsif
              Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = True
            then
               null;

            else
               LandschaftBestimmen (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            end if;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
   end GenerierungLandschaft;
   
   
   
   procedure LandschaftBestimmen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GrundSchleife:
      for GrundSchleifenwert in GlobaleDatentypen.Karten_Grund_Generator_Enum'Range loop
         
         case
           GrundSchleifenwert
         is
            when GlobaleDatentypen.Flachland =>
               Karten.GeneratorGrund (PositionExtern.YAchse, PositionExtern.XAchse) := True;
               return;
                     
            when others =>
               AnzahlGleicherGrund := 0;
         end case;
         
         if
           GrundSchleifenwert = GlobaleDatentypen.Wüste
           and
             Karten.GeneratorKarte (PositionExtern.YAchse, PositionExtern.XAchse) = GlobaleDatentypen.Tundra
         then
            null;
            
         elsif
           GrundSchleifenwert = GlobaleDatentypen.Tundra
           and
             Karten.GeneratorKarte (PositionExtern.YAchse, PositionExtern.XAchse) = GlobaleDatentypen.Wüste
         then
            null;
            
         else           
            YAchseSchleife:
            for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               XAchseSchleife:
               for XAchsenSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
                  KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                              ÄnderungExtern    => (0, YAchseSchleifenwert, XAchsenSchleifenwert));
               
                  if
                    KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
                  then
                     -- Prüfung für die Änderung (0, 0) nicht benötigt, da das Feld immer mit Flachland belegt sein sollte.
                     null;
                  
                  elsif
                    LeseKarten.Grund (PositionExtern => KartenWert) = GrundSchleifenwert
                  then
                     AnzahlGleicherGrund := AnzahlGleicherGrund + 1;
                  
                  else
                     null;
                  end if;
               
               end loop XAchseSchleife;
            end loop YAchseSchleife;
            
            if
              ZufallGeneratorenKarten.ZufälligerWert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GrundSchleifenwert, AnzahlGleicherGrund)
            then
               SchreibeKarten.Grund (PositionExtern => PositionExtern,
                                     GrundExtern    => GrundSchleifenwert);
               Karten.GeneratorGrund (PositionExtern.YAchse, PositionExtern.XAchse) := True;
               
               case
                 GrundSchleifenwert
               is
                  when GlobaleDatentypen.Wüste | GlobaleDatentypen.Tundra =>
                     AbstandTundraWüste (GrundExtern    => GrundSchleifenwert,
                                          PositionExtern => PositionExtern);
                     
                  when others =>
                     null;
               end case;
               
               case
                 GrundSchleifenwert
               is
                  when GlobaleDatentypen.Gebirge | GlobaleDatentypen.Hügel =>
                     null;
                     
                  when others =>
                     WeitereHügel (PositionExtern => PositionExtern);
               end case;
               
               return;
               
            else
               null;
            end if;
         end if;
         
      end loop GrundSchleife;
      
   end LandschaftBestimmen;
   
   
   
   procedure AbstandTundraWüste
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Generator_Enum;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop

            KartenWertAbstand := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                               ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            if
              KartenWertAbstand.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              Karten.GeneratorKarte (KartenWertAbstand.YAchse, KartenWertAbstand.XAchse) /= GlobaleDatentypen.Leer
            then
               null;
               
            else
               Karten.GeneratorKarte (KartenWertAbstand.YAchse, KartenWertAbstand.XAchse) := GrundExtern;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end AbstandTundraWüste;
   
   
   
   procedure WeitereHügel
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      AnzahlGleicherGrund := 0;
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XAchsenSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
            KartenWertHügel := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                              ÄnderungExtern    => (0, YAchseSchleifenwert, XAchsenSchleifenwert));
               
            if
              KartenWertHügel.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               -- Prüfung für die Änderung (0, 0) nicht benötigt, da das Feld nie mit Hügel belegt sein sollte.
               null;
                  
            elsif
              LeseKarten.Grund (PositionExtern => KartenWertHügel) = GlobaleDatentypen.Gebirge
              or
                LeseKarten.Grund (PositionExtern => KartenWertHügel) = GlobaleDatentypen.Hügel
            then
               AnzahlGleicherGrund := AnzahlGleicherGrund + 1;
                  
            else
               null;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      if
        ZufallGeneratorenKarten.ZufälligerWert <= ZusatzHügel (AnzahlGleicherGrund)
      then
         SchreibeKarten.Hügel (PositionExtern => PositionExtern,
                                HügelExtern   => True);
         
      else
         null;
      end if;
      
   end WeitereHügel;

end KartenGeneratorLandschaft;
