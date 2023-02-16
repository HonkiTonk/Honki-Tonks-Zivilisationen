with SystemRecords;

-- Das hier später woanders mit einbauen? Vielleicht Spielvariablen? äöü
package OptionenVariablen is
   pragma Elaborate_Body;

   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord;

   procedure StandardeinstellungenLaden;

end OptionenVariablen;
