pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen, ZufallGeneratorenKarten;

package body KartenGeneratorFluss is

   procedure GenerierungFlüsse
   is begin
      
      YAchseEinsSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseEinsSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            

            BeliebigerFlusswert := ZufallGeneratorenKarten.ZufälligerWert;
            
            if
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund < 3
              or
                Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 31
            then
               null;
               
            elsif
              BeliebigerFlusswert >= WahrscheinlichkeitFluss
            then
               Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Fluss := StandardFluss;
               
            else
               FlussUmgebungTesten (YKoordinateExtern => YAchseSchleifenwert,
                                    XKoordinateExtern => XAchseSchleifenwert);
            end if;

            case
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Fluss
            is
               when 0 =>
                  null;
                  
               when others =>
                  FlussBerechnung (YKoordinateExtern => YAchseSchleifenwert,
                                   XKoordinateExtern => XAchseSchleifenwert);
            end case;
         
         end loop XAchseEinsSchleife;
      end loop YAchseEinsSchleife;
      
   end GenerierungFlüsse;
   
   
   
   procedure FlussUmgebungTesten
     (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseZweiSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseZweiSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => (0, YKoordinateExtern, XKoordinateExtern),
                                                                        ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                     
            if
              KartenWert.XAchse = 0
            then
               null;
               
            else                     
               if
                 Karten.Weltkarte (0, KartenWert.YAchse, KartenWert.YAchse).Fluss /= 0
                 and
                   BeliebigerFlusswert >= WahrscheinlichkeitFluss / 1.25
               then                        
                  Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := StandardFluss;

               else
                  null;
               end if;
            end if;
                     
         end loop XAchseZweiSchleife;
      end loop YAchseZweiSchleife;
      
   end FlussUmgebungTesten;



   procedure FlussBerechnung
     (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
                    
      Flusswert := 10_000;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => (0, YKoordinateExtern, XKoordinateExtern),
                                                                        ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));

            if
              KartenWert.XAchse = 0
            then
               null;
               
            else            
               if
                 XÄnderungSchleifenwert = -1
                 and
                   YÄnderungSchleifenwert = 0
               then
                  case
                    Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss
                  is
                     when 0 =>
                        Flusswert := Flusswert - 1_000;

                     when 16 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;
                     
                     when 18 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;

                     when 20 =>                     
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;

                     when 24 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                     when 26 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 15;

                     when 27 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 19;

                     when 28 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 17;
                     
                     when 43 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 25;
                     
                     when others =>
                        null;
                  end case;
                  Flusswert := Flusswert + 1_000;
               
               elsif
                 XÄnderungSchleifenwert = 1
                 and
                   YÄnderungSchleifenwert = 0
               then
                  case
                    Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss
                  is
                     when 0 =>
                        Flusswert := Flusswert - 100;

                     when 16 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;
                     
                     when 17 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;

                     when 19 =>                     
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;

                     when 23 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                     when 25 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 15;

                     when 27 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 20;

                     when 28 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 18;
                     
                     when 43 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 26;
                     
                     when others =>
                        null;
                  end case;
                  Flusswert := Flusswert + 100;
               
               elsif
                 YÄnderungSchleifenwert = -1
                 and
                   XÄnderungSchleifenwert = 0
               then
                  case
                    Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss
                  is
                     when 0 =>
                        Flusswert := Flusswert - 10;
                     
                     when 15 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;
                     
                     when 19 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;

                     when 20 =>                     
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;

                     when 21 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                     when 25 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 17;

                     when 26 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 18;

                     when 27 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 16;
                     
                     when 43 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 28;
                     
                     when others =>
                        null;
                  end case;
                  Flusswert := Flusswert + 10;
               
               elsif
                 YÄnderungSchleifenwert = 1
                 and
                   XÄnderungSchleifenwert = 0
               then
                  case
                    Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss
                  is
                     when 0 =>
                        Flusswert := Flusswert - 1;
                     
                     when 15 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;
                     
                     when 17 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;

                     when 18 =>                     
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;

                     when 22 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                     when 25 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 19;

                     when 26 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 20;

                     when 28 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 16;
                     
                     when 43 =>
                        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 27;
                     
                     when others =>
                        null;
                  end case;
                  Flusswert := Flusswert + 1;
               
               else
                  null;
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      case
        Flusswert
      is
         when 11_000 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 26;

         when 10_100 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 25;

         when 10_010 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 27;

         when 10_001 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 28;

         when 11_010 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 20;

         when 11_001 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 18;

         when 11_110 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 21;

         when 11_101 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 22;

         when 11_111 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 14;

         when 10_110 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 19;

         when 10_101 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 17;

         when 10_111 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 23;

         when 10_011 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 16;
         
         when others =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 43;
      end case;
      
   end FlussBerechnung;

end KartenGeneratorFluss;
