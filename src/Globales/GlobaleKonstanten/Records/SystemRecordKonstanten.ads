with SystemRecords;
with TextKonstanten;

package SystemRecordKonstanten is
   pragma Elaborate_Body;

   LeerTexteingabe : constant SystemRecords.TextEingabeRecord := (
                                                                  ErfolgreichAbbruch => False,
                                                                  EingegebenerText   => TextKonstanten.LeerUnboundedString
                                                                 );

   LeerZahleneingabe : constant SystemRecords.ZahlenEingabeRecord := (
                                                                      ErfolgreichAbbruch => False,
                                                                      EingegebeneZahl    => 0
                                                                     );

   StandardNutzereinstellungen : constant SystemRecords.NutzerEinstellungenRecord := (
                                                                                      Sprache                   => TextKonstanten.LeerUnboundedString,
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
