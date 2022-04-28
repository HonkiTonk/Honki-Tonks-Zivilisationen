pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with ZufallsgeneratorenKarten;
with KartengeneratorVariablen;

package body KartengeneratorFluss is
   
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
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseKarten.Grund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Kartengrund_Oberfläche_Eiswasser_Enum'Range | KartengrundDatentypen.Kartengrund_Unterfläche_Eiswasser_Enum'Range
                  | KartengrundDatentypen.Kartengrund_Kernfläche_Flüssig_Enum'Range =>
                  null;
                  
               when others =>
                  FlussUmgebungTesten (YAchseExtern => YAchseSchleifenwert,
                                       XAchseExtern => XAchseSchleifenwert,
                                       EbeneExtern  => EbeneExtern);

                  if
                    LeseKarten.Fluss (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = KartengrundDatentypen.Leer_Fluss_Enum
                  then
                     null;
                  
                  else
                     FlussBerechnung (YAchseExtern => YAchseSchleifenwert,
                                      XAchseExtern => XAchseSchleifenwert,
                                      EbeneExtern  => EbeneExtern);
                  end if;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end FlussGenerierung;
   
   
   
   procedure FlussUmgebungTesten
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
   
      BeliebigerFlusswert (EbeneExtern) := ZufallsgeneratorenKarten.ZufälligerWert; 
                  
      if
        BeliebigerFlusswert (EbeneExtern) <= WahrscheinlichkeitFluss (EbeneExtern)
      then
         SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YAchseExtern, XAchseExtern),
                               FlussExtern       => StandardFluss (EbeneExtern));
         return;
         
      elsif
        BeliebigerFlusswert (EbeneExtern) * 1.25 > WahrscheinlichkeitFluss (EbeneExtern)
      then
         return;
         
      else
         null;
      end if;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                  
            KartenWertTesten (EbeneExtern) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EbeneExtern, YAchseExtern, XAchseExtern),
                                                                                                                     ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                                     LogikGrafikExtern => True);
            
            if
              KartenWertTesten (EbeneExtern).XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Fluss (KoordinatenExtern => KartenWertTesten (EbeneExtern)) /= KartengrundDatentypen.Leer_Fluss_Enum
            then
               SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YAchseExtern, XAchseExtern),
                                     FlussExtern       => StandardFluss (EbeneExtern));
               return;

            else
               null;
            end if;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
   end FlussUmgebungTesten;

      

   procedure FlussBerechnung
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert (EbeneExtern) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EbeneExtern, YAchseExtern, XAchseExtern),
                                                                                                               ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                               LogikGrafikExtern => True);

            if
              KartenWert (EbeneExtern).XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = -1
            then
               BerechnungLinks (EbeneExtern => EbeneExtern);
               
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 1
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

      FlussPlatzieren (YAchseExtern => YAchseExtern,
                       XAchseExtern => XAchseExtern,
                       EbeneExtern  => EbeneExtern);
      
   end FlussBerechnung;
   
   
   
   procedure BerechnungLinks
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      WelcherFluss (EbeneExtern) := LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern));
      
      case
        WelcherFluss (EbeneExtern)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            FlussLinks (EbeneExtern) := False;
            
         when others =>
            FlussLinks (EbeneExtern) := True;
            WelcherFluss (EbeneExtern) := KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Val (KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (WelcherFluss (EbeneExtern)) - Flusstyp (EbeneExtern));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                                  FlussExtern       => KartengrundDatentypen.Karten_Fluss_Enum'Val (FlüsseLinks (WelcherFluss (EbeneExtern)) + Flusstyp (EbeneExtern)));
      end case;
            
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      WelcherFluss (EbeneExtern) := LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern));
      
      case
        WelcherFluss (EbeneExtern)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            FlussRechts (EbeneExtern) := False;
            
         when others =>
            FlussRechts (EbeneExtern) := True;
            WelcherFluss (EbeneExtern) := KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Val (KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (WelcherFluss (EbeneExtern)) - Flusstyp (EbeneExtern));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                                  FlussExtern       => KartengrundDatentypen.Karten_Fluss_Enum'Val (FlüsseRechts (WelcherFluss (EbeneExtern)) + Flusstyp (EbeneExtern)));
      end case;
      
   end BerechnungRechts;
   
   
   
   procedure BerechnungOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      WelcherFluss (EbeneExtern) := LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern));
      
      case
        WelcherFluss (EbeneExtern)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            FlussOben (EbeneExtern) := False;
            
         when others =>
            FlussOben (EbeneExtern) := True;
            WelcherFluss (EbeneExtern) := KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Val (KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (WelcherFluss (EbeneExtern)) - Flusstyp (EbeneExtern));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                                  FlussExtern       => KartengrundDatentypen.Karten_Fluss_Enum'Val (FlüsseOben (WelcherFluss (EbeneExtern)) + Flusstyp (EbeneExtern)));
      end case;
            
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      WelcherFluss (EbeneExtern) := LeseKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern));
      
      case
        WelcherFluss (EbeneExtern)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            FlussUnten (EbeneExtern) := False;
            
         when others =>
            FlussUnten (EbeneExtern) := True;
            WelcherFluss (EbeneExtern) := KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Val (KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (WelcherFluss (EbeneExtern)) - Flusstyp (EbeneExtern));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (EbeneExtern),
                                  FlussExtern       => KartengrundDatentypen.Karten_Fluss_Enum'Val (FlüsseUnten (WelcherFluss (EbeneExtern)) + Flusstyp (EbeneExtern)));
      end case;
      
   end BerechnungUnten;
   
   
   
   procedure FlussPlatzieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SchreibeKarten.Fluss (KoordinatenExtern => (EbeneExtern, YAchseExtern, XAchseExtern),
                            FlussExtern       => KartengrundDatentypen.Karten_Fluss_Enum'Val
                              (Flusswert (FlussLinks (EbeneExtern), FlussRechts (EbeneExtern), FlussOben (EbeneExtern), FlussUnten (EbeneExtern)) + Flusstyp (EbeneExtern)));
      
   end FlussPlatzieren;

end KartengeneratorFluss;
