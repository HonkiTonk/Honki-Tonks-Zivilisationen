pragma SPARK_Mode (On);

with GlobaleKonstanten;

with ZufallGeneratorenKarten, KartePositionPruefen;

package body KartenGeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin

      Karten.GeneratorKarte := (others => (others => GlobaleDatentypen.Leer));
      Karten.GeneratorGrund := (others => (others => False));

      YAbstandEisschichtEinsSchleife:
      for YAchseEinsSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisschild loop
         XAbstandEisschichtEinsSchleife:
         for XAchseEinsSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.GeneratorKarte (YAchseEinsSchleifenwert, XAchseEinsSchleifenwert) := GlobaleDatentypen.Tundra;
            
         end loop XAbstandEisschichtEinsSchleife;
      end loop YAbstandEisschichtEinsSchleife;

      YAbstandEisschichtZweiSchleife:
      for YAchseZweiSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisschild .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAbstandEisschichtZweiSchleife:
         for XAchseZweiSchleifenwert in Karten.Weltkarte'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.GeneratorKarte (YAchseZweiSchleifenwert, XAchseZweiSchleifenwert) := GlobaleDatentypen.Tundra;
            
         end loop XAbstandEisschichtZweiSchleife;
      end loop YAbstandEisschichtZweiSchleife;
            
      YAchseSchleife:
      for YAchseDreiSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseDreiSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if
              Karten.Weltkarte (0, YAchseDreiSchleifenwert, XAchseDreiSchleifenwert).Grund in GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
            then
               Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) := True;

            else
               BeliebigerLandschaftwert := ZufallGeneratorenKarten.ZufälligerWert;
               if
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 4)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
                 and
                   Karten.GeneratorKarte (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) /= GlobaleDatentypen.Wüste
               then
                  GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Tundra,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 5)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
                 and
                   Karten.GeneratorKarte (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) /= GlobaleDatentypen.Tundra
               then
                  GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Wüste,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 6)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Hügel,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 7)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Gebirge,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 8)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Wald,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 9)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Dschungel,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 10)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Sumpf,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);
                  
               else
                  Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) := True;
               end if;
            end if;            
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;         
         
   end GenerierungLandschaft;



   procedure GenerierungLandschaftFelder
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseEinsSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeNullZuEins'Range loop
         XAchseEinsSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeNullZuEins'Range loop            
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseExtern, XAchseExtern),
                                                                        ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));

            if
              KartenWert.XAchse = 0
              or
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund in GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
            then
               null;
                     
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund := GrundExtern;
               Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                     
            else
               BeliebigerLandschaftFeldwert := ZufallGeneratorenKarten.ZufälligerWert;
               if
                 BeliebigerLandschaftFeldwert > 0.50
                 and
                   Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) = False
               then
                  if
                    GrundExtern = GlobaleDatentypen.Tundra
                    and
                      Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = GlobaleDatentypen.Wüste
                  then
                     null;
                           
                  elsif
                    GrundExtern = GlobaleDatentypen.Wüste
                    and
                      Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = GlobaleDatentypen.Tundra
                  then
                     null;
                           
                  else
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund := GrundExtern;
                     Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                  end if;
                        
               else
                  Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;                       
               end if;
            end if;

            if
              -- Hügel - Gebirge
              GrundExtern = GlobaleDatentypen.Hügel
              or
                GrundExtern = GlobaleDatentypen.Gebirge
            then
               null;
               
            elsif
              Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund in GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
            then
               null;
               
            else
               GenerierungLandschaftHügel (YAchseExtern => KartenWert.YAchse,
                                            XAchseExtern => KartenWert.XAchse);
            end if;
            
         end loop XAchseEinsSchleife;
      end loop YAchseEinsSchleife;      

      case
        GrundExtern
      is
         when GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste =>
            YAchseZweiSchleife:
            for YÄnderungZweiSchleifenwert in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
               XAchseZweiSchleife:
               for XÄnderungZweiSchleifenwert in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
            
                  KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseExtern, XAchseExtern),
                                                                              ÄnderungExtern       => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert));

                  if
                    KartenWert.XAchse = 0
                  then
                     null;
                     
                  elsif
                    Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) /= GlobaleDatentypen.Leer
                  then
                     null;
                    
                  else
                     Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := GrundExtern;
                  end if;
                  
               end loop XAchseZweiSchleife;
            end loop YAchseZweiSchleife;
            
         when others =>
            null;
      end case;
      
   end GenerierungLandschaftFelder;



   procedure GenerierungLandschaftHügel
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      HügelGebirgeUmgebung := 0;
      YAchseHügelSchleife:
      for YÄnderungHügelSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseHügelSchleife:
         for XÄnderungHügelSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop            
            
            KartenWertHügel := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern     => (0, YAchseExtern, XAchseExtern),
                                                                              ÄnderungExtern       => (0, YÄnderungHügelSchleifenwert, XÄnderungHügelSchleifenwert));

            if
              KartenWertHügel.XAchse = 0
            then
               null;
               
            else            
               if
                 YÄnderungHügelSchleifenwert = 0
                 and
                   XÄnderungHügelSchleifenwert = 0
               then
                  null;
                                 
               elsif
                 Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Grund = GlobaleDatentypen.Hügel
                 or
                   Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Grund = GlobaleDatentypen.Gebirge
                 or
                   Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Hügel = True
               then
                  HügelGebirgeUmgebung := HügelGebirgeUmgebung + 1;
                                 
               else
                  null;
               end if;  
            end if;
            
         end loop XAchseHügelSchleife;
      end loop YAchseHügelSchleife;

      BeliebigerHügelwert := ZufallGeneratorenKarten.ZufälligerWert;

      case
        HügelGebirgeUmgebung
      is                  
         when 1 .. 3 =>
            if
              BeliebigerHügelwert >= 0.85
            then
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
                     
            else
               null;
            end if;
                  
         when 4 .. 7 =>
            if
              BeliebigerHügelwert >= 0.66
            then
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
                     
            else
               null;
            end if;
                  
         when 8 =>
            if
              BeliebigerHügelwert >= 0.33
            then
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
                     
            else
               null;
            end if;
                  
         when others =>
            if
              BeliebigerHügelwert >= 0.95
            then
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
                     
            else
               null;
            end if;
      end case;
      
   end GenerierungLandschaftHügel;

end KartenGeneratorLandschaft;
