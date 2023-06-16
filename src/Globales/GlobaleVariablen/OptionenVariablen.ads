with SystemRecords;

-- Das hier später woanders mit einbauen? Vielleicht Spielvariablen? äöü
package OptionenVariablen is
   pragma Elaborate_Body;

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord;

   -- Das hier vielleicht lieber in Spielende Einstellugnen oder sowas umbenennen? äöü
   SonstigeEinstellungen : SystemRecords.SonstigeEinstellungenRecord;

   procedure StandardNutzereinstellungenLaden;
   procedure SonstigeStandardeinstellungenLaden;

end OptionenVariablen;
