pragma SPARK_Mode (On);

with Eingabe;

package body SchreibenTastatur is

   procedure TastenbelegungSchreiben
   is begin
      
      Create (File => TastenbelegungSpeichern,
              Mode => Out_File,
              Name => "Einstellungen/Tastenbelegung");
      
      Open (File => TastenbelegungSpeichern,
            Mode => In_File,
            Name => "Einstellungen/Tastenbelegung");
      
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in Eingabe.TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in Eingabe.TastenbelegungArray'Range (2) loop
            
            Wide_Wide_Character'Write (Stream (File => TastenbelegungSpeichern),
                                       Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert));
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastatur;
