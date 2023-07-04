with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with BetriebssystemKonstanten;

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
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenAllgemeinesLogik.VorzeitigesZeilenende: Aktuelle Zeile: " & AktuelleZeileExtern'Wide_Wide_Image & " "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return True;
         
   end VorzeitigesZeilenende;
   
   
   
   -- Eventuell noch mal woanders hin verschieben. äöü
   -- Die Linuxprüfung und die Aufteilung auch noch in eigene Dateien schieben? äöü
   function NamensprüfungWindows
     (NameExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      PrüfenSchleife:
      for PrüfenSchleifenwert in NameExtern'Range loop
         
         case
           NameExtern (PrüfenSchleifenwert)
         is
            when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | BetriebssystemKonstanten.Leerzeichen | BetriebssystemKonstanten.Bindestrich | BetriebssystemKonstanten.Unterstrich | BetriebssystemKonstanten.Punkt =>
               null;
               
            when others =>
               return False;
         end case;
         
      end loop PrüfenSchleife;
      
      return True;
      
   end NamensprüfungWindows;



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
         
         -- Mit BetriebssystemKonstanten verschmelzen? äöü
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
