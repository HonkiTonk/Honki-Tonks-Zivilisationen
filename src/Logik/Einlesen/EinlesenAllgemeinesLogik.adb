with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with BetriebssystemKonstanten;

with Fehlermeldungssystem;

package body EinlesenAllgemeinesLogik is

   function VorzeitigesDateienende
     (AktuelleDateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive;
      DateinameExtern : in Wide_Wide_String)
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
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenAllgemeinesLogik.VorzeitigesDateienende: " & DateinameExtern & ": Aktuelle Zeile:" & AktuelleZeileExtern'Wide_Wide_Image & " "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return True;
         
   end VorzeitigesDateienende;
   
   
   
   function TextEinlesen
     (DateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive;
      DateinameExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                    AktuelleZeileExtern => AktuelleZeileExtern,
                                                                    DateinameExtern     => DateinameExtern));
      
   end TextEinlesen;
   
   
   
   function TextEinlesenUngebunden
     (DateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive;
      DateinameExtern : in Wide_Wide_String)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        End_Of_Line (File => DateiExtern)
      is
         when True =>
            return To_Unbounded_Wide_Wide_String (Source => ("Leerzeile in " & DateinameExtern & ", Zeile:" & AktuelleZeileExtern'Wide_Wide_Image));
            
         when False =>
            return To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
      end case;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenAllgemeinesLogik.TextEinlesenUngebunden: " & DateinameExtern & ": Aktuelle Zeile:" & AktuelleZeileExtern'Wide_Wide_Image & " "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return To_Unbounded_Wide_Wide_String (Source => (DateinameExtern & ", Zeile:" & AktuelleZeileExtern'Wide_Wide_Image));
         
   end TextEinlesenUngebunden;
   
   
   
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
   
   
   
   function Texturenlimit
     (TexturenpfadExtern : in String)
      return Sf.Graphics.sfTexture_Ptr
   is
      use type Sf.sfUint32;
   begin
            
      Texturengröße := Sf.Graphics.Texture.getSize (texture => Sf.Graphics.Texture.createFromFile (filename => TexturenpfadExtern));
               
      if
        Texturengröße.x > MaximaleTexturengröße
        or
          Texturengröße.y > MaximaleTexturengröße
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => Decode (Item => TexturenpfadExtern) & " überschreitet Grafikkartetexturennmaximum:" & MaximaleTexturengröße'Wide_Wide_Image);
         return null;
                  
      else
         return Sf.Graphics.Texture.createFromFile (filename => TexturenpfadExtern);
      end if;
      
   end Texturenlimit;
   
end EinlesenAllgemeinesLogik;
