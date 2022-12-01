function AllgemeineEinheitenbewegungMaus
  (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
is
   use type KartenRecords.AchsenKartenfeldNaturalRecord;
begin

   EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

   EAchseSchleife:
   for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                      ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);

            -- In diesem Fall wird die Prüfung auf Leer nicht benötigt, da im aktuellen System die Cursorkoordinaten niemals ungültig sein können.
            if
              KartenWert = LeseCursor.KoordinatenAktuell (RasseExtern => EinheitRasseNummerExtern.Rasse)
            then
               return EinheitenbewegungLogik.PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              ÄnderungExtern           => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));

            else
               null;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
   end loop EAchseSchleife;

   return True;

end AllgemeineEinheitenbewegungMaus;
