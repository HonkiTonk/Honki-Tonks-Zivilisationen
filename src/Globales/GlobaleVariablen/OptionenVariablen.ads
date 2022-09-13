pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemRecords;
with TextKonstanten;

package OptionenVariablen is

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     Sprache           => TextKonstanten.LeerUnboundedString,
                                                                     AnzahlAutosave    => 10,
                                                                     RundenBisAutosave => 10
                                                                    );

end OptionenVariablen;
