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
                                                                                      Sprache             => TextKonstanten.LeerUnboundedString,
                                                                                      AnzahlAutospeichern => 10,
                                                                                      RundenAutospeichern => 10
                                                                                     );

end SystemRecordKonstanten;
