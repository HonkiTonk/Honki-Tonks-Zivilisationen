pragma SPARK_Mode (On);

with SchreibeKarten;
with LeseKarten;

with KarteKoordinatenPruefen;
with ZufallGeneratorenKarten;

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
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      YAchseEinsSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseEinsSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

            BeliebigerFlusswert (EbeneExtern) := ZufallGeneratorenKarten.ZufälligerWert;
            
            if
              LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum
              or
                LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenDatentypen.Lava
                or
                  LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenDatentypen.Planetenkern
                  or
                    LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenDatentypen.Korallen
                    or
                      LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenDatentypen.Unterwasser_Wald
            then
               null;
               
            elsif
              BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (Karten.Kartentemperatur)
            then
               SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert),
                                     FlussExtern       => StandardFluss (EbeneExtern));
               
            else
               FlussUmgebungTesten (YKoordinateExtern => YAchseSchleifenwert,
                                    XKoordinateExtern => XAchseSchleifenwert,
                                    EbeneExtern       => EbeneExtern);
            end if;

            case
              LeseKarten.Fluss (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartenKonstanten.LeerGrund =>
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
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      YAchseZweiSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseZweiSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
            KartenWertTesten (EbeneExtern) := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                                                                               ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                               LogikGrafikExtern => True);
                     
            if
              KartenWertTesten (EbeneExtern).XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Fluss (KoordinatenExtern => KartenWertTesten (EbeneExtern)) /= KartenKonstanten.LeerGrund
              and
                BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (Karten.Kartentemperatur) * 1.25
            then
               SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                     FlussExtern       => StandardFluss (EbeneExtern));
               return;

            else
               null;
            end if;
                     
         end loop XAchseZweiSchleife;
      end loop YAchseZweiSchleife;
      
   end FlussUmgebungTesten;



   procedure FlussBerechnung
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
                    
      Flusswert (EbeneExtern) := 10_000;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert (EbeneExtern) := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                                                                         ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                         LogikGrafikExtern => True);

            if
              KartenWert (EbeneExtern).XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              XÄnderungSchleifenwert = -1
              and
                YÄnderungSchleifenwert = 0
            then
               BerechnungLinks (EbeneExtern => EbeneExtern);
               
            elsif
              XÄnderungSchleifenwert = 1
              and
                YÄnderungSchleifenwert = 0
            then
               BerechnungRechts (EbeneExtern => EbeneExtern);
               
            elsif
              YÄnderungSchleifenwert = -1
              and
                XÄnderungSchleifenwert = 0
            then
               BerechnungOben (EbeneExtern => EbeneExtern);
               
            elsif
              YÄnderungSchleifenwert = 1
              and
                XÄnderungSchleifenwert = 0
            then
               BerechnungUnten (EbeneExtern => EbeneExtern);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      FlussPlatzieren (YKoordinateExtern => YKoordinateExtern,
                       XKoordinateExtern => XKoordinateExtern,
                       EbeneExtern       => EbeneExtern);
      
   end FlussBerechnung;
   
   
   
   procedure BerechnungLinks
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      if
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern)) = KartenKonstanten.LeerGrund
      then
         Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 1_000;
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.See) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern)));
                                                   
      else
         null;
      end if;
      
      Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 1_000;
      
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      if
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern)) = KartenKonstanten.LeerGrund
      then
         Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 100;
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.See) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern)));
                     
      else
         null;
      end if;
      
      Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 100;
      
   end BerechnungRechts;
   
   
   
   procedure BerechnungOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      if
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern)) = KartenKonstanten.LeerGrund
      then
         Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 10;
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.See) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern)));
               
      else
         null;
      end if;
      
      Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 10;
      
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      if
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern)) = KartenKonstanten.LeerGrund
      then
         Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 1;
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.See) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       =>
                                 KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern)));
                  
      end if;
      
      Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 1;
      
   end BerechnungUnten;
   
   
   
   procedure FlussPlatzieren
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      case
        Flusswert (EbeneExtern)
      is
         when 11_111 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Vier) + WelcherFlusstyp (EbeneExtern)));

         when 11_110 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Oben) + WelcherFlusstyp (EbeneExtern)));

         when 11_101 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Unten) + WelcherFlusstyp (EbeneExtern)));
            
         when 11_100 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Waagrecht) + WelcherFlusstyp (EbeneExtern)));
            
         when 11_011 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Links) + WelcherFlusstyp (EbeneExtern)));

         when 11_010 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Links) + WelcherFlusstyp (EbeneExtern)));

         when 11_001 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Links) + WelcherFlusstyp (EbeneExtern)));
            
         when 11_000 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Rechts) + WelcherFlusstyp (EbeneExtern)));

         when 10_111 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskreuzung_Drei_Rechts) + WelcherFlusstyp (EbeneExtern)));

         when 10_110 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Oben_Rechts) + WelcherFlusstyp (EbeneExtern)));

         when 10_101 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flusskurve_Unten_Rechts) + WelcherFlusstyp (EbeneExtern)));

         when 10_100 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Links) + WelcherFlusstyp (EbeneExtern)));

         when 10_010 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Unten) + WelcherFlusstyp (EbeneExtern)));

         when 10_011 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Fluss_Senkrecht) + WelcherFlusstyp (EbeneExtern)));

         when 10_001 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.Flussendstück_Oben) + WelcherFlusstyp (EbeneExtern)));
         
         when others =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>
                                     KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Val (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenDatentypen.See) + WelcherFlusstyp (EbeneExtern)));
      end case;
      
   end FlussPlatzieren;

end KartenGeneratorFluss;
