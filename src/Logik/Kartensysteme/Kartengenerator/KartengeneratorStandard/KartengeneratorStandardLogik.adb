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
      
      Kartenzeitwert := Basiszeitwert (ZusatzwertExtern => KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte,
                                       TeilerExtern     => 25);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
               
            LandVorhanden (SenkrechteExtern => SenkrechteSchleifenwert,
                           WaagerechteExtern => WaagerechteSchleifenwert);
            
         end loop WaagerechteSchleife;
            
         case
           SenkrechteSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
               
            when others =>
               null;
         end case;
         
      end loop SenkrechteSchleife;
      
   end OberflächeGenerieren;
   
   
   
   procedure LandVorhanden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern))
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitLandmasse.Anfangswert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                             GrundExtern       => KartengrundDatentypen.Wasser_Enum);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitLandmasse.Endwert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                             GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
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
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Landgrund (SenkrechteExtern => SenkrechteExtern,
                       WaagerechteExtern => WaagerechteExtern);
            
         when others =>
            null;
      end case;
      
   end LandVorhanden;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure LandmasseAbstandGenerieren
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
   is
      use type SystemDatentypen.NullBisHundert;
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
                                         AnfangExtern => Landmassen (1).Senkrechte,
                                         EndeExtern   => Landmassen (2).Senkrechte);
      
      WaagerechteZwischenwert := StartWaagerechte (WaagerechteExtern => WaagerechteExtern,
                                         AnfangExtern => Landmassen (1).Waagerechte,
                                         EndeExtern   => Landmassen (2).Waagerechte);
      
      QuadrantenSchleife:
      for QuadrantenSchleifenwert in QuadrantenArray'Range loop
      
         Quadrantenwert := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         case
           QuadrantenSchleifenwert
         is
            when 1 | 6 | 11 | 16 | 21 =>
               SenkrechteAnfang := -Landmassen (1).Senkrechte;
               SenkrechteEnde := -Landmassen (1).Senkrechte * 2 / 3;
               
            when 2 | 7 | 12 | 17 | 22 =>
               SenkrechteAnfang := -Landmassen (1).Senkrechte * 2 / 3;
               SenkrechteEnde := -Landmassen (1).Senkrechte / 3;
               
            when 3 | 8 | 13 | 18 | 23 =>
               SenkrechteAnfang := -Landmassen (1).Senkrechte / 3;
               SenkrechteEnde := Landmassen (2).Senkrechte / 3;
               
            when 4 | 9 | 14 | 19 | 24 =>
               SenkrechteAnfang := Landmassen (2).Senkrechte / 3;
               SenkrechteEnde := Landmassen (2).Senkrechte * 2 / 3;
               
            when 5 | 10 | 15 | 20 | 25 =>
               SenkrechteAnfang := Landmassen (2).Senkrechte * 2 / 3;
               SenkrechteEnde := Landmassen (2).Senkrechte;
         end case;
         
         case
           QuadrantenSchleifenwert
         is
            when 1 .. 5 =>
               WaagerechteAnfang := -Landmassen (1).Waagerechte;
               WaagerechteEnde := -Landmassen (1).Waagerechte * 2 / 3;
               
            when 6 .. 10 =>
               WaagerechteAnfang := -Landmassen (1).Waagerechte * 2 / 3;
               WaagerechteEnde := -Landmassen (1).Waagerechte / 3;
               
            when 11 .. 15 =>
               WaagerechteAnfang := -Landmassen (1).Waagerechte / 3;
               WaagerechteEnde := Landmassen (2).Waagerechte / 3;
               
            when 16 .. 20 =>
               WaagerechteAnfang := Landmassen (2).Waagerechte / 3;
               WaagerechteEnde := Landmassen (2).Waagerechte * 2 / 3;
               
            when 21 .. 25 =>
               WaagerechteAnfang := Landmassen (2).Waagerechte * 2 / 3;
               WaagerechteEnde := Landmassen (2).Waagerechte;
         end case;
         
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in SenkrechteAnfang .. SenkrechteEnde loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in WaagerechteAnfang .. WaagerechteEnde loop
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteZwischenwert, WaagerechteZwischenwert),
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
      for SenkrechteabstandSchleifenwert in -Landabstand (1).Senkrechte .. Landabstand (2).Senkrechte loop
         WaagerechteabstandSchleife:
         for WaagerechteabstandSchleifenwert in -Landabstand (1).Waagerechte .. Landabstand (2).Waagerechte loop
                           
            KartenWert
              := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteZwischenwert, WaagerechteZwischenwert),
                                                                                             ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteabstandSchleifenwert, WaagerechteabstandSchleifenwert),
                                                                                             TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              SenkrechteabstandSchleifenwert in -Landmassen (1).Senkrechte .. Landmassen (2).Senkrechte
              and
                WaagerechteabstandSchleifenwert in -Landmassen (1).Waagerechte .. Landmassen (2).Waagerechte
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
      
      if
        ÜbergangNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
        and
          ÜbergangSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte
         then
            return AnfangExtern;
         
         elsif
           SenkrechteExtern + EndeExtern > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        ÜbergangNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        ÜbergangSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern + EndeExtern > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte
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
      
      if
        ÜbergangWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
        and
          ÜbergangOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte
         then
            return AnfangExtern;
         
         elsif
           WaagerechteExtern + EndeExtern > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte
         then
            return EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        ÜbergangWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern - AnfangExtern < KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte
         then
            return AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        ÜbergangOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern + EndeExtern > KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte
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
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      -- Wird die erste Abfrag überhaupt benötigt wenn ich darunter prüfe ob es im gültigen Kartenbereich ist? äöü
      if
        WaagerechteExtern = KartenKonstanten.LeerWaagerechte
      then
         null;
               
      elsif
        SenkrechteExtern not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte
        or
          WaagerechteExtern not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte
      then
         null;
      
      elsif
        ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte in WahrscheinlichkeitLand.Anfangswert .. WahrscheinlichkeitLand.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartengrundDatentypen.Flachland_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartengrundDatentypen.Wasser_Enum);
      end if;
      
   end Landgrund;
   
   
   
   procedure Wassergrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      if
        WaagerechteExtern = KartenKonstanten.LeerWaagerechte
      then
         null;
               
      elsif
        SenkrechteExtern not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte
        or
          WaagerechteExtern not in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte
      then
         null;
         
      elsif
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern)) /= KartengrundDatentypen.Leer_Basisgrund_Enum
      then
         null;
               
      elsif
        ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte in WahrscheinlichkeitWasser.Anfangswert .. WahrscheinlichkeitWasser.Endwert
      then
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartengrundDatentypen.Wasser_Enum);
               
      else
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                       GrundExtern       => KartengrundDatentypen.Flachland_Enum);
      end if;
      
   end Wassergrund;

end KartengeneratorStandardLogik;
