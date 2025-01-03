with SystemRecords;
with BetriebssystemDatentypen;

package Projekteinstellungen is
   pragma Preelaborate;

   Einstellungen : constant SystemRecords.ProjekteinstellungenRecord := (
                                                                         VolleInformation => True,
                                                                         FehlerWarnung    => True,
                                                                         Betriebssystem   => BetriebssystemDatentypen.Linux_Enum,
                                                                         Stringkodierung  => BetriebssystemDatentypen.UTF8_Enum,

                                                                         -- Gültige Werte:
                                                                         -- h => Hex ESC encoding
                                                                         -- u => Upper half encoding
                                                                         -- s => Shift-JIS encoding
                                                                         -- e => EUC Encoding
                                                                         -- 8 => UTF8 encoding
                                                                         -- b => Brackets encoding
                                                                         Dateiform        => '8'
                                                                        );

end Projekteinstellungen;
