package SystemDatentypen is
   pragma Pure;
      
   type Ende_Enum is (
                      Leer_Enum,
                      
                      Gewonnen_Enum, Verloren_Enum
                     );
   
   
   
   type Task_Enum is (
                      Logik_Task_Enum,
                      Grafik_Task_Enum
                     );
   
end SystemDatentypen;
