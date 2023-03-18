with KartengrundDatentypen;
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
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern))
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitLandmasse.Anfangswert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                             GrundExtern       => KartengrundDatentypen.Wasser_Enum);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitLandmasse.Endwert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                             GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
            else
               LandmasseAbstandGenerieren (YAchseExtern => YAchseExtern,
                                           XAchseExtern => XAchseExtern);
            end if;
            
         when others =>
            null;
      end case;
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern))
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            ÄußererGrund (YAchseExtern => YAchseExtern,
                            XAchseExtern => XAchseExtern);
            
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
         
         if
           Landmassen (LandmassenSchleifenwert) >= KartenDatentypen.KartenfeldPositiv'Last / 3
         then
            Landabstand (LandmassenSchleifenwert) := KartenDatentypen.KartenfeldPositiv'Last;
            
         else
            Landabstand (LandmassenSchleifenwert) := 3 * Landmassen (LandmassenSchleifenwert);
         end if;

      end loop LandmassenSchleife;
      
      YAchseZwischenwert := StartYAchse (YAchseExtern => YAchseExtern,
                                         AnfangExtern => Landmassen (1),
                                         EndeExtern   => Landmassen (2));
      
      XAchseZwischenwert := StartXAchse (XAchseExtern => XAchseExtern,
                                         AnfangExtern => Landmassen (3),
                                         EndeExtern   => Landmassen (4));
      
      
      -- Hier noch einen Würfelwurf einbauen und dementsprechend die Wahrscheinlichkeiten für mehrere Quadranten festlegen lassen? äöü
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Landabstand (1) .. Landabstand (2) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Landabstand (3) .. Landabstand (4) loop
                           
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseZwischenwert, XAchseZwischenwert),
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KartenWert.YAchse < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse
              or
                KartenWert.XAchse < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse
            then
               null;
                  
            elsif
              KartenWert.YAchse > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse
            then
               exit YAchseSchleife;
               
            elsif
              KartenWert.XAchse > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse
            then
               exit XAchseSchleife;
               
            elsif
              YAchseSchleifenwert in -Landmassen (1) / 3 .. Landmassen (2) / 3
              and
                XAchseSchleifenwert in -Landmassen (3) / 3 .. Landmassen (4) / 3
            then
               InnererGrund (YAchseExtern => KartenWert.YAchse,
                             XAchseExtern => KartenWert.XAchse);
               
            elsif
              YAchseSchleifenwert in -Landmassen (1) * 2 / 3 .. Landmassen (2) * 2 / 3
              and
                XAchseSchleifenwert in -Landmassen (3) * 2 / 3 .. Landmassen (4) * 2 / 3
            then
               MittlererGrund (YAchseExtern => KartenWert.YAchse,
                               XAchseExtern => KartenWert.XAchse);
                  
            elsif
              YAchseSchleifenwert in -Landmassen (1) .. Landmassen (2)
              and
                XAchseSchleifenwert in -Landmassen (3) .. Landmassen (4)
            then
               ÄußererGrund (YAchseExtern => KartenWert.YAchse,
                             XAchseExtern => KartenWert.XAchse);
               
            else
               WasserGrund (YAchseExtern => KartenWert.YAchse,
                            XAchseExtern => KartenWert.XAchse);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end LandmasseAbstandGenerieren;
   
   
   
   -- Später erweitern und verbessern. äöü
   function StartYAchse
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      AnfangExtern : in KartenDatentypen.KartenfeldPositiv;
      EndeExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      ÜbergangNorden := LeseWeltkarteneinstellungen.YAchseNorden;
      ÜbergangSüden := LeseWeltkarteneinstellungen.YAchseSüden;
      
      if
        ÜbergangNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          ÜbergangSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
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
        ÜbergangNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           YAchseExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        ÜbergangSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
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
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      ÜbergangWesten := LeseWeltkarteneinstellungen.XAchseWesten;
      ÜbergangOsten := LeseWeltkarteneinstellungen.XAchseOsten;
      
      if
        ÜbergangWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
        and
          ÜbergangOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
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
        ÜbergangWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           XAchseExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        ÜbergangOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
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
   
   
   
   procedure InnererGrund
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
                         
      if
        ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte in WahrscheinlichkeitInnereLandmasse.Anfangswert .. WahrscheinlichkeitInnereLandmasse.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Wasser_Enum);
      end if;
      
   end InnererGrund;
   
   
   
   procedure MittlererGrund
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
                         
      if
        ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte in WahrscheinlichkeitMittlereLandmasse.Anfangswert .. WahrscheinlichkeitMittlereLandmasse.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Wasser_Enum);
      end if;
      
   end MittlererGrund;
   
   
   
   procedure ÄußererGrund
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type SystemDatentypen.NullBisHundert;
   begin
      
      BeliebigerLandwert := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
      
      if
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern)) = KartengrundDatentypen.Wasser_Enum
      then
         if
           BeliebigerLandwert in WahrscheinlichkeitÄußereLandmasse.Anfangswert .. 3 * (WahrscheinlichkeitÄußereLandmasse.Endwert / 4)
         then
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                          GrundExtern       => KartengrundDatentypen.Flachland_Enum);
                  
         else
            null;
         end if;
                   
      elsif
        BeliebigerLandwert in WahrscheinlichkeitÄußereLandmasse.Anfangswert .. WahrscheinlichkeitÄußereLandmasse.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Wasser_Enum);
      end if;
      
   end ÄußererGrund;
   
   
   
   procedure WasserGrund
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      if
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern)) /= KartengrundDatentypen.Leer_Basisgrund_Enum
      then
         null;
               
      elsif
        ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte in WahrscheinlichkeitWasser.Anfangswert .. WahrscheinlichkeitWasser.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Wasser_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Flachland_Enum);
      end if;
      
   end WasserGrund;

end KartengeneratorStandardLogik;
