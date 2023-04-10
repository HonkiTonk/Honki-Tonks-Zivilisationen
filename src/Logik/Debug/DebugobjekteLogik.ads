with ForschungenDatentypen;
with EinheitenDatentypen;
with KampfDatentypen;
with EinheitenRecords;
with EinheitendatenbankRecord;
with SystemRecords;
with KartenRecordKonstanten;

package DebugobjekteLogik is
   pragma Elaborate_Body;
   use type ForschungenDatentypen.ForschungIDNichtMöglich;

   Debug : SystemRecords.DebugRecord := (others => False);

   Alleskönner : constant EinheitendatenbankRecord.EinheitenlisteRecord := (
                                                                             Einheitenart            => EinheitenDatentypen.Cheat_Enum,
                                                                             PreisGeld               => 1,
                                                                             Produktionskosten       => 1,
                                                                             PermanenteKosten        => (others => 0),
                                                                             Anforderungen           => -1,
                                                                             Passierbarkeit          => (others => True),
                                                                             MaximaleLebenspunkte    => EinheitenDatentypen.VorhandeneLebenspunkte'Last,
                                                                             MaximaleBewegungspunkte => EinheitenDatentypen.VorhandeneBewegungspunkte'Last,
                                                                             VerbesserungZu          => 0,
                                                                             Beförderungsgrenze      => 1,
                                                                             MaximalerRang           => KampfDatentypen.RangVorhanden'Last,
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
