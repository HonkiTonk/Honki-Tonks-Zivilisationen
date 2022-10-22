pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenartDatentypen; use KartenartDatentypen;
with SystemDatentypen; use SystemDatentypen;
with KartenKonstanten;
with LadezeitenDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartenkoordinatenberechnungssystemLogik;
with KartengeneratorVariablenLogik;
with LadezeitenLogik;

package body KartengeneratorStandardLogik is
   
   procedure OberflächeGenerieren
   is begin
      
      Kartenzeitwert := (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse + (25 - 1)) / 25;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse loop
               
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
        LeseWeltkarte.BasisGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern))
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitLandmasse.Anfangswert
            then
               SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                                GrundExtern       => KartengrundDatentypen.Wasser_Enum);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitLandmasse.Endwert
            then
               SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                                GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
            else
               LandmasseAbstandGenerieren (YAchseExtern => YAchseExtern,
                                           XAchseExtern => XAchseExtern);
            end if;
            
         when others =>
            null;
      end case;
      
      case
        LeseWeltkarte.BasisGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern))
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

         Landmassen (LandmassenSchleifenwert) := ZufallsgeneratorenKartenLogik.KartengeneratorLandgrößen (YAchseXAchseExtern => LandHöheBreite);
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
                           
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseZwischenwert, XAchseZwischenwert),
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KartenWert.YAchse not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse
              or
                KartenWert.XAchse not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse
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
   
   
   
   -- Später erweitern und verbessern. äöü
   function StartYAchse
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      AnfangExtern : in KartenDatentypen.KartenfeldPositiv;
      EndeExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           YAchseExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse
         then
            return AnfangExtern;
         
         elsif
           YAchseExtern + EndeExtern > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           YAchseExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           YAchseExtern + EndeExtern > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse
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
        Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           XAchseExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse
         then
            return AnfangExtern;
         
         elsif
           XAchseExtern + EndeExtern > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           XAchseExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           XAchseExtern + EndeExtern > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse
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
      
      BeliebigerLandwert := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
      
      case
        MasseAbstandExtern
      is
         when True =>
            if
              LeseWeltkarte.BasisGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern)) = KartengrundDatentypen.Wasser_Enum
            then
               if
                 BeliebigerLandwert in WahrscheinlichkeitLandInLandmasse.Anfangswert .. 3 * ( WahrscheinlichkeitLandInLandmasse.Endwert / 4)
               then
                  SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                                   GrundExtern       => KartengrundDatentypen.Flachland_Enum);
                  
               else
                  null;
               end if;
                   
            elsif
              BeliebigerLandwert in WahrscheinlichkeitLandInLandmasse.Anfangswert .. WahrscheinlichkeitLandInLandmasse.Endwert
            then
               SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                                GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
            else
               SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                                GrundExtern       => KartengrundDatentypen.Wasser_Enum);
            end if;
            
         when False =>
            if
              LeseWeltkarte.BasisGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern)) /= KartengrundDatentypen.Leer_Grund_Enum
            then
               null;
               
            elsif
              BeliebigerLandwert in WahrscheinlichkeitWasser.Anfangswert .. WahrscheinlichkeitWasser.Endwert
            then
               SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                                GrundExtern       => KartengrundDatentypen.Wasser_Enum);
               
            else
               SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                                GrundExtern       => KartengrundDatentypen.Flachland_Enum);
            end if;
      end case;
      
   end GrundSchreiben;

end KartengeneratorStandardLogik;
