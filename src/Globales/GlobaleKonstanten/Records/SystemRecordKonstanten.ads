with TextKonstantenHTSEB;

with SystemRecords;
with TextKonstanten;

package SystemRecordKonstanten is
   pragma Elaborate_Body;

   StandardNutzereinstellungen : constant SystemRecords.NutzerEinstellungenRecord := (
                                                                                      Sprache                   => TextKonstantenHTSEB.LeerUnboundedString,
                                                                                      Texturen                  => TextKonstanten.Standardtexturen,
                                                                                      Musik                     => TextKonstanten.Standardmusik,
                                                                                      Sound                     => TextKonstanten.Stadnardsound,
                                                                                      AnzahlAutospeichern       => 10,
                                                                                      RundenAutospeichern       => 10,
                                                                                      Dezimaltrennzeichen       => ',',
                                                                                      SicherheitsfragenAnzeigen => True
                                                                                     );

   StandardSpielendeEinstellungen : constant SystemRecords.SpielendeEinstellungenRecord := (
                                                                                            AktuellerAutospeichernwert => 1
                                                                                           );

end SystemRecordKonstanten;
