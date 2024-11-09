with Ada.Directories; use Ada.Directories;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;

with DateizugriffssystemHTB5;

with UmwandlungenAdaEigenes;

package body FehlermeldungSchreiben is

   procedure MeldungSchreiben
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Meldungen)
      is
         when True =>
            DateizugriffssystemHTB5.ErweiternText (DateiartExtern => DateiMeldung,
                                      NameExtern     => Meldungen);
            
         when False =>
            DateizugriffssystemHTB5.ErstellenText (DateiartExtern => DateiMeldung,
                                      NameExtern     => Meldungen);
      end case;
      
      Put (File => DateiMeldung,
           Item => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Local_Image (Date                  => Clock,
                                                                                    Include_Time_Fraction => False))
           & ": " & MeldungExtern);
      
      Close (File => DateiMeldung);
      
   exception
      when StandardAdaFehler : others =>
         Put (Item => "FehlermeldungSchreiben.MeldungSchreiben - Konnte nicht geschrieben werden" & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
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
      
      MeldungSchreiben (MeldungExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => MeldungExtern));
      
   end MeldungSchreibenASCII;

end FehlermeldungSchreiben;
