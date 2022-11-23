with SystemRecords;
with TextKonstanten;

-- Hier auch noch Prozeduren/Funktionen für den Zugriff erstellen. äöü
package OptionenVariablen is

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     Sprache           => TextKonstanten.LeerUnboundedString,
                                                                     AnzahlAutosave    => 10,
                                                                     RundenBisAutosave => 10
                                                                    );

end OptionenVariablen;
