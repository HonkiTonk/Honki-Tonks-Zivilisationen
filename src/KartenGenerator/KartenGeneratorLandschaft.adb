pragma SPARK_Mode (On);

with GlobaleKonstanten;

with ZufallGeneratorenKarten, KartenPruefungen;

package body KartenGeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin

      Karten.GeneratorKarte := (others => (others => (0)));
      Karten.GeneratorGrund := (others => (others => (False)));

      YAbstandEisschichtEinsSchleife:
      for YAchseEinsSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.WeltkarteArray'First (2) + 3 loop
         XAbstandEisschichtEinsSchleife:
         for XAchseEinsSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.GeneratorKarte (YAchseEinsSchleifenwert, XAchseEinsSchleifenwert) := 4;
            
         end loop XAbstandEisschichtEinsSchleife;
      end loop YAbstandEisschichtEinsSchleife;

      YAbstandEisschichtZweiSchleife:
      for YAchseZweiSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 3 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAbstandEisschichtZweiSchleife:
         for XAchseZweiSchleifenwert in Karten.Weltkarte'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.GeneratorKarte (YAchseZweiSchleifenwert, XAchseZweiSchleifenwert) := 4;
            
         end loop XAbstandEisschichtZweiSchleife;
      end loop YAbstandEisschichtZweiSchleife;
            
      YAchseSchleife:
      for YAchseDreiSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseDreiSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if
              Karten.Weltkarte (0, YAchseDreiSchleifenwert, XAchseDreiSchleifenwert).Grund < 3
              or
                Karten.Weltkarte (0, YAchseDreiSchleifenwert, XAchseDreiSchleifenwert).Grund = 31
            then
               Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) := True;

            else
               BeliebigerLandschaftwert := ZufallGeneratorenKarten.ZufälligerWert;
               if
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 4)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
                 and
                   Karten.GeneratorKarte (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) /= 5
               then
                  GenerierungLandschaftFelder (GrundExtern  => 4,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 5)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
                 and
                   Karten.GeneratorKarte (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) /= 4
               then
                  GenerierungLandschaftFelder (GrundExtern  => 5,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 6)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => 6,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 7)
                 and Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => 7,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 8)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => 8,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 9)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => 9,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif
                 BeliebigerLandschaftwert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, 10)
                 and
                   Karten.GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
               then
                  GenerierungLandschaftFelder (GrundExtern  => 32,
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
     (GrundExtern : in GlobaleDatentypen.KartenGrund;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseEinsSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeNullZuEins'Range loop
         XAchseEinsSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeNullZuEins'Range loop            
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseExtern, XAchseExtern),
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 1);

            case
              KartenWert.Erfolgreich
            is
               when False =>
                  exit XAchseEinsSchleife;
                  
               when True =>
                  if
                    Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund < 3
                    or
                      Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund = 31
                  then
                     null;
                     
                  elsif
                    YÄnderungSchleifenwert = 0
                    and
                      XÄnderungSchleifenwert = 0
                  then
                     Karten.Weltkarte (0, KartenWert.YAchse, KartenWert.XAchse).Grund := GrundExtern;
                     Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                     
                  else
                     BeliebigerLandschaftFeldwert := ZufallGeneratorenKarten.ZufälligerWert;
                     if
                       BeliebigerLandschaftFeldwert > 0.50
                       and
                         Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) = False
                     then
                        if
                          GrundExtern = 4
                          and
                            Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = 5
                        then
                           null;
                           
                        elsif
                          GrundExtern = 5
                          and
                            Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = 4
                        then
                           null;
                           
                        else
                           Karten.Weltkarte (0, KartenWert.YAchse, KartenWert.XAchse).Grund := GrundExtern;
                           Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                        end if;
                        
                     else
                        Karten.GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;                       
                     end if;
                  end if;
            end case;

            case
              GrundExtern
            is
               when 6 | 7 => -- Hügel - Gebirge
                  null;
                  
               when others =>
                  GenerierungLandschaftHügel (YAchseExtern => KartenWert.YAchse,
                                               XAchseExtern => KartenWert.XAchse);
            end case;
            
         end loop XAchseEinsSchleife;
      end loop YAchseEinsSchleife;      

      case
        GrundExtern
      is
         when 4 | 5 => -- Tundra - Wüste
            YAchseZweiSchleife:
            for YÄnderungZweiSchleifenwert in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
               XAchseZweiSchleife:
               for XÄnderungZweiSchleifenwert in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
            
                  KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseExtern, XAchseExtern),
                                                                          ÄnderungExtern       => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert),
                                                                          ZusatzYAbstandExtern => 1);

                  case
                    KartenWert.Erfolgreich
                  is
                     when False =>
                        exit XAchseZweiSchleife;
                  
                     when True =>
                        null;
                  end case;
                  
                  if
                    Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) /= 0
                  then
                     null;
                                     
                  else
                     Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := GlobaleDatentypen.Kartenfeld (GrundExtern);
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
            
            KartenWertHügel := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseExtern, XAchseExtern),
                                                                          ÄnderungExtern       => (0, YÄnderungHügelSchleifenwert, XÄnderungHügelSchleifenwert),
                                                                          ZusatzYAbstandExtern => 1);

            case
              KartenWertHügel.Erfolgreich
            is
               when False =>
                  exit XAchseHügelSchleife;
                  
               when True =>
                  null;
            end case;
            
            if
              YÄnderungHügelSchleifenwert = 0
              and
                XÄnderungHügelSchleifenwert = 0
            then
               null;
                                 
            elsif
              Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Grund = 6
              or
                Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Grund = 7
              or
                Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Hügel = True
            then
               HügelGebirgeUmgebung := HügelGebirgeUmgebung + 1;
                                 
            else
               null;
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
