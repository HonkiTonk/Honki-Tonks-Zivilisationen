with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

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
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenAllgemeinesLogik.VorzeitigesDateienende: " & DateinameExtern & ": Aktuelle Zeile:" & AktuelleZeileExtern'Wide_Wide_Image & " "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenAllgemeinesLogik.TextEinlesenUngebunden: " & DateinameExtern & ": Aktuelle Zeile:" & AktuelleZeileExtern'Wide_Wide_Image & " "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return To_Unbounded_Wide_Wide_String (Source => (DateinameExtern & ", Zeile:" & AktuelleZeileExtern'Wide_Wide_Image));
         
   end TextEinlesenUngebunden;
   
   
   
   function TexturFestlegen
     (TexturenAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenpfadExtern : in String)
      return Sf.Graphics.sfTexture_Ptr
   is begin
      
      Sf.Graphics.Texture.destroy (texture => TexturenAccessExtern);
      
      return Sf.Graphics.Texture.createFromFile (filename => TexturenpfadExtern);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenAllgemeinesLogik.TexturFestlegen: " & UmwandlungssystemHTSEB.Decode (TextExtern => TexturenpfadExtern)
                                    & " Texturenmaximum:" & MaximaleTexturengröße'Wide_Wide_Image & " " & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return null;
         
   end TexturFestlegen;
   
end EinlesenAllgemeinesLogik;
