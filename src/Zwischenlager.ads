function Ladung
  (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
   IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
is
   use type EinheitenDatentypen.Einheitenbereich;
begin

   case
     LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                IDExtern      => IDExtern)
   is
      when EinheitenKonstanten.LeerKannTransportieren =>
         return TextKonstanten.LeerUnboundedString;

      when others =>
         Beladen := False;
         Ladungstext := Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleLadung);
   end case;

   LadungSchleife:
   for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                     IDExtern    => IDExtern) loop

      Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                          PlatzExtern                => LadungSchleifenwert);

      if
        Ladungsnummer /= EinheitenKonstanten.LeerTransportiert
      then
         Beladen := True;
         Ladungstext := Ladungstext & TextKonstanten.UmbruchAbstand
           & EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Ladungsnummer)),
                                                             SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);

      else
         null;
      end if;

   end loop LadungSchleife;

   case
     Beladen
   is
      when True =>
         return Ladungstext;

      when False =>
         return TextKonstanten.LeerUnboundedString;
   end case;

end Ladung;



procedure AuswahlEinheitTransporter
  (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
is
   -- use type EinheitenDatentypen.Einheitenbereich;
begin

   Transportiert := TransporterSuchenLogik.HatTransporterLadung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);

   if
     -- LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerWirdTransportiert
     --  and
     Transportiert = False
   then
      TransporterNummer := EinheitSpeziesNummerExtern.Nummer;
      AusgewählteEinheit := AuswahlKonstanten.LeerAuswahl;

      --  elsif
      --    LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) /= EinheitenKonstanten.LeerWirdTransportiert
      --  then
      --    TransporterNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      --    AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
      --                                                                        StadtnummerExtern   => StadtDatentypen.Städtebereich'First,
      --                                                                        EinheitNummerExtern => TransporterNummer);

   else
      TransporterNummer := EinheitSpeziesNummerExtern.Nummer;
      AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
                                                                           StadtnummerExtern   => StadtDatentypen.Städtebereich'First,
                                                                           EinheitNummerExtern => TransporterNummer);
   end if;

   case
     AusgewählteEinheit
   is
      when AuswahlKonstanten.LeerAuswahl =>
         EinheitSteuern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, TransporterNummer));

      when Positive (EinheitenRecords.TransporterArray'First) .. Positive (EinheitenRecords.TransporterArray'Last) =>
         AuswahlEinheitTransporter (EinheitSpeziesNummerExtern =>
                                      (EinheitSpeziesNummerExtern.Spezies, LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, TransporterNummer),
                                                                                                              PlatzExtern                => EinheitenDatentypen.Transportplätze (AusgewählteEinheit))));
         -- EinheitSteuern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, TransporterNummer),
         --                                                                                                   PlatzExtern                => EinheitenDatentypen.Transportplätze (AusgewählteEinheit))));

      when SystemKonstanten.AbwählenNegativ =>
         null;

      when others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "BefehlspruefungenLogik.AuswahlEinheitTransporter: Fehlerhafte Auswahl:" & AusgewählteEinheit'Wide_Wide_Image);
   end case;

end AuswahlEinheitTransporter;
