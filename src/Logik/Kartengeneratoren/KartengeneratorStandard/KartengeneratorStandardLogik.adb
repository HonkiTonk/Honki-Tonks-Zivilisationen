with ZufallsgeneratorenHTSEB;

with KartenbasisgrundDatentypen;
with KartenKonstanten;
with LadezeitenDatentypen;
with SystemDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartenkoordinatenberechnungssystemLogik;
with KartengeneratorVariablenLogik;
with LadezeitenLogik;

with DiagnosesystemHTSEB;

package body KartengeneratorStandardLogik is
   
   procedure OberflächeGenerieren
     (LadezeitbasisExtern : in Float)
   is begin
      
      Schleifenbereich := KartengeneratorVariablenLogik.PolfreierBereichLesen;
            
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in Schleifenbereich.MinimaleSenkrechte .. Schleifenbereich.MaximaleSenkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in Schleifenbereich.MinimaleWaagerechte .. Schleifenbereich.MaximaleWaagerechte loop
               
            LandVorhanden (SenkrechteExtern => SenkrechteSchleifenwert,
                           WaagerechteExtern => WaagerechteSchleifenwert);
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end OberflächeGenerieren;
   
   
   
   procedure LandVorhanden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern))
      is
         when KartenbasisgrundDatentypen.Leer_Basisgrund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenHTSEB.Hunderterbereich;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitLandmasse.Anfangswert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                             GrundExtern       => KartenbasisgrundDatentypen.Meer_Enum);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitLandmasse.Endwert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                             GrundExtern       => KartenbasisgrundDatentypen.Grasland_Enum);
               
            else
               LandmasseAbstandGenerieren (SenkrechteExtern => SenkrechteExtern,
                                           WaagerechteExtern => WaagerechteExtern);
            end if;
            
         when others =>
            return;
      end case;
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern))
      is
         when KartenbasisgrundDatentypen.Leer_Basisgrund_Enum =>
            --      Landgrund (SenkrechteExtern => SenkrechteExtern,
            --                 WaagerechteExtern => WaagerechteExtern);
            null;
      
            DiagnosesystemHTSEB.Zählen (ZahlbestimmungExtern => True);
            
         when others =>
            null;
      end case;
      
   end LandVorhanden;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure LandmasseAbstandGenerieren
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      LandmassenSchleife:
      for LandmassenSchleifenwert in LandmassenArray'Range loop
                  
         Landmassen (LandmassenSchleifenwert) := ZufallsgeneratorenKartenLogik.KartengeneratorLandgrößen;
         
         if
           Landmassen (LandmassenSchleifenwert).Senkrechte >= KartenDatentypen.SenkrechtePositiv'Last / 3
         then
            Landabstand (LandmassenSchleifenwert).Senkrechte := KartenDatentypen.SenkrechtePositiv'Last;
            
         else
            Landabstand (LandmassenSchleifenwert).Senkrechte := 3 * Landmassen (LandmassenSchleifenwert).Senkrechte;
         end if;
         
         if
           Landmassen (LandmassenSchleifenwert).Waagerechte >= KartenDatentypen.WaagerechtePositiv'Last / 3
         then
            Landabstand (LandmassenSchleifenwert).Waagerechte := KartenDatentypen.WaagerechtePositiv'Last;
            
         else
            Landabstand (LandmassenSchleifenwert).Waagerechte := 3 * Landmassen (LandmassenSchleifenwert).Waagerechte;
         end if;

      end loop LandmassenSchleife;
      
      SenkrechteZwischenwert := StartSenkrechte (SenkrechteExtern => SenkrechteExtern,
                                                 AnfangExtern     => Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte,
                                                 EndeExtern       => Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte);
      
      WaagerechteZwischenwert := StartWaagerechte (WaagerechteExtern => WaagerechteExtern,
                                                   AnfangExtern      => Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte,
                                                   EndeExtern        => Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte);
      
      QuadrantenSchleife:
      for QuadrantenSchleifenwert in QuadrantenArray'Range loop
         
         case
           QuadrantenSchleifenwert
         is
            when 1 | 6 | 11 | 16 | 21 =>
               SenkrechteAnfang := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte;
               SenkrechteEnde := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte * 2 / 3;
               
            when 2 | 7 | 12 | 17 | 22 =>
               SenkrechteAnfang := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte * 2 / 3;
               SenkrechteEnde := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte / 3;
               
            when 3 | 8 | 13 | 18 | 23 =>
               SenkrechteAnfang := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte / 3;
               SenkrechteEnde := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte / 3;
               
            when 4 | 9 | 14 | 19 | 24 =>
               SenkrechteAnfang := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte / 3;
               SenkrechteEnde := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte * 2 / 3;
               
            when 5 | 10 | 15 | 20 | 25 =>
               SenkrechteAnfang := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte * 2 / 3;
               SenkrechteEnde := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte;
         end case;
         
         case
           QuadrantenSchleifenwert
         is
            when 1 .. 5 =>
               WaagerechteAnfang := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte;
               WaagerechteEnde := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte * 2 / 3;
               
            when 6 .. 10 =>
               WaagerechteAnfang := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte * 2 / 3;
               WaagerechteEnde := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte / 3;
               
            when 11 .. 15 =>
               WaagerechteAnfang := -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte / 3;
               WaagerechteEnde := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte / 3;
               
            when 16 .. 20 =>
               WaagerechteAnfang := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte / 3;
               WaagerechteEnde := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte * 2 / 3;
               
            when 21 .. 25 =>
               WaagerechteAnfang := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte * 2 / 3;
               WaagerechteEnde := Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte;
         end case;
      
         Quadrantenwert := ZufallsgeneratorenHTSEB.Hunderterbereich;
         
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in SenkrechteAnfang .. SenkrechteEnde loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in WaagerechteAnfang .. WaagerechteEnde loop
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteZwischenwert, WaagerechteZwischenwert),
                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                            TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
               if
                 Quadrantenwert <= Quadranten (QuadrantenSchleifenwert)
               then
                  Landgrund (SenkrechteExtern => KartenWert.Senkrechte,
                             WaagerechteExtern => KartenWert.Waagerechte);
                  
               else
                  Wassergrund (SenkrechteExtern => KartenWert.Senkrechte,
                               WaagerechteExtern => KartenWert.Waagerechte);
               end if;
                  
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop QuadrantenSchleife;
      
      SenkrechteabstandSchleife:
      for SenkrechteabstandSchleifenwert in -Landabstand (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte .. Landabstand (SystemDatentypenHTSEB.Ende_Enum).Senkrechte loop
         WaagerechteabstandSchleife:
         for WaagerechteabstandSchleifenwert in -Landabstand (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte .. Landabstand (SystemDatentypenHTSEB.Ende_Enum).Waagerechte loop
                           
            KartenWert
              := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteZwischenwert, WaagerechteZwischenwert),
                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteabstandSchleifenwert, WaagerechteabstandSchleifenwert),
                                                                                TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              SenkrechteabstandSchleifenwert in -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte .. Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte
              and
                WaagerechteabstandSchleifenwert in -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte .. Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte
            then
               null;
               
            else
               Wassergrund (SenkrechteExtern => KartenWert.Senkrechte,
                            WaagerechteExtern => KartenWert.Waagerechte);
            end if;
            
         end loop WaagerechteabstandSchleife;
      end loop SenkrechteabstandSchleife;
      
   end LandmasseAbstandGenerieren;
   
   
   
   -- Später erweitern und verbessern. äöü
   function StartSenkrechte
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      AnfangExtern : in KartenDatentypen.SenkrechtePositiv;
      EndeExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechtePositiv
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      ÜbergangNorden := LeseWeltkarteneinstellungen.SenkrechteNorden;
      ÜbergangSüden := LeseWeltkarteneinstellungen.SenkrechteSüden;
      SchleifenbereichZusatz := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      if
        ÜbergangNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
        and
          ÜbergangSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern - AnfangExtern <= SchleifenbereichZusatz.MinimaleSenkrechte
         then
            return AnfangExtern;
         
         elsif
           SenkrechteExtern + EndeExtern >= SchleifenbereichZusatz.MaximaleSenkrechte
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        ÜbergangNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern - AnfangExtern <= SchleifenbereichZusatz.MinimaleSenkrechte
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        ÜbergangSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern + EndeExtern >= SchleifenbereichZusatz.MaximaleSenkrechte
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      else
         null;
      end if;
      
      return SenkrechteExtern;
      
   end StartSenkrechte;
   
   
   
   function StartWaagerechte
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      AnfangExtern : in KartenDatentypen.WaagerechtePositiv;
      EndeExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechtePositiv
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      ÜbergangWesten := LeseWeltkarteneinstellungen.WaagerechteWesten;
      ÜbergangOsten := LeseWeltkarteneinstellungen.WaagerechteOsten;
      SchleifenbereichZusatz := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      if
        ÜbergangWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
        and
          ÜbergangOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern - AnfangExtern <= SchleifenbereichZusatz.MinimaleWaagerechte
         then
            return AnfangExtern;
         
         elsif
           WaagerechteExtern + EndeExtern >= SchleifenbereichZusatz.MaximaleWaagerechte
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        ÜbergangWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern - AnfangExtern <= SchleifenbereichZusatz.MinimaleWaagerechte
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        ÜbergangOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern + EndeExtern >= SchleifenbereichZusatz.MaximaleWaagerechte
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      else
         null;
      end if;
      
      return WaagerechteExtern;
      
   end StartWaagerechte;
   
   
   
   procedure Landgrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      SchleifenbereichZusatz := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      -- Wird die erste Abfrage überhaupt benötigt wenn ich darunter prüfe ob es im gültigen Kartenbereich ist? äöü
      if
        WaagerechteExtern = KartenKonstanten.LeerWaagerechte
      then
         null;
               
      elsif
        SenkrechteExtern not in SchleifenbereichZusatz.MinimaleSenkrechte .. SchleifenbereichZusatz.MaximaleSenkrechte
        or
          WaagerechteExtern not in SchleifenbereichZusatz.MinimaleWaagerechte .. SchleifenbereichZusatz.MaximaleWaagerechte
      then
         null;
      
      elsif
        ZufallsgeneratorenHTSEB.Hunderterbereich in WahrscheinlichkeitLand.Anfangswert .. WahrscheinlichkeitLand.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Grasland_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Meer_Enum);
      end if;
      
   end Landgrund;
   
   
   
   procedure Wassergrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      SchleifenbereichZusatz := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      if
        WaagerechteExtern = KartenKonstanten.LeerWaagerechte
      then
         null;
               
      elsif
        SenkrechteExtern not in SchleifenbereichZusatz.MinimaleSenkrechte .. SchleifenbereichZusatz.MaximaleSenkrechte
        or
          WaagerechteExtern not in SchleifenbereichZusatz.MinimaleWaagerechte .. SchleifenbereichZusatz.MaximaleWaagerechte
      then
         null;
         
      elsif
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern)) /= KartenbasisgrundDatentypen.Leer_Basisgrund_Enum
      then
         null;
               
      elsif
        ZufallsgeneratorenHTSEB.Hunderterbereich in WahrscheinlichkeitWasser.Anfangswert .. WahrscheinlichkeitWasser.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Meer_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Grasland_Enum);
      end if;
      
   end Wassergrund;

end KartengeneratorStandardLogik;
