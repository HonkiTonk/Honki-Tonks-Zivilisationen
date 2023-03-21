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






procedure InnererGrund
  (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
   XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
  with
    Pre => (
              YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
            and
              XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
           );

procedure MittlererGrund
  (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
   XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
  with
    Pre => (
              YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
            and
              XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
           );

procedure ÄußererGrund
  (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
   XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
  with
    Pre => (
              YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
            and
              XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
           );
