procedure AnzeigeEinheit
  (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
   EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
   PositionExtern : in Sf.System.Vector2.sfVector2f)
is begin

   EinheitRasseNummer := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                               LogikGrafikExtern => False);

   case
     EinheitRasseNummer.Nummer
   is
      when EinheitenKonstanten.LeerNummer =>
         return;

      when others =>
         null;
   end case;

   if
     EinheitRasseNummer.Rasse = EinheitRasseNummerExtern.Rasse
     and
       (EinheitRasseNummer.Nummer = EinheitRasseNummerExtern.Nummer
        or
          True = EinheitSuchenLogik.TransporterladungSuchen (TransporterExtern   => EinheitRasseNummer,
                                                             LadungsnummerExtern => EinheitRasseNummerExtern.Nummer))
   then
      if
        Clock - StartzeitBlinkintervall > ZeitKonstanten.Blinkintervall
      then
         AusgewählteEinheitAnzeigen := not AusgewählteEinheitAnzeigen;
         StartzeitBlinkintervall := Clock;

      else
         null;
      end if;

      case
        AusgewählteEinheitAnzeigen
      is
         when True =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when False =>
            return;
      end case;

   else
      EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
   end if;

   case
     EinheitID
   is
      when EinheitenKonstanten.LeerID =>
         return;

      when others =>
         KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitRasseNummerExtern.Rasse, EinheitID),
                                                         PositionExtern         => PositionExtern,
                                                         DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
   end case;

end AnzeigeEinheit;
