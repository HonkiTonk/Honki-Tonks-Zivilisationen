with EinheitendatenbankRecord;

private with ForschungenDatentypen;
private with EinheitenDatentypen;
private with KampfDatentypen;
private with EinheitenRecords;
private with KartenRecordKonstanten;

package DebugobjekteLogik is
   pragma Elaborate_Body;

   function AlleskönnerEintrag
     return EinheitendatenbankRecord.EinheitenlisteRecord;

private
   use type ForschungenDatentypen.ForschungIDUnmöglich;

   Alleskönner : constant EinheitendatenbankRecord.EinheitenlisteRecord := (
                                                                             Einheitenart            => EinheitenDatentypen.Cheat_Enum,
                                                                             PreisGeld               => 1,
                                                                             Produktionskosten       => 1,
                                                                             PermanenteKosten        => (others => 0),
                                                                             Anforderungen           => -1,
                                                                             NotwendigeGebäude       => (others => False),
                                                                             Passierbarkeit          => (others => True),
                                                                             MaximaleLebenspunkte    => KampfDatentypen.LebenspunkteVorhanden'Last,
                                                                             MaximaleBewegungspunkte => EinheitenDatentypen.BewegungspunkteVorhanden'Last,
                                                                             VerbesserungZu          => 0,
                                                                             Beförderungsgrenze      => 1,
                                                                             MaximalerRang           => KampfDatentypen.Rang'Last,
                                                                             Reichweite              => KampfDatentypen.ReichweiteVorhanden'Last,
                                                                             Angriff                 => KampfDatentypen.KampfwerteEinheiten'Last,
                                                                             Verteidigung            => KampfDatentypen.KampfwerteEinheiten'Last,
                                                                             KannTransportieren      => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                             KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                             Transportkapazität      => EinheitenRecords.TransporterArray'Last,
                                                                             Zusatzeffekt            => (others => False),
                                                                             Effektreichweite        => (others => KartenRecordKonstanten.LeerEffektbereich)
                                                                            );

end DebugobjekteLogik;
