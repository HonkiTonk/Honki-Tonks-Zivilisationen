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
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund in GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum
            then
               null;
               
            elsif
              BeliebigerFlusswert <= WahrscheinlichkeitFluss (Karten.Kartentemperatur)
            then
               Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Fluss := StandardFluss;
               
            else
               FlussUmgebungTesten (YKoordinateExtern => YAchseSchleifenwert,
                                    XKoordinateExtern => XAchseSchleifenwert);
            end if;

            case
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Fluss
            is
               when GlobaleDatentypen.Leer =>
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
                  
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (0, YKoordinateExtern, XKoordinateExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                     
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.YAchse).Fluss /= GlobaleDatentypen.Leer
              and
                BeliebigerFlusswert <= WahrscheinlichkeitFluss (Karten.Kartentemperatur) * 1.25
            then                        
               Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := StandardFluss;
               return;

            else
               null;
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
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              XÄnderungSchleifenwert = -1
              and
                YÄnderungSchleifenwert = 0
            then
               case
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss
               is
                  when GlobaleDatentypen.Leer =>
                     Flusswert := Flusswert - 1_000;

                  when GlobaleDatentypen.Fluss_Senkrecht =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Rechts;
                     
                  when GlobaleDatentypen.Flusskurve_Unten_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Unten;

                  when GlobaleDatentypen.Flusskurve_Oben_Links =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Oben;

                  when GlobaleDatentypen.Flusskreuzung_Drei_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Vier;

                  when GlobaleDatentypen.Flussendstück_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Fluss_Waagrecht;

                  when GlobaleDatentypen.Flussendstück_Unten =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskurve_Oben_Rechts;

                  when GlobaleDatentypen.Flussendstück_Oben =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskurve_Unten_Rechts;
                     
                  when GlobaleDatentypen.Fluss_Einzeln =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flussendstück_Links;
                     
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
                  when GlobaleDatentypen.Leer =>
                     Flusswert := Flusswert - 100;

                  when GlobaleDatentypen.Fluss_Senkrecht =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Links;
                     
                  when GlobaleDatentypen.Flusskurve_Unten_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Unten;

                  when GlobaleDatentypen.Flusskurve_Oben_Rechts =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Oben;

                  when GlobaleDatentypen.Flusskreuzung_Drei_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Vier;

                  when GlobaleDatentypen.Flussendstück_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Fluss_Waagrecht;

                  when GlobaleDatentypen.Flussendstück_Unten =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskurve_Oben_Links;

                  when GlobaleDatentypen.Flussendstück_Oben =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskurve_Unten_Links;
                     
                  when GlobaleDatentypen.Fluss_Einzeln =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flussendstück_Rechts;
                     
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
                  when GlobaleDatentypen.Leer =>
                     Flusswert := Flusswert - 10;
                     
                  when GlobaleDatentypen.Fluss_Waagrecht =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Unten;
                     
                  when GlobaleDatentypen.Flusskurve_Oben_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Rechts;

                  when GlobaleDatentypen.Flusskurve_Oben_Links =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Links;

                  when GlobaleDatentypen.Flusskreuzung_Drei_Oben =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Vier;

                  when GlobaleDatentypen.Flussendstück_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskurve_Unten_Rechts;

                  when GlobaleDatentypen.Flussendstück_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskurve_Unten_Links;

                  when GlobaleDatentypen.Flussendstück_Unten =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Fluss_Senkrecht;
                     
                  when GlobaleDatentypen.Fluss_Einzeln =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flussendstück_Oben;
                     
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
                  when GlobaleDatentypen.Leer =>
                     Flusswert := Flusswert - 1;
                     
                  when GlobaleDatentypen.Fluss_Waagrecht =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Oben;
                     
                  when GlobaleDatentypen.Flusskurve_Unten_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Rechts;

                  when GlobaleDatentypen.Flusskurve_Unten_Links =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Links;

                  when GlobaleDatentypen.Flusskreuzung_Drei_Unten =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskreuzung_Vier;

                  when GlobaleDatentypen.Flussendstück_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskurve_Oben_Rechts;

                  when GlobaleDatentypen.Flussendstück_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flusskurve_Oben_Links;

                  when GlobaleDatentypen.Flussendstück_Oben =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Fluss_Senkrecht;
                     
                  when GlobaleDatentypen.Fluss_Einzeln =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := GlobaleDatentypen.Flussendstück_Unten;
                     
                  when others =>
                     null;
               end case;
               Flusswert := Flusswert + 1;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      case
        Flusswert
      is
         when 11_111 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskreuzung_Vier;

         when 11_110 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Oben;

         when 11_101 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Unten;
            
         when 11_100 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Fluss_Waagrecht;
            
         when 11_011 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Links;

         when 11_010 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskurve_Oben_Links;

         when 11_001 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskurve_Unten_Links;
            
         when 11_000 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flussendstück_Rechts;

         when 10_111 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskreuzung_Drei_Rechts;

         when 10_110 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskurve_Oben_Rechts;

         when 10_101 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flusskurve_Unten_Rechts;

         when 10_100 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flussendstück_Links;

         when 10_010 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flussendstück_Unten;

         when 10_011 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Fluss_Senkrecht;

         when 10_001 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Flussendstück_Oben;
         
         when others =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := GlobaleDatentypen.Fluss_Einzeln;
      end case;
      
   end FlussBerechnung;

end KartenGeneratorFluss;
