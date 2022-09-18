pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Warnung;

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
            -- Das Setzen der aktuellen Zeile herausziehen? Ist immerhin 'in' und wäre dann konsequenter. äöü
            Set_Line (File => AktuelleDateiExtern,
                      To   => Ada.Wide_Wide_Text_IO.Count (AktuelleZeileExtern));
            return False;
      end case;
      
      -- Geht das auch ohne exception? äöü
   exception
      when End_Error =>
         Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenAllgemein.VorzeitigesZeilenende: Zu wenig Zeilen.");
         return True;
      
   end VorzeitigesZeilenende;
   
end EinlesenAllgemeinesLogik;
