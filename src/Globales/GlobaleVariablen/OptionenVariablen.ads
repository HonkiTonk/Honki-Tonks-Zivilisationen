pragma Warnings (Off, "*array aggregate*");

with SystemRecords;
with TextKonstanten;

-- Alle Nutzereinstellungen hier reinschieben oder doch lieber thematisch trennen? äöü
package OptionenVariablen is

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     Sprache           => TextKonstanten.LeerUnboundedString,
                                                                     AnzahlAutosave    => 10,
                                                                     RundenBisAutosave => 10
                                                                    );

end OptionenVariablen;
