with SystemRecords;

package OptionenVariablen is
   pragma Elaborate_Body;

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord;

   -- Das hier vielleicht lieber in Spielende Einstellungen oder sowas umbenennen? äöü
   SonstigeEinstellungen : SystemRecords.SonstigeEinstellungenRecord;

   procedure StandardNutzereinstellungenLaden;
   procedure SonstigeStandardeinstellungenLaden;

end OptionenVariablen;
