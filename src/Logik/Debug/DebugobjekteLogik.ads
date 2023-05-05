with ForschungenDatentypen;
with EinheitenDatentypen;
with KampfDatentypen;
with EinheitenRecords;
with EinheitendatenbankRecord;
with SystemRecords;
with KartenRecordKonstanten;

-- In die adb Datei Lese/Schreibefunktionen einbauen und dann hier alles nach private schieben. äöü
package DebugobjekteLogik is
   pragma Elaborate_Body;
   use type ForschungenDatentypen.ForschungIDNichtMöglich;

   EntwicklungLinux : constant SystemRecords.DebugRecord := (
                                                             VolleInformation => True,
                                                             FehlerWarnung    => True,
                                                             LinuxWindows     => True
                                                            );

   EntwicklungWindows : constant SystemRecords.DebugRecord := (
                                                               VolleInformation => True,
                                                               FehlerWarnung    => True,
                                                               LinuxWindows     => False
                                                              );

   VweröffentlichungLinux : constant SystemRecords.DebugRecord := (
                                                                    VolleInformation => False,
                                                                    FehlerWarnung    => False,
                                                                    LinuxWindows     => True
                                                                   );

   VeröffentlichungWindows : constant SystemRecords.DebugRecord := (
                                                                     VolleInformation => False,
                                                                     FehlerWarnung    => False,
                                                                     LinuxWindows     => False
                                                                    );

   Debug : SystemRecords.DebugRecord := VweröffentlichungLinux;

   Alleskönner : constant EinheitendatenbankRecord.EinheitenlisteRecord := (
                                                                             Einheitenart            => EinheitenDatentypen.Cheat_Enum,
                                                                             PreisGeld               => 1,
                                                                             Produktionskosten       => 1,
                                                                             PermanenteKosten        => (others => 0),
                                                                             Anforderungen           => -1,
                                                                             NotwendigeGebäude       => (others => False),
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

private



end DebugobjekteLogik;
