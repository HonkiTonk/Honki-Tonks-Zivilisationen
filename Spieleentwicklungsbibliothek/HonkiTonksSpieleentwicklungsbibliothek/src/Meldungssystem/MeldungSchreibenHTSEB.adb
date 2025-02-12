with Ada.Directories;
with Ada.Exceptions;
with Ada.Calendar;
with Ada.Calendar.Formatting;

with DateisystemvariablenHTSEB;
with MeldungsvariablenHTSEB;
with UmwandlungssystemHTSEB;

package body MeldungSchreibenHTSEB is

   procedure Meldung
     (MeldungExtern : in Wide_Wide_String)
   is
      use Ada.Directories;
      use Ada.Exceptions;
      use Ada.Calendar;
      use Ada.Calendar.Formatting;
   begin
      
      AbwartenSchleife:
      while Is_Open (File => DateiMeldung) loop
                  
         delay until Clock + Wartezeit;
         
      end loop AbwartenSchleife;
      
      case
        Exists (Name => Meldungen)
      is
         when True =>
            Open (File => DateiMeldung,
                  Mode => Append_File,
                  Name => Meldungen,
                  Form => DateisystemvariablenHTSEB.DateiformAbfragen);
            
         when False =>
            Create (File => DateiMeldung,
                    Mode => Out_File,
                    Name => Meldungen,
                    Form => DateisystemvariablenHTSEB.DateiformAbfragen);
      end case;
      
      Put (File => DateiMeldung,
           Item => UmwandlungssystemHTSEB.Decode (TextExtern => Local_Image (Date                  => Clock,
                                                                             Include_Time_Fraction => False))
           & " (Version: " & MeldungsvariablenHTSEB.VersionsnummerAbfragen & "): " & MeldungExtern);
      
      Close (File => DateiMeldung);
      
   exception
     when StandardAdaFehler : others =>
       Put (Item => "MeldungSchreiben.Meldung - Konnte nicht geschrieben werden" & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
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

      Meldung (MeldungExtern => UmwandlungssystemHTSEB.Decode (TextExtern => MeldungExtern));
      
   end MeldungASCII;

end MeldungSchreibenHTSEB;
