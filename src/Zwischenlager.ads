with KartenKonstanten;

with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;

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

            Rekursiv (BewegungsfeldExtern             => (AktuelleKoordinaten.EAchse, YAchseSchleifenwert, XAchseSchleifenwert),
                      KoordinatenExtern               => AktuelleKoordinaten,
                      EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                      NotwendigeBewegungspunkteExtern => 0,
                      VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);

         end loop XAchseSchleife;
      end loop YAchseSchleife;

   end BewegungsbereichBerechnen;



   procedure Rekursiv
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin

      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            if
              BewegungsfeldExtern.YAchse < 0
              and
                YAchseSchleifenwert > 0
            then
               null;

            elsif
              BewegungsfeldExtern.YAchse > 0
              and
                YAchseSchleifenwert < 0
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

            elsif
              BewegungsfeldExtern.YAchse = 0
              and
                BewegungsfeldExtern.XAchse = 0
            then
               return;

            else
               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);

               if
                 Kartenwert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;

               elsif
                 False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeueKoordinatenExtern    => Kartenwert)
               then
                  null;

               elsif
                 VorhandeneBewegungspunkteExtern < NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                                                                        EinheitRasseNummerExtern => EinheitRasseNummerExtern))
               then
                  null;

               else
                  Bewegungsbereich (Kartenwert.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert) := True;

                  if
                    BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
                    or
                      BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
                  then
                     null;

                  else
                     Rekursiv (BewegungsfeldExtern             => (BewegungsfeldExtern.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                               KoordinatenExtern               => Kartenwert,
                               EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                               NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                                                                                       EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                               VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
                  end if;
               end if;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;

   end Rekursiv;

end EinheitenbewegungsbereichLogik;

