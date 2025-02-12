with BetriebssystemDatentypenHTSEB;

with SystemRecords;

package Projekteinstellungen is
   pragma Preelaborate;

   -- Das auch auslagern und von außen setzen lassen? äöü
   -- Auf jeden Fall die verschiedenen Versionen anpassen! äöü
   Einstellungen : constant SystemRecords.ProjekteinstellungenRecord := (
                                                                         VolleInformation => True,
                                                                         FehlerWarnung    => True,
                                                                         Betriebssystem   => BetriebssystemDatentypenHTSEB.Linux_Enum,
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
