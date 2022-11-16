with SystemRecords;
with TextKonstanten;

-- Alle Nutzereinstellungen hier reinschieben oder doch lieber thematisch trennen? äöü
-- Hier auch noch Prozeduren/Funktionen für den Zugriff erstellen? äöü
package OptionenVariablen is

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     Sprache           => TextKonstanten.LeerUnboundedString,
                                                                     AnzahlAutosave    => 10,
                                                                     RundenBisAutosave => 10
                                                                    );

end OptionenVariablen;
