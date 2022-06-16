pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Eingabe;

package body SpeichernLadenAllgemein is

   function SpielstandNameErmitteln
     return SystemRecords.TextEingabeRecord
   is begin
     
      SpielstandName := Eingabe.SpielstandName;
      
      if
        To_Wide_Wide_String (Source => SpielstandName.EingegebenerText)'Last > MaximaleZeichenlängeDateisystem
      then
         SpielstandName.EingegebenerText := To_Unbounded_Wide_Wide_String (Source => To_Wide_Wide_String (Source => SpielstandName.EingegebenerText) (1 .. MaximaleZeichenlängeDateisystem));
         
      else
         null;
      end if;
      
      return SpielstandName;
      
   end SpielstandNameErmitteln;
   
   
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      if
        To_Wide_Wide_String (Source => SpielstandnameExtern) = " "
      then
         null;
         
      else
         null;
      end if;
      
      return False;
      
   end SpielstandVorhanden;

end SpeichernLadenAllgemein;
