with SystemRecords;
with BetriebssystemDatentypen;

package Projekteinstellungen is
   pragma Preelaborate;

   Einstellungen : constant SystemRecords.ProjekteinstellungenRecord := (
                                                                         VolleInformation => True,
                                                                         FehlerWarnung    => True,
                                                                         Betriebssystem   => BetriebssystemDatentypen.Linux_Enum,
                                                                         Stringkodierung  => BetriebssystemDatentypen.UTF8_Enum,
                                                                         Dateiform        => "WCEM=8"
                                                                        );

end Projekteinstellungen;
