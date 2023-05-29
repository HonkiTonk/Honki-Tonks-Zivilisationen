with Ada.Directories; use Ada.Directories;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

package body FehlermeldungSchreiben is

   procedure MeldungSchreiben
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => "Meldungen")
      is
         when True =>
            Open (File => DateiMeldung,
                  Mode => Append_File,
                  Name => "Meldungen",
                  Form => "WCEM=8");
            
         when False =>
            Create (File => DateiMeldung,
                    Mode => Out_File,
                    Name => "Meldungen",
                    Form => "WCEM=8");
      end case;
      
      Put (File => DateiMeldung,
           Item => Decode (Item => Local_Image (Date                  => Clock,
                                                Include_Time_Fraction => False))
           & ": " & MeldungExtern);
      
      Close (File => DateiMeldung);
      
   exception
      when StandardAdaFehler : others =>
         Ada.Text_IO.Put (Item => "FehlermeldungSchreiben.MeldungSchreiben - Konnte nicht geschrieben werden" & Exception_Information (X => StandardAdaFehler));
         
         case
           Is_Open (File => DateiMeldung)
         is
            when True =>
               Close (File => DateiMeldung);
               
            when False =>
               null;
         end case;
      
   end MeldungSchreiben;
   
   
   
   procedure MeldungSchreibenASCII
     (MeldungExtern : in String)
   is begin
      
      case
        Exists (Name => "Meldungen")
      is
         when True =>
            Ada.Text_IO.Open (File => DateiMeldungASCII,
                              Mode => Ada.Text_IO.Append_File,
                              Name => "Meldungen",
                              Form => "WCEM=8");
            
         when False =>
            Ada.Text_IO.Create (File => DateiMeldungASCII,
                                Mode => Ada.Text_IO.Out_File,
                                Name => "Meldungen",
                                Form => "WCEM=8");
      end case;
      
      Ada.Text_IO.Put (File => DateiMeldungASCII,
                       Item => Local_Image (Date                  => Clock,
                                            Include_Time_Fraction => False)
                       & ": " & MeldungExtern);
      
      Ada.Text_IO.Close (File => DateiMeldungASCII);
      
   exception
      when StandardAdaFehler : others =>
         Ada.Text_IO.Put (Item => "FehlermeldungSchreiben.MeldungSchreibenASCII - Konnte nicht geschrieben werden" & Exception_Information (X => StandardAdaFehler));
         
         case
           Ada.Text_IO.Is_Open (File => DateiMeldungASCII)
         is
            when True =>
               Ada.Text_IO.Close (File => DateiMeldungASCII);
               
            when False =>
               null;
         end case;
      
   end MeldungSchreibenASCII;

end FehlermeldungSchreiben;
