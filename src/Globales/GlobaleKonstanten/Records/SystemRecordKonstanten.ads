with TextKonstantenHTSEB;

with SystemRecords;

package SystemRecordKonstanten is
   pragma Elaborate_Body;

   StandardNutzereinstellungen : constant SystemRecords.NutzerEinstellungenRecord := (
                                                                                      Sprache                   => TextKonstantenHTSEB.LeerUnboundedString,
                                                                                      Texturen                  => TextKonstantenHTSEB.Standardordner,
                                                                                      Musik                     => TextKonstantenHTSEB.Standardordner,
                                                                                      Sound                     => TextKonstantenHTSEB.Standardordner,
                                                                                      AnzahlAutospeichern       => 10,
                                                                                      RundenAutospeichern       => 10,
                                                                                      Dezimaltrennzeichen       => ',',
                                                                                      SicherheitsfragenAnzeigen => True
                                                                                     );

   StandardSpielendeEinstellungen : constant SystemRecords.SpielendeEinstellungenRecord := (
                                                                                            AktuellerAutospeichernwert => 1
                                                                                           );

end SystemRecordKonstanten;
