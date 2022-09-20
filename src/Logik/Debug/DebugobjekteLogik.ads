pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitenDatentypen;
with KampfDatentypen;
with EinheitenRecords;

with DatenbankRecords;

package DebugobjekteLogik is

   Alleskönner : constant DatenbankRecords.EinheitenlisteRecord := (
                                                                     EinheitArt              => EinheitenDatentypen.Cheat_Enum,
                                                                     PreisGeld               => 1,
                                                                     PreisRessourcen         => 1,
                                                                     PermanenteKosten        => (others => 0),
                                                                     Anforderungen           => -1,
                                                                     Passierbarkeit          => (others => True),
                                                                     MaximaleLebenspunkte    => EinheitenDatentypen.Lebenspunkte'Last,
                                                                     MaximaleBewegungspunkte => EinheitenDatentypen.VorhandeneBewegungspunkte'Last,
                                                                     WirdVerbessertZu        => 0,
                                                                     Beförderungsgrenze      => 1,
                                                                     MaximalerRang           => KampfDatentypen.RangVorhanden'Last,
                                                                     Reichweite              => KampfDatentypen.Reichweite'Last,
                                                                     Angriff                 => KampfDatentypen.Kampfwerte'Last,
                                                                     Verteidigung            => KampfDatentypen.Kampfwerte'Last,
                                                                     KannTransportieren      => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                     KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                     Transportkapazität      => EinheitenRecords.TransporterArray'Last
                                                                    );

end DebugobjekteLogik;
