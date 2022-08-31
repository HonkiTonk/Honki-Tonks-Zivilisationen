pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body GrenzpruefungenAllgemein is

   -- Nachdem ich herausgefunden habe wie man verschiedene generic Zahlentypen einbaut. äöü
   function Grenzprüfung
     (AktuellerWertExtern : in Zahlenwert;
      ÄnderungExtern : in Zahlenwert)
      return Zahlenwert
   is begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= Zahlenwert'Last
      then
         return Zahlenwert'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= Zahlenwert'First
      then
         return Zahlenwert'First;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end Grenzprüfung;
   
   
   
   function GrenzprüfungNullwert
     (AktuellerWertExtern : in ZahlNullwert;
      ÄnderungExtern : in ZahlNullwert)
      return ZahlNullwert
   is begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= ZahlNullwert'Last
      then
         return ZahlNullwert'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= 0
      then
         return 0;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end GrenzprüfungNullwert;
   
   
   
   function GrenzprüfungPositive
     (AktuellerWertExtern : in ZahlPositive;
      ÄnderungExtern : in ZahlPositive)
      return ZahlPositive
   is begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= ZahlPositive'Last
      then
         return ZahlNullwert'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= 1
      then
         return 1;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end GrenzprüfungPositive;

end GrenzpruefungenAllgemein;
