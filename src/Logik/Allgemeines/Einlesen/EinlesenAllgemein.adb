pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body EinlesenAllgemein is

   function VorzeitigesZeilenende
     (AktuelleDateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive)
      return Boolean
   is begin
      
      case
        End_Of_File (File => AktuelleDateiExtern)
      is
         when True =>
            return True;
               
         when False =>
            Set_Line (File => AktuelleDateiExtern,
                      To   => Ada.Wide_Wide_Text_IO.Count (AktuelleZeileExtern));
            return False;
      end case;
      
   end VorzeitigesZeilenende;

end EinlesenAllgemein;
