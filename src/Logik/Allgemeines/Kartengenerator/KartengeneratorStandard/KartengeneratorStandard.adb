pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with ZufallsgeneratorenKarten;
with Kartenkoordinatenberechnungssystem;
with KartengeneratorVariablen;

package body KartengeneratorStandard is
   
   procedure OberflächeGenerieren
   is begin
            
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
               
            LandVorhanden (YAchseExtern => YAchseSchleifenwert,
                           XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end OberflächeGenerieren;
   
   
   
   procedure LandVorhanden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      case
        LeseKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern))
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenKarten.ZufälligerWert;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitLandmasse.Anfangswert
            then
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern       => KartengrundDatentypen.Wasser_Enum);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitLandmasse.Endwert
            then
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
            else
               LandmasseGenerieren (YAchseExtern => YAchseExtern,
                                    XAchseExtern => XAchseExtern);
               AbstandGenerieren (YAchseExtern => YAchseExtern,
                                  XAchseExtern => XAchseExtern);
            end if;
            
         when others =>
            null;
      end case;
      
   end LandVorhanden;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure LandmasseGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseLandErzeugenSchleife:
      for YÄnderungSchleifenwert in -Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart).YAchse .. Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart).YAchse loop
         XAchseLandErzeugenSchleife:
         for XÄnderungSchleifenwert in -Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart).XAchse .. Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart).XAchse loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                                                 ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KartenWert.YAchse in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse
              and
                KartenWert.XAchse in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse
            then
               GrundSchreiben (YAchseExtern       => KartenWert.YAchse,
                               XAchseExtern       => KartenWert.XAchse,
                               MasseAbstandExtern => True);
               
            else
               null;
            end if;
            
         end loop XAchseLandErzeugenSchleife;
      end loop YAchseLandErzeugenSchleife;
      
   end LandmasseGenerieren;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure AbstandGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseAbstandFlächenSchleife:
      for YÄnderungSchleifenwert in -Karten.AbstandLandflächen (Karten.Kartenparameter.Kartenart).YAchse .. Karten.AbstandLandflächen (Karten.Kartenparameter.Kartenart).YAchse loop
         XAchseAbstandFlächenSchleife:
         for XÄnderungSchleifenwert in -Karten.AbstandLandflächen (Karten.Kartenparameter.Kartenart).XAchse .. Karten.AbstandLandflächen (Karten.Kartenparameter.Kartenart).XAchse loop
            
            ----------------------- Später die Abstandsschleifen anpassen damit diese Prüfung raus kann und nur noch der tatsächliche Abstand geloopt wird und nicht auch die Landmasse.
            if
              YÄnderungSchleifenwert in -Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart).YAchse .. Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart).YAchse
              and
                XÄnderungSchleifenwert in -Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart).XAchse .. Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart).XAchse
            then
               null;
               
            else
               KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                                                    ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                    LogikGrafikExtern => True);
            
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
               
               elsif
                 KartenWert.YAchse in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse
                 and
                   KartenWert.XAchse in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse
               then
                  GrundSchreiben (YAchseExtern       => KartenWert.YAchse,
                                  XAchseExtern       => KartenWert.XAchse,
                                  MasseAbstandExtern => False);
                  
               else
                  null;
               end if;
            end if;
            
         end loop XAchseAbstandFlächenSchleife;
      end loop YAchseAbstandFlächenSchleife;
      
   end AbstandGenerieren;
   
   
   
   procedure GrundSchreiben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      MasseAbstandExtern : in Boolean)
   is begin
      
      BeliebigerLandwert := ZufallsgeneratorenKarten.ZufälligerWert;
      
      case
        MasseAbstandExtern
      is
         when True =>
            if
              BeliebigerLandwert in WahrscheinlichkeitLandInLandmasse.Anfangswert .. WahrscheinlichkeitLandInLandmasse.Endwert
            then
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
            else
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern       => KartengrundDatentypen.Wasser_Enum);
            end if;
            
         when False =>
            if
              BeliebigerLandwert in WahrscheinlichkeitWasser.Anfangswert .. WahrscheinlichkeitWasser.Endwert
            then
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern       => KartengrundDatentypen.Wasser_Enum);
               
            else
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern       => KartengrundDatentypen.Flachland_Enum);
            end if;
      end case;
         
   end GrundSchreiben;

end KartengeneratorStandard;
