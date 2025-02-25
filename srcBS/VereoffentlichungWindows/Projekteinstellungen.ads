with BetriebssystemDatentypenHTSEB;

with SystemRecords;

package Projekteinstellungen is
   pragma Preelaborate;

   Einstellungen : constant SystemRecords.ProjekteinstellungenRecord := (
                                                                         VolleInformation => False,
                                                                         FehlerWarnung    => False,
                                                                         Betriebssystem   => BetriebssystemDatentypenHTSEB.Windows_Enum,
                                                                         Stringkodierung  => BetriebssystemDatentypenHTSEB.UTF8_Enum,

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
