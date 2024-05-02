with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

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
   
   
   
   function Texturenlimit
     (TexturenpfadExtern : in String)
      return Sf.Graphics.sfTexture_Ptr
   is begin
      
      return Sf.Graphics.Texture.createFromFile (filename => TexturenpfadExtern);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenAllgemeinesLogik.Texturenlimit: " & Decode (Item => TexturenpfadExtern) & " Texturenmaximum:" & MaximaleTexturengröße'Wide_Wide_Image & " "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return null;
         
   end Texturenlimit;
   
end EinlesenAllgemeinesLogik;
