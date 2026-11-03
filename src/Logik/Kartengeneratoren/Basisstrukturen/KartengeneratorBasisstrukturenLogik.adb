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

package body KartengeneratorBasisstrukturenLogik is
   
   procedure Basisstrukturen
     (LadezeitbasisExtern : in Float;
      EbeneExtern : in KartenDatentypen.EbeneUnterflächeOberfläche)
   is begin
      
      Schleifenbereich := KartengeneratorVariablenLogik.PolfreierBereichLesen;
            
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in Schleifenbereich.MinimaleSenkrechte .. Schleifenbereich.MaximaleSenkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in Schleifenbereich.MinimaleWaagerechte .. Schleifenbereich.MaximaleWaagerechte loop
               
            LandVorhanden (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Basisstrukturen_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end Basisstrukturen;
   
   
   
   procedure LandVorhanden
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenbasisgrundDatentypen.Leer_Basisgrund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenHTSEB.Hunderterbereich;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitLandmasse.Anfangswert
            then
               MeerSchreiben (KoordinatenExtern => KoordinatenExtern);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitLandmasse.Endwert
            then
               LandSchreiben (KoordinatenExtern => KoordinatenExtern);
               
            else
               LandmasseAbstandGenerieren (KoordinatenExtern => KoordinatenExtern);
            end if;
            
         when others =>
            null;
      end case;
      
   end LandVorhanden;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure LandmasseAbstandGenerieren
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
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
      
      SenkrechteZwischenwert := KartengeneratorBasisberechnungenLogik.StartSenkrechte (SenkrechteExtern => KoordinatenExtern.Senkrechte,
                                                                                       AnfangExtern     => Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte,
                                                                                       EndeExtern       => Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte);
      
      WaagerechteZwischenwert := KartengeneratorBasisberechnungenLogik.StartWaagerechte (WaagerechteExtern => KoordinatenExtern.Waagerechte,
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
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KoordinatenExtern.Ebene, SenkrechteZwischenwert, WaagerechteZwischenwert),
                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                            TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
               if
                 Quadrantenwert <= Quadranten (QuadrantenSchleifenwert)
               then
                  Landgrund (KoordinatenExtern => KartenWert);
                  
               else
                  Wassergrund (KoordinatenExtern => KartenWert);
               end if;
                  
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop QuadrantenSchleife;
      
      SenkrechteabstandSchleife:
      for SenkrechteabstandSchleifenwert in -Landabstand (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte .. Landabstand (SystemDatentypenHTSEB.Ende_Enum).Senkrechte loop
         WaagerechteabstandSchleife:
         for WaagerechteabstandSchleifenwert in -Landabstand (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte .. Landabstand (SystemDatentypenHTSEB.Ende_Enum).Waagerechte loop
                           
            KartenWert
              := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KoordinatenExtern.Ebene, SenkrechteZwischenwert, WaagerechteZwischenwert),
                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteabstandSchleifenwert, WaagerechteabstandSchleifenwert),
                                                                                TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              SenkrechteabstandSchleifenwert in -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte .. Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte
              and
                WaagerechteabstandSchleifenwert in -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte .. Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte
            then
               null;
               
            else
               Wassergrund (KoordinatenExtern => KartenWert);
            end if;
            
         end loop WaagerechteabstandSchleife;
      end loop SenkrechteabstandSchleife;
      
   end LandmasseAbstandGenerieren;
   
   
   
   procedure Landgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      SchleifenbereichZusatz := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      if
        KoordinatenExtern.Senkrechte not in SchleifenbereichZusatz.MinimaleSenkrechte .. SchleifenbereichZusatz.MaximaleSenkrechte
        or
          KoordinatenExtern.Waagerechte not in SchleifenbereichZusatz.MinimaleWaagerechte .. SchleifenbereichZusatz.MaximaleWaagerechte
      then
         null;
      
      elsif
        ZufallsgeneratorenHTSEB.Hunderterbereich in WahrscheinlichkeitLand.Anfangswert .. WahrscheinlichkeitLand.Endwert
      then
         LandSchreiben (KoordinatenExtern => KoordinatenExtern);
               
      else
         MeerSchreiben (KoordinatenExtern => KoordinatenExtern);
      end if;
      
   end Landgrund;
   
   
   
   procedure Wassergrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      SchleifenbereichZusatz := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      if
        KoordinatenExtern.Senkrechte not in SchleifenbereichZusatz.MinimaleSenkrechte .. SchleifenbereichZusatz.MaximaleSenkrechte
        or
          KoordinatenExtern.Waagerechte not in SchleifenbereichZusatz.MinimaleWaagerechte .. SchleifenbereichZusatz.MaximaleWaagerechte
      then
         null;
         
      elsif
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern) /= KartenbasisgrundDatentypen.Leer_Basisgrund_Enum
      then
         null;
               
      elsif
        ZufallsgeneratorenHTSEB.Hunderterbereich in WahrscheinlichkeitWasser.Anfangswert .. WahrscheinlichkeitWasser.Endwert
      then
         MeerSchreiben (KoordinatenExtern => KoordinatenExtern);
               
      else
         LandSchreiben (KoordinatenExtern => KoordinatenExtern);
      end if;
      
   end Wassergrund;
   
   
   
   procedure MeerSchreiben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.OberflächeKonstante =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => KartenbasisgrundDatentypen.Meer_Enum);
      
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                             GrundExtern       => KartenbasisgrundDatentypen.Meeresgrund_Enum);
            
            else
               null;
            end if;
            
         when others =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => KartenbasisgrundDatentypen.Meeresgrund_Enum);
      end case;
      
   end MeerSchreiben;
   
   
   
   procedure LandSchreiben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.OberflächeKonstante =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => KartenbasisgrundDatentypen.Grasland_Enum);
      
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                             GrundExtern       => KartenbasisgrundDatentypen.Erde_Enum);
            
            else
               null;
            end if;
            
         when others =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => KartenbasisgrundDatentypen.Erde_Enum);
      end case;
      
   end LandSchreiben;

end KartengeneratorBasisstrukturenLogik;
