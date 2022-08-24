pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecords;

package SpeichernLadenAllgemein is

   function SpielstandNameErmitteln
     return SystemRecords.TextEingabeRecord;
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return Boolean;
   
private
   
   SpielstandName : SystemRecords.TextEingabeRecord;

end SpeichernLadenAllgemein;
