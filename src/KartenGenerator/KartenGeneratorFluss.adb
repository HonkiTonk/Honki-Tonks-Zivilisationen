pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeKarten;
with LeseKarten;

with KartePositionPruefen, ZufallGeneratorenKarten;

package body KartenGeneratorFluss is

   procedure GenerierungFlüsse
   is 
   
      task Lavaflüsse;
      task UnterirdischeFlüsse;
      
      task body Lavaflüsse
      is begin
         
         FlussGenerierung (EbeneExtern => -2);
         
      end Lavaflüsse;
      
      task body UnterirdischeFlüsse
      is begin
         
         FlussGenerierung (EbeneExtern => -1);
         
      end UnterirdischeFlüsse;
      
   begin
      
      FlussGenerierung (EbeneExtern => 0);
      
   end GenerierungFlüsse;
   
   
   
   procedure FlussGenerierung
     (EbeneExtern : in GlobaleDatentypen.EbeneVorhanden)
   is begin
      
      YAchseEinsSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseEinsSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            

            BeliebigerFlusswert (EbeneExtern) := ZufallGeneratorenKarten.ZufälligerWert;
            
            if
              LeseKarten.Grund (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum
              or
                LeseKarten.Grund (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = GlobaleDatentypen.Lava
                or
                  LeseKarten.Grund (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = GlobaleDatentypen.Planetenkern
                  or
                    LeseKarten.Grund (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = GlobaleDatentypen.Korallen
                    or
                      LeseKarten.Grund (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = GlobaleDatentypen.Unterwasser_Wald
            then
               null;
               
            elsif
              BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (Karten.Kartentemperatur)
            then
               SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert),
                                     FlussExtern    => StandardFluss (EbeneExtern));
               
            else
               FlussUmgebungTesten (YKoordinateExtern => YAchseSchleifenwert,
                                    XKoordinateExtern => XAchseSchleifenwert,
                                    EbeneExtern       => EbeneExtern);
            end if;

            case
              LeseKarten.Fluss (PositionExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when GlobaleDatentypen.Leer =>
                  null;
                  
               when others =>
                  FlussBerechnung (YKoordinateExtern => YAchseSchleifenwert,
                                   XKoordinateExtern => XAchseSchleifenwert,
                                   EbeneExtern       => EbeneExtern);
            end case;
         
         end loop XAchseEinsSchleife;
      end loop YAchseEinsSchleife;
      
   end FlussGenerierung;
   
   
   
   procedure FlussUmgebungTesten
     (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv;
      EbeneExtern : in GlobaleDatentypen.EbeneVorhanden)
   is begin
      
      YAchseZweiSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseZweiSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
            KartenWertTesten (EbeneExtern) := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                                                                            ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                     
            if
              KartenWertTesten (EbeneExtern).XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              LeseKarten.Fluss (PositionExtern => KartenWertTesten (EbeneExtern)) /= GlobaleDatentypen.Leer
              and
                BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (Karten.Kartentemperatur) * 1.25
            then
               SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                     FlussExtern    => StandardFluss (EbeneExtern));
               return;

            else
               null;
            end if;
                     
         end loop XAchseZweiSchleife;
      end loop YAchseZweiSchleife;
      
   end FlussUmgebungTesten;



   procedure FlussBerechnung
     (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv;
      EbeneExtern : in GlobaleDatentypen.EbeneVorhanden)
   is begin
                    
      Flusswert (EbeneExtern) := 10_000;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert (EbeneExtern) := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                                                                      ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));

            if
              KartenWert (EbeneExtern).XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              XÄnderungSchleifenwert = -1
              and
                YÄnderungSchleifenwert = 0
            then
               if
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern)) = GlobaleDatentypen.Leer
               then
                  Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 1_000;
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links)
                                            + WelcherFlusstyp (EbeneExtern)));
                                                   
               else
                  null;
               end if;
               Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 1_000;
               
            elsif
              XÄnderungSchleifenwert = 1
              and
                YÄnderungSchleifenwert = 0
            then
               if
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern)) = GlobaleDatentypen.Leer
               then
                  Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 100;
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten)
                                            + WelcherFlusstyp (EbeneExtern)));
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben)
                                            + WelcherFlusstyp (EbeneExtern)));
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier)
                                            + WelcherFlusstyp (EbeneExtern)));
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links)
                                            + WelcherFlusstyp (EbeneExtern)));
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts)
                                            + WelcherFlusstyp (EbeneExtern)));
                     
               else
                  null;
               end if;
               Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 100;
               
            elsif
              YÄnderungSchleifenwert = -1
              and
                XÄnderungSchleifenwert = 0
            then
               if
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern)) = GlobaleDatentypen.Leer
               then
                  Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 10;
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht)
                                            + WelcherFlusstyp (EbeneExtern)));
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben)
                                            + WelcherFlusstyp (EbeneExtern)));
               
               else
                  null;
               end if;
               Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 10;
               
            elsif
              YÄnderungSchleifenwert = 1
              and
                XÄnderungSchleifenwert = 0
            then
               if
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern)) = GlobaleDatentypen.Leer
               then
                  Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 1;
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts)
                                            + WelcherFlusstyp (EbeneExtern)));
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht)
                                            + WelcherFlusstyp (EbeneExtern)));
               
               elsif
                 LeseKarten.Fluss (PositionExtern => KartenWert (EbeneExtern))
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern))
               then
                  SchreibeKarten.Fluss (PositionExtern => KartenWert (EbeneExtern),
                                        FlussExtern    =>
                                          GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten)
                                            + WelcherFlusstyp (EbeneExtern)));
                  
               end if;
               Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 1;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      case
        Flusswert (EbeneExtern)
      is
         when 11_111 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 11_110 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 11_101 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten)
                                    + WelcherFlusstyp (EbeneExtern)));
            
         when 11_100 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht)
                                    + WelcherFlusstyp (EbeneExtern)));
            
         when 11_011 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 11_010 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 11_001 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links)
                                    + WelcherFlusstyp (EbeneExtern)));
            
         when 11_000 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_111 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_110 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_101 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_100 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_010 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_011 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_001 =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben)
                                    + WelcherFlusstyp (EbeneExtern)));
         
         when others =>
            SchreibeKarten.Fluss (PositionExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern    =>
                                     GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln)
                                    + WelcherFlusstyp (EbeneExtern)));
      end case;
      
   end FlussBerechnung;

end KartenGeneratorFluss;
