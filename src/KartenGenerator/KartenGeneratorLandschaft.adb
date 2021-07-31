pragma SPARK_Mode (On);

with GlobaleKonstanten;

with ZufallGeneratorenKarten, KartePositionPruefen;

package body KartenGeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin

      Karten.GeneratorKarte := (others => (others => GlobaleDatentypen.Leer));
      Karten.GeneratorGrund := (others => (others => False));

      YAbstandObereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisschild loop
         XAbstandObereEisschichtSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.GeneratorKarte (YAchseSchleifenwert, XAchseSchleifenwert) := GlobaleDatentypen.Tundra;
            
         end loop XAbstandObereEisschichtSchleife;
      end loop YAbstandObereEisschichtSchleife;

      YAbstandUntereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisschild .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAbstandUntereEisschichtSchleife:
         for XAchseSchleifenwert in Karten.Weltkarte'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.GeneratorKarte (YAchseSchleifenwert, XAchseSchleifenwert) := GlobaleDatentypen.Tundra;
            
         end loop XAbstandUntereEisschichtSchleife;
      end loop YAbstandUntereEisschichtSchleife;
            
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund in GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
            then
               Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) := True;

            else
               LandschaftBestimmen (YPositionExtern => YAchseSchleifenwert,
                                    XPositionExtern => XAchseSchleifenwert);
            end if;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;         
         
   end GenerierungLandschaft;
   
   
   
   procedure LandschaftBestimmen
     (YPositionExtern, XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      case
        Karten.GeneratorGrund (YPositionExtern, XPositionExtern)
      is
         when True =>
            return;
            
         when False =>
            BeliebigerLandschaftwert := ZufallGeneratorenKarten.ZufälligerWert;
      end case;
      
      if
        BeliebigerLandschaftwert
      in
        KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Tundra).Anfangswert .. KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Tundra).Endwert
        and
          Karten.GeneratorKarte (YPositionExtern, XPositionExtern) /= GlobaleDatentypen.Wüste
      then
         GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Tundra,
                                      YAchseExtern => YPositionExtern,
                                      XAchseExtern => XPositionExtern);

      elsif
        BeliebigerLandschaftwert
      in
        KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Wüste).Anfangswert .. KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Wüste).Endwert
        and
          Karten.GeneratorKarte (YPositionExtern, XPositionExtern) /= GlobaleDatentypen.Tundra
      then
         GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Wüste,
                                      YAchseExtern => YPositionExtern,
                                      XAchseExtern => XPositionExtern);

      elsif
        BeliebigerLandschaftwert
      in
        KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Hügel).Anfangswert .. KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Hügel).Endwert
      then
         GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Hügel,
                                      YAchseExtern => YPositionExtern,
                                      XAchseExtern => XPositionExtern);

      elsif
        BeliebigerLandschaftwert
      in
        KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Gebirge).Anfangswert .. KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Gebirge).Endwert
      then
         GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Gebirge,
                                      YAchseExtern => YPositionExtern,
                                      XAchseExtern => XPositionExtern);

      elsif
        BeliebigerLandschaftwert
      in
        KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Wald).Anfangswert .. KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Wald).Endwert
      then
         GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Wald,
                                      YAchseExtern => YPositionExtern,
                                      XAchseExtern => XPositionExtern);

      elsif
        BeliebigerLandschaftwert
      in
        KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Dschungel).Anfangswert .. KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Dschungel).Endwert
      then
         GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Dschungel,
                                      YAchseExtern => YPositionExtern,
                                      XAchseExtern => XPositionExtern);

      elsif
        BeliebigerLandschaftwert
      in
        KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Sumpf).Anfangswert .. KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GlobaleDatentypen.Sumpf).Endwert
      then
         GenerierungLandschaftFelder (GrundExtern  => GlobaleDatentypen.Sumpf,
                                      YAchseExtern => YPositionExtern,
                                      XAchseExtern => XPositionExtern);
                  
      else
         Karten.GeneratorGrund (YPositionExtern, XPositionExtern) := True;
      end if;
      
   end LandschaftBestimmen;



   procedure GenerierungLandschaftFelder
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseEinsSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeNullZuEins'Range loop
         XAchseEinsSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeNullZuEins'Range loop            
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));

            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
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
              Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund in GlobaleDatentypen.Karten_Grund_Wasser_Enum'Range
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
            
                  KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                              ÄnderungExtern    => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert));

                  if
                    KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
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
            
            KartenWertHügel := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                              ÄnderungExtern   => (0, YÄnderungHügelSchleifenwert, XÄnderungHügelSchleifenwert));

            if
              KartenWertHügel.XAchse = GlobaleKonstanten.LeerYXKartenWert
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
               if
                 Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund = GlobaleDatentypen.Flachland
               then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := GlobaleDatentypen.Hügel;
                    
               else
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
               end if;
                     
            else
               null;
            end if;
                  
         when 4 .. 7 =>
            if
              BeliebigerHügelwert >= 0.66
            then
               if
                 Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund = GlobaleDatentypen.Flachland
               then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := GlobaleDatentypen.Hügel;
                    
               else
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
               end if;
                     
            else
               null;
            end if;
                  
         when 8 =>
            if
              BeliebigerHügelwert >= 0.33
            then
               if
                 Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund = GlobaleDatentypen.Flachland
               then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := GlobaleDatentypen.Hügel;
                    
               else
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
               end if;
                     
            else
               null;
            end if;
                  
         when others =>
            if
              BeliebigerHügelwert >= 0.95
            then
               if
                 Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund = GlobaleDatentypen.Flachland
               then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := GlobaleDatentypen.Hügel;
                    
               else
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
               end if;
                     
            else
               null;
            end if;
      end case;
      
   end GenerierungLandschaftHügel;

end KartenGeneratorLandschaft;
