pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemRecords;
with TextKonstanten;

package SystemRecordKonstanten is

   LeerTexteingabe : constant SystemRecords.TextEingabeRecord := (
                                                                  ErfolgreichAbbruch => False,
                                                                  EingegebenerText   => TextKonstanten.LeerUnboundedString
                                                                 );

end SystemRecordKonstanten;
