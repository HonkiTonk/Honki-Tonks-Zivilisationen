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
with LadezeitenLogik;

package body KartengeneratorStandard is
   
   procedure OberflächeGenerieren
   is begin
      
      Kartenzeitwert := (KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse + (25 - 1)) / 25;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
               
            LandVorhanden (YAchseExtern => YAchseSchleifenwert,
                           XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
               
            when others =>
               null;
         end case;
         
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
               LandmasseAbstandGenerieren (YAchseExtern => YAchseExtern,
                                           XAchseExtern => XAchseExtern);
            end if;
            
         when others =>
            null;
      end case;
      
      case
        LeseKarten.BasisGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern))
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
            GrundSchreiben (YAchseExtern       => YAchseExtern,
                            XAchseExtern       => XAchseExtern,
                            MasseAbstandExtern => True);
            
         when others =>
            null;
      end case;
      
   end LandVorhanden;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   -- Später auf die jeweiligen Kartenübergänge rücksicht nehmen. äöü
   procedure LandmasseAbstandGenerieren
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
         Landabstand (LandmassenSchleifenwert) := 3 * Landmassen (LandmassenSchleifenwert);

      end loop LandmassenSchleife;
      
      YAchseZwischenwert := StartYAchse (YAchseExtern => YAchseExtern,
                                         AnfangExtern => Landmassen (1),
                                         EndeExtern   => Landmassen (2));
      
      XAchseZwischenwert := StartXAchse (XAchseExtern => XAchseExtern,
                                         AnfangExtern => Landmassen (3),
                                         EndeExtern   => Landmassen (4));
      
      YAchseAbstandFlächenSchleife:
      for YÄnderungSchleifenwert in -Landabstand (1) .. Landabstand (2) loop
         XAchseAbstandFlächenSchleife:
         for XÄnderungSchleifenwert in -Landabstand (3) .. Landabstand (4) loop
                           
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (0, YAchseZwischenwert, XAchseZwischenwert),
                                                                                                 ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KartenWert.YAchse not in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse
              or
                KartenWert.XAchse not in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse
            then
               null;
                  
            elsif
              YÄnderungSchleifenwert in -Landmassen (1) .. Landmassen (2)
              and
                XÄnderungSchleifenwert in -Landmassen (3) .. Landmassen (4)
            then
               GrundSchreiben (YAchseExtern       => KartenWert.YAchse,
                               XAchseExtern       => KartenWert.XAchse,
                               MasseAbstandExtern => True);
               
            else
               GrundSchreiben (YAchseExtern       => KartenWert.YAchse,
                               XAchseExtern       => KartenWert.XAchse,
                               MasseAbstandExtern => False);
            end if;
            
         end loop XAchseAbstandFlächenSchleife;
      end loop YAchseAbstandFlächenSchleife;
      
   end LandmasseAbstandGenerieren;
   
   
   
   function StartYAchse
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      AnfangExtern : in KartenDatentypen.KartenfeldPositiv;
      EndeExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        Karten.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          Karten.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           YAchseExtern - AnfangExtern < KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse
         then
            return AnfangExtern;
         
         elsif
           YAchseExtern + EndeExtern > KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        Karten.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           YAchseExtern - AnfangExtern < KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        Karten.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           YAchseExtern + EndeExtern > KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      else
         null;
      end if;
      
      return YAchseExtern;
      
   end StartYAchse;
   
   
   
   function StartXAchse
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      AnfangExtern : in KartenDatentypen.KartenfeldPositiv;
      EndeExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        Karten.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
        and
          Karten.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           XAchseExtern - AnfangExtern < KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse
         then
            return AnfangExtern;
         
         elsif
           XAchseExtern + EndeExtern > KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        Karten.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           XAchseExtern - AnfangExtern < KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        Karten.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           XAchseExtern + EndeExtern > KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      else
         null;
      end if;
      
      return XAchseExtern;
      
   end StartXAchse;
   
   
   
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
              LeseKarten.BasisGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern)) = KartengrundDatentypen.Wasser_Enum
            then
               if
                 BeliebigerLandwert in WahrscheinlichkeitLandInLandmasse.Anfangswert .. WahrscheinlichkeitLandInLandmasse.Endwert / 2
               then
                  SchreibeKarten.GleicherGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                GrundExtern       => KartengrundDatentypen.Flachland_Enum);
                  
               else
                  null;
               end if;
                   
            elsif
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
              LeseKarten.BasisGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern)) /= KartengrundDatentypen.Leer_Grund_Enum
            then
               null;
               
            elsif
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
