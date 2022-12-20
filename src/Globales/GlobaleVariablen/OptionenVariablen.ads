with SystemRecords;
with TextKonstanten;

-- Hier auch noch Prozeduren/Funktionen für den Zugriff erstellen. äöü
package OptionenVariablen is
   pragma Elaborate_Body;

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     Sprache           => TextKonstanten.LeerUnboundedString,
                                                                     AnzahlAutosave    => 10,
                                                                     RundenBisAutosave => 10
                                                                    );

end OptionenVariablen;
