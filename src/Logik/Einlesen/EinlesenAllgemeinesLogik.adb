with Fehlermeldungssystem;

package body EinlesenAllgemeinesLogik is

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
      
   exception
      when End_Error =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenAllgemeinesLogik.VorzeitigesZeilenende: Zu wenig Zeilen, aktuelle Zeile: " & AktuelleZeileExtern'Wide_Wide_Image);
         return True;
      
   end VorzeitigesZeilenende;
   
end EinlesenAllgemeinesLogik;
