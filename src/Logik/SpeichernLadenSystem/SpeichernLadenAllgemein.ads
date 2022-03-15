pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemRecords;

package SpeichernLadenAllgemein is

   SpielstandName : SystemRecords.TextEingabeRecord;
   
   function SpielstandNameErmitteln
     return Boolean;

end SpeichernLadenAllgemein;
