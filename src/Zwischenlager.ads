with KartenKonstanten;
with StadtKonstanten;

with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;
with StadtSuchenLogik;
with EinheitSuchenLogik;

with Diagnoseinformationen;

package body EinheitenbewegungsbereichLogik is

   procedure BewegungsbereichBerechnen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin

      VorhandeneBewegungspunkte := Positive (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Bewegungsbereich := (others => (others => (others => False)));

      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;

            else
               if
                 YAchseSchleifenwert <= 0
               then
                  QuadrantEinsVier (BewegungsfeldExtern             => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                    KoordinatenExtern               => AktuelleKoordinaten,
                                    EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                    NotwendigeBewegungspunkteExtern => 0,
                                    VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);

               else
                  null;
               end if;

               if
                 YAchseSchleifenwert >= 0
               then
                  QuadrantZweiDrei (BewegungsfeldExtern             => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                    KoordinatenExtern               => AktuelleKoordinaten,
                                    EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                    NotwendigeBewegungspunkteExtern => 0,
                                    VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);

               else
                  null;
               end if;
            end if;

         end loop XAchseSchleife;

         Diagnoseinformationen.Zahl (ZahlExtern => 1);

      end loop YAchseSchleife;

   end BewegungsbereichBerechnen;



   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
   begin

      if
        NeueKoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse
      then
         return False;

      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          NeueKoordinatenExtern    => NeueKoordinatenExtern)
      then
         return False;

      elsif
        StadtKonstanten.LeerRasse /= StadtSuchenLogik.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                                KoordinatenExtern => NeueKoordinatenExtern).Rasse
      then
         return False;

      elsif
        EinheitenKonstanten.LeerRasse /= EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeueKoordinatenExtern,
                                                                                               LogikGrafikExtern => True).Rasse
      then
         return False;

      elsif
        VorhandeneBewegungspunkteExtern < NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                                                                                                               EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         return False;

      else
         return True;
      end if;

   end FeldPrüfen;



   procedure QuadrantEinsVier
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin

      KartenwertQuadrantEinsVier := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                       BewegungsfeldExtern.YAchse,
                                                                                                                                       BewegungsfeldExtern.XAchse),
                                                                                                                LogikGrafikExtern => True);

      case
        FeldPrüfen (NeueKoordinatenExtern           => KartenwertQuadrantEinsVier,
                     EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                     NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern,
                     VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern)
      is
         when False =>
            return;

         when True =>
            ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => KartenwertQuadrantEinsVier,
                                                                                                              EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            Bewegungsbereich (KartenwertQuadrantEinsVier.EAchse, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse) := True;
      end case;

      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. 0 loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;

            elsif
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;

            elsif
              BewegungsfeldExtern.XAchse < 0
              and
                XAchseSchleifenwert > 0
            then
               null;

            elsif
              BewegungsfeldExtern.XAchse > 0
              and
                XAchseSchleifenwert < 0
            then
               null;

            else
               QuadrantEinsVier (BewegungsfeldExtern             => (KartenwertQuadrantEinsVier.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                 KoordinatenExtern               => KoordinatenExtern,
                                 EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                 NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                                 VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;

   end QuadrantEinsVier;



   procedure QuadrantZweiDrei
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin

      KartenwertQuadrantZweiDrei := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                       BewegungsfeldExtern.YAchse,
                                                                                                                                       BewegungsfeldExtern.XAchse),
                                                                                                                LogikGrafikExtern => True);

      case
        FeldPrüfen (NeueKoordinatenExtern           => KartenwertQuadrantZweiDrei,
                     EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                     NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern,
                     VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern)
      is
         when False =>
            return;

         when True =>
            ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => KartenwertQuadrantZweiDrei,
                                                                                                              EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            Bewegungsbereich (KartenwertQuadrantZweiDrei.EAchse, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse) := True;
      end case;

      YAchseSchleife:
      for YAchseSchleifenwert in 0 .. KartenDatentypen.UmgebungsbereichEins'Last loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;

            elsif
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;

            elsif
              BewegungsfeldExtern.XAchse < 0
              and
                XAchseSchleifenwert > 0
            then
               null;

            elsif
              BewegungsfeldExtern.XAchse > 0
              and
                XAchseSchleifenwert < 0
            then
               null;

            else
               QuadrantZweiDrei (BewegungsfeldExtern             => (KartenwertQuadrantZweiDrei.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                 KoordinatenExtern               => KoordinatenExtern,
                                 EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                 NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                                 VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;

   end QuadrantZweiDrei;

end EinheitenbewegungsbereichLogik;
