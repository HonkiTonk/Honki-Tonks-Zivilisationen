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
with KartengeneratorBasisberechnungenLogik;

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
               MeerSchreiben (SenkrechteExtern  => SenkrechteExtern,
                              WaagerechteExtern => WaagerechteExtern);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitLandmasse.Endwert
            then
               LandSchreiben (SenkrechteExtern  => SenkrechteExtern,
                              WaagerechteExtern => WaagerechteExtern);
               
            else
               LandmasseAbstandGenerieren (SenkrechteExtern => SenkrechteExtern,
                                           WaagerechteExtern => WaagerechteExtern);
            end if;
            
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
      
      SenkrechteZwischenwert := KartengeneratorBasisberechnungenLogik.StartSenkrechte (SenkrechteExtern => SenkrechteExtern,
                                                                                       AnfangExtern     => Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte,
                                                                                       EndeExtern       => Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte);
      
      WaagerechteZwischenwert := KartengeneratorBasisberechnungenLogik.StartWaagerechte (WaagerechteExtern => WaagerechteExtern,
                                                                                         AnfangExtern      => Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte,
                                                                                         EndeExtern        => Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte);
      
      -- Die "/ 3" und "* 2 / 3" geben den Landmassenbereich des jeweiligen Quadranten an.
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
   
   
   
   procedure Landgrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
   is begin
      
      SchleifenbereichZusatz := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      if
        SenkrechteExtern not in SchleifenbereichZusatz.MinimaleSenkrechte .. SchleifenbereichZusatz.MaximaleSenkrechte
        or
          WaagerechteExtern not in SchleifenbereichZusatz.MinimaleWaagerechte .. SchleifenbereichZusatz.MaximaleWaagerechte
      then
         null;
      
      elsif
        ZufallsgeneratorenHTSEB.Hunderterbereich in WahrscheinlichkeitLand.Anfangswert .. WahrscheinlichkeitLand.Endwert
      then
         LandSchreiben (SenkrechteExtern  => SenkrechteExtern,
                        WaagerechteExtern => WaagerechteExtern);
               
      else
         MeerSchreiben (SenkrechteExtern  => SenkrechteExtern,
                        WaagerechteExtern => WaagerechteExtern);
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
         MeerSchreiben (SenkrechteExtern  => SenkrechteExtern,
                        WaagerechteExtern => WaagerechteExtern);
               
      else
         LandSchreiben (SenkrechteExtern  => SenkrechteExtern,
                        WaagerechteExtern => WaagerechteExtern);
      end if;
      
   end Wassergrund;
   
   
   
   procedure MeerSchreiben
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                    GrundExtern       => KartenbasisgrundDatentypen.Meer_Enum);
      
      if
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Meeresgrund_Enum);
            
      else
         null;
      end if;
      
   end MeerSchreiben;
   
   
   
   procedure LandSchreiben
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                    GrundExtern       => KartenbasisgrundDatentypen.Grasland_Enum);
      
      if
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Erde_Enum);
            
      else
         null;
      end if;
      
   end LandSchreiben;

end KartengeneratorStandardLogik;
