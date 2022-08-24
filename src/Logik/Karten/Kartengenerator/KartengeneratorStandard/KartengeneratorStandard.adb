pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;
with LadezeitenDatentypen;

with SchreibeKarten;
with LeseKarten;

with ZufallsgeneratorenKarten;
with Kartenkoordinatenberechnungssystem;
with KartengeneratorVariablen;
with Ladezeiten;

package body KartengeneratorStandard is
   
   procedure OberflächeGenerieren
   is begin
      
      Multiplikator := 1;
            
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
               
            LandVorhanden (YAchseExtern => YAchseSchleifenwert,
                           XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
            
         if
           ZahlenDatentypen.EigenesPositive (YAchseSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse) / 25
         then
            Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
            Multiplikator := Multiplikator + 1;
               
         else
            null;
         end if;
         
      end loop YAchseSchleife;
      
   end OberflächeGenerieren;
   
   
   
   procedure LandVorhanden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      case
        LeseKarten.BasisGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern))
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitLandmasse.Anfangswert
            then
               SchreibeKarten.GleicherGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                             GrundExtern       => KartengrundDatentypen.Wasser_Enum);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitLandmasse.Endwert
            then
               SchreibeKarten.GleicherGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
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

      LandmassenSchleife:
      for LandmassenSchleifenwert in LandmassenArray'Range loop
         
         case
           LandmassenSchleifenwert
         is
            when 1 .. 2 =>
               LandHöheBreite := True;

            when others =>
               LandHöheBreite := False;
         end case;

         Landmassen (LandmassenSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorLandgrößen (YAchseXAchseExtern => LandHöheBreite);

      end loop LandmassenSchleife;
      
      YAchseLandErzeugenSchleife:
      for YÄnderungSchleifenwert in -Landmassen (1) .. Landmassen (2) loop
         XAchseLandErzeugenSchleife:
         for XÄnderungSchleifenwert in -Landmassen (3) .. Landmassen (4) loop
            
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

      LandabstandSchleife:
      for LandabstandSchleifenwert in LandmassenArray'Range loop
         
         case
           LandabstandSchleifenwert
         is
            when 1 .. 2 =>
               LandHöheBreite := True;

            when others =>
               LandHöheBreite := False;
         end case;

         Landabstand (LandabstandSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorAbstände (YAchseXAchseExtern => LandHöheBreite);

      end loop LandabstandSchleife;
      
      YAchseAbstandFlächenSchleife:
      for YÄnderungSchleifenwert in -Landabstand (1) .. Landabstand (2) loop
         XAchseAbstandFlächenSchleife:
         for XÄnderungSchleifenwert in -Landabstand (3) .. Landabstand (4) loop
            
            -- Später die Abstandsschleifen anpassen damit diese Prüfung raus kann und nur noch der tatsächliche Abstand geloopt wird und nicht auch die Landmasse. äöü
            if
              YÄnderungSchleifenwert in -Landmassen (1) .. Landmassen (2)
              and
                XÄnderungSchleifenwert in -Landmassen (3) .. Landmassen (4)
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
      
      BeliebigerLandwert := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
      
      case
        MasseAbstandExtern
      is
         when True =>
            if
              BeliebigerLandwert in WahrscheinlichkeitLandInLandmasse.Anfangswert .. WahrscheinlichkeitLandInLandmasse.Endwert
            then
               SchreibeKarten.GleicherGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                             GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
            else
               SchreibeKarten.GleicherGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                             GrundExtern       => KartengrundDatentypen.Wasser_Enum);
            end if;
            
         when False =>
            if
              BeliebigerLandwert in WahrscheinlichkeitWasser.Anfangswert .. WahrscheinlichkeitWasser.Endwert
            then
               SchreibeKarten.GleicherGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                             GrundExtern       => KartengrundDatentypen.Wasser_Enum);
               
            else
               SchreibeKarten.GleicherGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                             GrundExtern       => KartengrundDatentypen.Flachland_Enum);
            end if;
      end case;
      
   end GrundSchreiben;

end KartengeneratorStandard;
