pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemRecords;
with GrafikDatentypen;
with TextKonstanten;

package OptionenVariablen is

   -- type OptionenVariablenArray is array (1 .. 3) of Unbounded_Wide_Wide_String;
   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     Sprache           => TextKonstanten.LeerUnboundedString,
                                                                     AnzahlAutosave    => 10,
                                                                     RundenBisAutosave => 10,
                                                                     Anzeigeart        => GrafikDatentypen.Grafik_SFML_Enum
                                                                    );
   
   -- Die weiteren Einstellungen auch in den NutzerEinstellungenRecord einbauen.

end OptionenVariablen;
