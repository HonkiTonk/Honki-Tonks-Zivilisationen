pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with ZufallsgeneratorenKarten;
with KartengeneratorVariablen;

package body KartenGeneratorFluss is
   
   procedure AufteilungFlussgenerierung
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            return;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            GenerierungFlüsse;
      end case;
      
   end AufteilungFlussgenerierung;
   
   

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
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseEinsSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop

            BeliebigerFlusswert (EbeneExtern) := ZufallsgeneratorenKarten.ZufälligerWert;
            
            -----------------------
            if
              LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenGrundDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum
              or
                LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenGrundDatentypen.Lava_Enum
                or
                  LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenGrundDatentypen.Planetenkern_Enum
                  or
                    LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenGrundDatentypen.Korallen_Enum
                    or
                      LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenGrundDatentypen.Unterwald_Enum
            then
               null;
               
            elsif
              BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (Karten.Kartenparameter.Kartentemperatur)
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
               when KartenGrundDatentypen.Leer_Fluss_Enum =>
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
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseZweiSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                  
            KartenWertTesten (EbeneExtern) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                                                                                                     ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                                     LogikGrafikExtern => True);
                     
            if
              KartenWertTesten (EbeneExtern).XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Fluss (KoordinatenExtern => KartenWertTesten (EbeneExtern)) /= KartenGrundDatentypen.Leer_Fluss_Enum
              and
                BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (Karten.Kartenparameter.Kartentemperatur) * 1.25
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
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert (EbeneExtern) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
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
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern)) = KartenGrundDatentypen.Leer_Fluss_Enum
      then
         Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 1_000;
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Senkrecht_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Rechts_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Links_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Unten_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Links_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Oben_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Links_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Rechts_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Waagrecht_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Unten_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Rechts_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Oben_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Rechts_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.See_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Links_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                                                   
      else
         null;
      end if;
      
      Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 1_000;
      
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      if
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern)) = KartenGrundDatentypen.Leer_Fluss_Enum
      then
         Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 100;
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Senkrecht_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Links_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Rechts_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Unten_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Rechts_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Oben_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Rechts_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Links_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Waagrecht_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Unten_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Links_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Oben_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Links_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.See_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Rechts_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                     
      else
         null;
      end if;
      
      Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 100;
      
   end BerechnungRechts;
   
   
   
   procedure BerechnungOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      if
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern)) = KartenGrundDatentypen.Leer_Fluss_Enum
      then
         Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 10;
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Waagrecht_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Unten_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Rechts_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Rechts_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Links_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Links_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Oben_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Links_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Rechts_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Rechts_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Links_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Unten_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Senkrecht_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.See_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Oben_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
               
      else
         null;
      end if;
      
      Flusswert (EbeneExtern) := Flusswert (EbeneExtern) + 10;
      
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      if
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern)) = KartenGrundDatentypen.Leer_Fluss_Enum
      then
         Flusswert (EbeneExtern) := Flusswert (EbeneExtern) - 1;
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Waagrecht_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Oben_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Rechts_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Rechts_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Links_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Links_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Unten_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Links_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Rechts_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Rechts_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Links_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Oben_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Senkrecht_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
               
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern))
          = KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.See_Enum) + WelcherFlusstyp (EbeneExtern))
      then
         SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                               FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Unten_Enum)
                                 + WelcherFlusstyp (EbeneExtern)));
                  
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
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 11_110 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Oben_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 11_101 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Unten_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));
            
         when 11_100 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Waagrecht_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));
            
         when 11_011 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Links_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 11_010 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Links_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 11_001 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Links_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));
            
         when 11_000 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Rechts_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_111 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Drei_Rechts_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_110 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Oben_Rechts_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_101 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flusskurve_Unten_Rechts_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_100 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Links_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_010 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Unten_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_011 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Fluss_Senkrecht_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));

         when 10_001 =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       => KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.Flussendstück_Oben_Enum)
                                    + WelcherFlusstyp (EbeneExtern)));
         
         when others =>
            SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YKoordinateExtern, XKoordinateExtern),
                                  FlussExtern       =>  KartenGrundDatentypen.Karten_Fluss_Enum'Val (KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenGrundDatentypen.See_Enum) + WelcherFlusstyp (EbeneExtern)));
      end case;
      
   end FlussPlatzieren;

end KartenGeneratorFluss;
