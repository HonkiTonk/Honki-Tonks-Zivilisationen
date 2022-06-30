pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package GrenzpruefungenAllgemein is
   
   generic type Zahl is range <>;
      Zahlenwert : in Zahl;
      
   function Grenzprüfung
     (AktuellerWertExtern : in Zahlenwert;
      ÄnderungExtern : in Zahlenwert)
      return Zahlenwert;
   
   generic type ZahlNullwert is range <>;
      
   function GrenzprüfungNullwert
     (AktuellerWertExtern : in ZahlNullwert;
      ÄnderungExtern : in ZahlNullwert)
      return ZahlNullwert
     with
       Post => (
                  GrenzprüfungNullwert'Result >= 0
               );

end GrenzpruefungenAllgemein;
