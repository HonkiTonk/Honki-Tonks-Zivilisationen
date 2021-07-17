pragma SPARK_Mode (On);

with GlobaleKonstanten;

with ZufallGeneratorenKarten, KartePositionPruefen;

package body KartenGeneratorStandard is

   procedure StandardKarte
   is begin
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Nur_Land =>
            GenerierungNurLand;
            return;
            
         when others =>
            Karten.GeneratorKarte := (others => (others => (0)));
      end case;
      
      EisSchleife:
      for EisSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
         
         Karten.Weltkarte (0, 1, EisSchleifenwert).Grund := 1;
         Karten.Weltkarte (0, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße, EisSchleifenwert).Grund := 1;
         
      end loop EisSchleife;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            if
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 0
              and
                Karten.Kartenart = GlobaleDatentypen.Nur_Land
            then
               Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 3;

            elsif
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 0
            then
               Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 2;

            else
               null;
            end if;
            
            case Karten.Kartenart is
               when GlobaleDatentypen.Pangäa =>
                  GenerierungPangäa (YAchseExtern => YAchseSchleifenwert,
                                      XAchseExtern => XAchseSchleifenwert);
                  
               when others =>                     
                  GenerierungKartenart (YAchseExtern => YAchseSchleifenwert,
                                        XAchseExtern => XAchseSchleifenwert);
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StandardKarte;



   procedure GenerierungKartenart
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin

      BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;

      case
        Karten.GeneratorKarte (YAchseExtern, XAchseExtern)
      is
         when 1 .. 2 =>
            null;

         when 0 =>
            if
              YAchseExtern <= Karten.WeltkarteArray'First (2) + 3
              or
                YAchseExtern >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 3
            then
               if
                 BeliebigerLandwert > WahrscheinlichkeitenFürLand (Karten.Kartenart, 1)
                 and
                   BeliebigerLandwert < WahrscheinlichkeitenFürLand (Karten.Kartenart, 2)
               then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                           
               elsif
                 BeliebigerLandwert >= WahrscheinlichkeitenFürLand (Karten.Kartenart, 2)
               then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                  GenerierungLandmasse (YPositionLandmasseExtern => YAchseExtern,
                                        XPositionLandmasseExtern => XAchseExtern);
                           
               else
                  null;
               end if;
                              
            else
               if
                 BeliebigerLandwert > WahrscheinlichkeitenFürLand (Karten.Kartenart, 3)
                 and
                   BeliebigerLandwert < WahrscheinlichkeitenFürLand (Karten.Kartenart, 4)
               then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                                 
               elsif
                 BeliebigerLandwert >= WahrscheinlichkeitenFürLand (Karten.Kartenart, 4)
               then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                  GenerierungLandmasse (YPositionLandmasseExtern => YAchseExtern,
                                        XPositionLandmasseExtern => XAchseExtern);
                  
               else
                  null;
               end if;
            end if;

         when others =>
            if
              BeliebigerLandwert >= WahrscheinlichkeitenFürLand (Karten.Kartenart, 5)
            then                           
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
               
            else
               null;
            end if;
      end case;
      
   end GenerierungKartenart;

   
   
   procedure GenerierungLandmasse
     (YPositionLandmasseExtern, XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseEinsSchleife:
      for YÄnderungEinsSchleifenwert in -Karten.GrößeLandart (Karten.Kartenart) / 2 .. Karten.GrößeLandart (Karten.Kartenart) / 2 loop
         XAchseEinsSchleife:
         for XÄnderungEinsSchleifenwert in -Karten.GrößeLandart (Karten.Kartenart) / 2 .. Karten.GrößeLandart (Karten.Kartenart) / 2 loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => (0, YPositionLandmasseExtern, XPositionLandmasseExtern),
                                                                        ÄnderungExtern       => (0, YÄnderungEinsSchleifenwert, XÄnderungEinsSchleifenwert));

            if
              KartenWert.YAchse <= Karten.WeltkarteArray'First (2)
              or
                KartenWert.YAchse >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
              or
                KartenWert.XAchse = 0
            then
               null;
               
            else
               GenerierungLandmasseÜberhang (YAchseExtern  => KartenWert.YAchse,
                                              XAchseExtern  => KartenWert.XAchse);
            end if;
            
         end loop XAchseEinsSchleife;
      end loop YAchseEinsSchleife;
      
      -- Funktioniert nicht mit Kontinenten bei kleinen Karten weil der Abstandswert zu groß ist! An Kartengrößen angepasste Werte anlegen, wie bei der Kartenanzeige.
      YAchseZweiSchleife:
      for YÄnderungZweiSchleifenwert in -FelderVonLandartZuLandart (Karten.Kartenart) .. FelderVonLandartZuLandart (Karten.Kartenart) loop
         XAchseZweiSchleife:
         for XÄnderungZweiSchleifenwert in -FelderVonLandartZuLandart (Karten.Kartenart) .. FelderVonLandartZuLandart (Karten.Kartenart) loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => (0, YPositionLandmasseExtern, XPositionLandmasseExtern),
                                                                        ÄnderungExtern       => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert));
            
            if
              KartenWert.XAchse = 0
            then
               null;
               
            else            
               case
                 Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse)
               is
                  when 1 .. 2 =>
                     null;
                  
                  when others =>
                     Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := 3;                           
               end case;
            end if;
            
         end loop XAchseZweiSchleife; 
      end loop YAchseZweiSchleife; 
      
   end GenerierungLandmasse;
   
   
   
   procedure GenerierungLandmasseÜberhang
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
   
      BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;
      
      if
        BeliebigerLandwert >= WahrscheinlichkeitenFürLand (Karten.Kartenart, 6)
        and
          Karten.GeneratorKarte (YAchseExtern, XAchseExtern) = 0
      then
         Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
         Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := 1;

      elsif
        BeliebigerLandwert >= WahrscheinlichkeitenFürLand (Karten.Kartenart, 7)
      then
         Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
         Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := 1;
               
      else
         null;
      end if;
         
      
   end GenerierungLandmasseÜberhang;



   procedure GenerierungPangäa
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      if
        YAchseExtern = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2
        and
          XAchseExtern = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2
      then
         GenerierungLandmasse (YPositionLandmasseExtern => YAchseExtern,
                               XPositionLandmasseExtern => XAchseExtern);
        
      else
         BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;
         if
           BeliebigerLandwert >= WahrscheinlichkeitenFürLand (Karten.Kartenart, 2)
         then
            Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
            Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := 1;
         
         else
            null;
         end if;
      end if;
      
   end GenerierungPangäa;
   
   
   
   procedure GenerierungNurLand
   is begin
      
      EisSchleife:
      for EisSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
         
         Karten.Weltkarte (0, 1, EisSchleifenwert).Grund := 1;
         Karten.Weltkarte (0, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße, EisSchleifenwert).Grund := 1;
         
      end loop EisSchleife;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 3;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungNurLand;

end KartenGeneratorStandard;
