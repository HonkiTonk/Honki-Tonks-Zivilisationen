with Ada.Directories; use Ada.Directories;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

package body MeldungSchreiben is

   procedure Meldung
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      AbwartenSchleife:
      while Is_Open (File => DateiMeldung) loop
         
         delay Wartezeit;
         
      end loop AbwartenSchleife;
      
      case
        Exists (Name => Meldungen)
      is
         when True =>
            Open (File => DateiMeldung,
                  Mode => Append_File,
                  Name => Meldungen,
                  Form => Dateiform);
            
         when False =>
            Create (File => DateiMeldung,
                    Mode => Out_File,
                    Name => Meldungen,
                    Form => Dateiform);
      end case;
      
      Put (File => DateiMeldung,
           Item => Decode (Item => Local_Image (Date                  => Clock,
                                                Include_Time_Fraction => False))
           & ": " & MeldungExtern);
      
      Close (File => DateiMeldung);
      
   exception
     when StandardAdaFehler : others =>
       Put (Item => "MeldungSchreiben.Meldung - Konnte nicht geschrieben werden" & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiMeldung)
         is
            when True =>
               Close (File => DateiMeldung);
               
            when False =>
               null;
         end case;
         
   end Meldung;
   
   
   
   procedure MeldungASCII
     (MeldungExtern : in String)
   is begin

      Meldung (MeldungExtern => Decode (Item => MeldungExtern));
      
   end MeldungASCII;

end MeldungSchreiben;
