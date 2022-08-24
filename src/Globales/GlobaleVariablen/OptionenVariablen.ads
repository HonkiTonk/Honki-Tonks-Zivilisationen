pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemRecords;
with TextKonstanten;

package OptionenVariablen is

   -- type OptionenVariablenArray is array (1 .. 3) of Unbounded_Wide_Wide_String;
   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     Sprache           => TextKonstanten.LeerUnboundedString,
                                                                     AnzahlAutosave    => 10,
                                                                     RundenBisAutosave => 10
                                                                    );
   
   -- Die weiteren Einstellungen auch in den NutzerEinstellungenRecord einbauen.

end OptionenVariablen;
