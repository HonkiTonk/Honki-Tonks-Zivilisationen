pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemRecords;

package SpeichernLadenAllgemein is

   function SpielstandNameErmitteln
     return SystemRecords.TextEingabeRecord;
   
private
   
   MaximaleZeichenlängeDateisystem : constant Positive := 256;
   
   SpielstandName : SystemRecords.TextEingabeRecord;

end SpeichernLadenAllgemein;
