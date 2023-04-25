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



   -- Später eventuell noch um weitere Prüfungen erweitern? äöü
   -- Eventuell eine bestimmte Menge an Dateien die vorhanden sein müssen mit übergeben und die dann durchgehen? äöü
   -- Funktioniert nicht unter Windows, wenn man Sonderzeichen verwendet.
   function LeeresVerzeichnis
     (VerzeichnisExtern : in String)
      return Boolean
   is begin
            
      Start_Search (Search    => Prüfungssuche,
                    Directory => VerzeichnisExtern,
                    Pattern   => "",
                    Filter    => (others => True));
      
      PrüfenSchleife:
      while More_Entries (Search => Prüfungssuche) = True loop

         Get_Next_Entry (Search          => Prüfungssuche,
                         Directory_Entry => Verzeichnisprüfung);
         
         if
           Simple_Name (Directory_Entry => Verzeichnisprüfung) = "."
           or
             Simple_Name (Directory_Entry => Verzeichnisprüfung) = ".."
         then
            null;
            
         elsif
           Exists (Name => VerzeichnisExtern & "/0")
         then
            return False;
            
         else
            null;
         end if;
            
      end loop PrüfenSchleife;
         
      return True;
      
   end LeeresVerzeichnis;
   
end EinlesenAllgemeinesLogik;
