pragma SPARK_Mode (On);

with SystemRecords;

package SpeichernLadenAllgemein is

   SpielstandName : SystemRecords.TextEingabeRecord;
   
   function SpielstandNameErmitteln
     return Boolean;

end SpeichernLadenAllgemein;
