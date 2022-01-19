pragma SPARK_Mode (On);

package body DatenbankenEditoren is

   function DatenbankenEditoren
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      EditorenSchleife:
      loop
         
         return SystemDatentypen.Start_Weiter;
         
      end loop EditorenSchleife;
      
   end DatenbankenEditoren;

end DatenbankenEditoren;
