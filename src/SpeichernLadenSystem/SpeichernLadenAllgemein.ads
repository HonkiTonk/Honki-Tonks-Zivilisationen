pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package SpeichernLadenAllgemein is

   SpielstandName : Unbounded_Wide_Wide_String;
   
   function SpielstandNameErmitteln
     return Boolean;

end SpeichernLadenAllgemein;
