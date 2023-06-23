with SystemRecords;

package OptionenVariablen is
   pragma Elaborate_Body;

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord;

   SpielendeEinstellungen : SystemRecords.SpielendeEinstellungenRecord;

   procedure StandardNutzereinstellungenLaden;
   procedure SpielendeStandardeinstellungenLaden;

end OptionenVariablen;
