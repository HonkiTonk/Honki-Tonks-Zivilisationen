pragma SPARK_Mode (On);

package body SchreibenEinstellungen is

   procedure SchreibenEinstellungen
   is begin
      
      Create (File => EinstellungenDatei,
              Mode => Out_File,
              Name => "Einstellungen/Einstellungen");
      
   end SchreibenEinstellungen;

end SchreibenEinstellungen;
