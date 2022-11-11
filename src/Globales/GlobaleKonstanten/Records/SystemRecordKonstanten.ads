with SystemRecords;
with TextKonstanten;

package SystemRecordKonstanten is

   LeerTexteingabe : constant SystemRecords.TextEingabeRecord := (
                                                                  ErfolgreichAbbruch => False,
                                                                  EingegebenerText   => TextKonstanten.LeerUnboundedString
                                                                 );

   LeerZahleneingabe : constant SystemRecords.ZahlenEingabeRecord := (
                                                                      ErfolgreichAbbruch => False,
                                                                      EingegebeneZahl    => 0
                                                                     );

end SystemRecordKonstanten;
