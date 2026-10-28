with ZufallsgeneratorenHTSEB;

with KartenbasisgrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;
with SystemDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with LadezeitenLogik;
with ZufallsgeneratorenKartenLogik;
with KartengeneratorBasisberechnungenLogik;
with KartenkoordinatenberechnungssystemLogik;

package body KartengeneratorPlanetenkernLogik is

   procedure Planetenkern
     (LadezeitbasisExtern : in Float)
   is begin
      
      Karteneinstellung := (LeseWeltkarteneinstellungen.Senkrechte, LeseWeltkarteneinstellungen.Waagerechte);
      
      Kernbereich := (Karteneinstellung.Senkrechte / 2 - Karteneinstellung.Senkrechte / 10,
                      Karteneinstellung.Senkrechte / 2 + Karteneinstellung.Senkrechte / 10,
                      Karteneinstellung.Waagerechte / 2 - Karteneinstellung.Waagerechte / 10,
                      Karteneinstellung.Waagerechte / 2 + Karteneinstellung.Waagerechte / 10);
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellung.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellung.Waagerechte loop
            
            if
              SenkrechteSchleifenwert in Kernbereich.MinimaleSenkrechte .. Kernbereich.MaximaleSenkrechte
              and
                WaagerechteSchleifenwert in Kernbereich.MinimaleWaagerechte .. Kernbereich.MaximaleWaagerechte
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartenbasisgrundDatentypen.Planetenkern_Enum);
               
            elsif
              SenkrechteSchleifenwert in Kernbereich.MinimaleSenkrechte - 1 .. Kernbereich.MaximaleSenkrechte + 1
              and
                WaagerechteSchleifenwert in Kernbereich.MinimaleWaagerechte - 1 .. Kernbereich.MaximaleWaagerechte + 1
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartenbasisgrundDatentypen.Lava_Enum);
               
            else
               LandVorhanden (SenkrechteExtern  => SenkrechteSchleifenwert,
                              WaagerechteExtern => WaagerechteSchleifenwert);
            end if;
                           
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
                     
   end Planetenkern;
   
   
   
   procedure LandVorhanden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern))
      is
         when KartenbasisgrundDatentypen.Leer_Basisgrund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenHTSEB.Hunderterbereich;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitFestmasse.Anfangswert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern),
                                             GrundExtern       => KartenbasisgrundDatentypen.Lava_Enum);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitFestmasse.Endwert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern),
                                             GrundExtern       => KartenbasisgrundDatentypen.Ringwoodit_Enum);
               
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
      use type KartenDatentypen.EbeneBasis;
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
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteZwischenwert, WaagerechteZwischenwert),
                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                            TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
               if
                 Quadrantenwert <= Quadranten (QuadrantenSchleifenwert)
               then
                  Landgrund (SenkrechteExtern  => KartenWert.Senkrechte,
                             WaagerechteExtern => KartenWert.Waagerechte);
                  
               else
                  Lavagrund (SenkrechteExtern  => KartenWert.Senkrechte,
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
              := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteZwischenwert, WaagerechteZwischenwert),
                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteabstandSchleifenwert, WaagerechteabstandSchleifenwert),
                                                                                TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
            if
              KartenWert.Ebene = KartenKonstanten.LeerEbene
            then
               null;
               
            elsif
              SenkrechteabstandSchleifenwert in -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Senkrechte .. Landmassen (SystemDatentypenHTSEB.Ende_Enum).Senkrechte
              and
                WaagerechteabstandSchleifenwert in -Landmassen (SystemDatentypenHTSEB.Anfang_Enum).Waagerechte .. Landmassen (SystemDatentypenHTSEB.Ende_Enum).Waagerechte
            then
               null;
               
            else
               Lavagrund (SenkrechteExtern  => KartenWert.Senkrechte,
                          WaagerechteExtern => KartenWert.Waagerechte);
            end if;
            
         end loop WaagerechteabstandSchleife;
      end loop SenkrechteabstandSchleife;
      
   end LandmasseAbstandGenerieren;
   
   
   
   procedure Landgrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      if
        SenkrechteExtern in Kernbereich.MinimaleSenkrechte - 1 .. Kernbereich.MaximaleSenkrechte + 1
        and
          WaagerechteExtern in Kernbereich.MinimaleWaagerechte - 1 .. Kernbereich.MaximaleWaagerechte + 1
      then
         null;
         
      elsif
        ZufallsgeneratorenHTSEB.Hunderterbereich in WahrscheinlichkeitLand.Anfangswert .. WahrscheinlichkeitLand.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Ringwoodit_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Lava_Enum);
      end if;
      
   end Landgrund;
   
   
   
   procedure Lavagrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      if
        SenkrechteExtern in Kernbereich.MinimaleSenkrechte - 1 .. Kernbereich.MaximaleSenkrechte + 1
        and
          WaagerechteExtern in Kernbereich.MinimaleWaagerechte - 1 .. Kernbereich.MaximaleWaagerechte + 1
      then
         null;
         
      elsif
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern)) /= KartenbasisgrundDatentypen.Leer_Basisgrund_Enum
      then
         null;
               
      elsif
        ZufallsgeneratorenHTSEB.Hunderterbereich in WahrscheinlichkeitLava.Anfangswert .. WahrscheinlichkeitLava.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Lava_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartenbasisgrundDatentypen.Ringwoodit_Enum);
      end if;
      
   end Lavagrund;

end KartengeneratorPlanetenkernLogik;
