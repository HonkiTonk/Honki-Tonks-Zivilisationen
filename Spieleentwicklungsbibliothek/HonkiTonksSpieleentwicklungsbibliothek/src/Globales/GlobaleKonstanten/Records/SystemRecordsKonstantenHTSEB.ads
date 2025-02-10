with SystemRecordsHTSEB;
with TextKonstantenHTSEB;

package SystemRecordsKonstantenHTSEB is
   pragma Elaborate_Body;

   LeerTexteingabe : constant SystemRecordsHTSEB.TextEingabeRecord := (
                                                                       ErfolgreichAbbruch => False,
                                                                       EingegebenerText   => TextKonstantenHTSEB.LeerUnboundedString
                                                                      );

   LeerZahleneingabe : constant SystemRecordsHTSEB.ZahlenEingabeRecord := (
                                                                           ErfolgreichAbbruch => False,
                                                                           EingegebeneZahl    => 0
                                                                          );

end SystemRecordsKonstantenHTSEB;
