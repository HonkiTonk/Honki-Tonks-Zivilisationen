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
            return;
      end case;
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern))
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Landgrund (YAchseExtern => YAchseExtern,
                       XAchseExtern => XAchseExtern);
            
         when others =>
            null;
      end case;
      
   end LandVorhanden;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure LandmasseAbstandGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
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
      
      QuadrantenSchleife:
      for QuadrantenSchleifenwert in QuadrantenArray'Range loop
      
         Quadrantenwert := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         case
           QuadrantenSchleifenwert
         is
            when 1 | 6 | 11 | 16 | 21 =>
               YAchseAnfang := -Landmassen (1);
               YAchseEnde := -Landmassen (1) * 2 / 3;
               
            when 2 | 7 | 12 | 17 | 22 =>
               YAchseAnfang := -Landmassen (1) * 2 / 3;
               YAchseEnde := -Landmassen (1) / 3;
               
            when 3 | 8 | 13 | 18 | 23 =>
               YAchseAnfang := -Landmassen (1) / 3;
               YAchseEnde := Landmassen (2) / 3;
               
            when 4 | 9 | 14 | 19 | 24 =>
               YAchseAnfang := Landmassen (2) / 3;
               YAchseEnde := Landmassen (2) * 2 / 3;
               
            when 5 | 10 | 15 | 20 | 25 =>
               YAchseAnfang := Landmassen (2) * 2 / 3;
               YAchseEnde := Landmassen (2);
         end case;
         
         case
           QuadrantenSchleifenwert
         is
            when 1 .. 5 =>
               XAchseAnfang := -Landmassen (3);
               XAchseEnde := -Landmassen (3) * 2 / 3;
               
            when 6 .. 10 =>
               XAchseAnfang := -Landmassen (3) * 2 / 3;
               XAchseEnde := -Landmassen (3) / 3;
               
            when 11 .. 15 =>
               XAchseAnfang := -Landmassen (3) / 3;
               XAchseEnde := Landmassen (4) / 3;
               
            when 16 .. 20 =>
               XAchseAnfang := Landmassen (4) / 3;
               XAchseEnde := Landmassen (4) * 2 / 3;
               
            when 21 .. 25 =>
               XAchseAnfang := Landmassen (4) * 2 / 3;
               XAchseEnde := Landmassen (4);
         end case;
         
         YAchseSchleife:
         for YAchseSchleifenwert in YAchseAnfang .. YAchseEnde loop
            XAchseSchleife:
            for XAchseSchleifenwert in XAchseAnfang .. XAchseEnde loop
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseZwischenwert, XAchseZwischenwert),
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
            
               -- Hier zusätzlich noch zum Quadrantengebiet (Zentrum, Mitte, Rand) jeweils eine eigene Landerzeugunswahrscheinlichkeit hinzufügen? äöü
               if
                 Quadrantenwert <= Quadranten (QuadrantenSchleifenwert)
               then
                  Landgrund (YAchseExtern => KartenWert.YAchse,
                             XAchseExtern => KartenWert.XAchse);
                  
               else
                  Wassergrund (YAchseExtern => KartenWert.YAchse,
                               XAchseExtern => KartenWert.XAchse);
               end if;
                  
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop QuadrantenSchleife;
      
      YAchsenabstandSchleife:
      for YAchsenabstandSchleifenwert in -Landabstand (1) .. Landabstand (2) loop
         XAchsenabstandSchleife:
         for XAchsenabstandSchleifenwert in -Landabstand (3) .. Landabstand (4) loop
                           
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseZwischenwert, XAchseZwischenwert),
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchsenabstandSchleifenwert, XAchsenabstandSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              YAchsenabstandSchleifenwert in -Landmassen (1) .. Landmassen (2)
              and
                XAchsenabstandSchleifenwert in -Landmassen (3) .. Landmassen (4)
            then
               null;
               
            else
               Wassergrund (YAchseExtern => KartenWert.YAchse,
                            XAchseExtern => KartenWert.XAchse);
            end if;
            
         end loop XAchsenabstandSchleife;
      end loop YAchsenabstandSchleife;
      
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
   
   
   
   procedure Landgrund
     (YAchseExtern : in KartenDatentypen.KartenfeldNatural;
      XAchseExtern : in KartenDatentypen.KartenfeldNatural)
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      -- Wird die erste Abfrag überhaupt benötigt wenn ich darunter prüfe ob es im gültigen Kartenbereich ist? äöü
      if
        XAchseExtern = KartenKonstanten.LeerXAchse
      then
         null;
               
      elsif
        YAchseExtern not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse
        or
          XAchseExtern not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse
      then
         null;
      
      elsif
        ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte in WahrscheinlichkeitLand.Anfangswert .. WahrscheinlichkeitLand.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseExtern, XAchseExtern),
                                       GrundExtern       => KartengrundDatentypen.Wasser_Enum);
      end if;
      
   end Landgrund;
   
   
   
   procedure Wassergrund
     (YAchseExtern : in KartenDatentypen.KartenfeldNatural;
      XAchseExtern : in KartenDatentypen.KartenfeldNatural)
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      if
        XAchseExtern = KartenKonstanten.LeerXAchse
      then
         null;
               
      elsif
        YAchseExtern not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse
        or
          XAchseExtern not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse
      then
         null;
         
      elsif
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
      
   end Wassergrund;

end KartengeneratorStandardLogik;
