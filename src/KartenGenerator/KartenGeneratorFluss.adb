pragma SPARK_Mode (On);

with GlobaleKonstanten;

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
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseEinsSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            

            BeliebigerFlusswert (EbeneExtern) := ZufallGeneratorenKarten.ZufälligerWert;
            
            if
              Karten.Weltkarte (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert).Grund in GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum
              or
                Karten.Weltkarte (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert).Grund = GlobaleDatentypen.Lava
              or
                Karten.Weltkarte (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert).Grund = GlobaleDatentypen.Planetenkern
              or
                Karten.Weltkarte (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert).Grund = GlobaleDatentypen.Korallen
              or
                Karten.Weltkarte (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert).Grund = GlobaleDatentypen.Unterwasser_Wald
            then
               null;
               
            elsif
              BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (Karten.Kartentemperatur)
            then
               Karten.Weltkarte (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert).Fluss := StandardFluss (EbeneExtern);
               
            else
               FlussUmgebungTesten (YKoordinateExtern => YAchseSchleifenwert,
                                    XKoordinateExtern => XAchseSchleifenwert,
                                    EbeneExtern       => EbeneExtern);
            end if;

            case
              Karten.Weltkarte (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert).Fluss
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
              Karten.Weltkarte (KartenWertTesten (EbeneExtern).EAchse, KartenWertTesten (EbeneExtern).YAchse, KartenWertTesten (EbeneExtern).XAchse).Fluss /= GlobaleDatentypen.Leer
              and
                BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (Karten.Kartentemperatur) * 1.25
            then                        
               Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss := StandardFluss (EbeneExtern);
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
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss = GlobaleDatentypen.Leer
               then
                  Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 1_000;
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern));
                                                   
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
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss = GlobaleDatentypen.Leer
               then
                  Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 100;
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern));
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern));
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern));
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern));
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern));
                     
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
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss = GlobaleDatentypen.Leer
               then
                  Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 10;
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern));
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern));
               
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
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss = GlobaleDatentypen.Leer
               then
                  Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 1;
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern));
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern));
                  
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern));
               
               elsif
                 Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                   = GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern))
               then
                  Karten.Weltkarte (KartenWert (EbeneExtern).EAchse, KartenWert (EbeneExtern).YAchse, KartenWert (EbeneExtern).XAchse).Fluss
                    := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern));
                  
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
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern));

         when 11_110 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern));

         when 11_101 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern));
            
         when 11_100 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern));
            
         when 11_011 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern));

         when 11_010 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern));

         when 11_001 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern));
            
         when 11_000 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern));

         when 10_111 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern));

         when 10_110 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern));

         when 10_101 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern));

         when 10_100 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern));

         when 10_010 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern));

         when 10_011 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern));

         when 10_001 =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern));
         
         when others =>
            Karten.Weltkarte (EbeneExtern, YKoordinateExtern, XKoordinateExtern).Fluss
              := GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Val (GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (GlobaleDatentypen.Fluss_Einzeln) + WelcherFlusstyp (EbeneExtern));
      end case;
      
   end FlussBerechnung;

end KartenGeneratorFluss;
