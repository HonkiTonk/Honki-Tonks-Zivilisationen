with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;
with StandardTastenbelegungDatenbank;

with Fehlermeldungssystem;

package body EinlesenTastaturLogik is

   procedure Tastaturbelegung
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Tasteneinstellungen)
      is
         when False =>
            StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
            return;
            
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Tasteneinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        TastaturbelegungDurchgehen (LadenPrüfenExtern => False,
                                    DateiLadenExtern  => TastenbelegungLaden)
      is
         when True =>
            Set_Index (File => TastenbelegungLaden,
                       To   => 1);
                        
            Nullwert := TastaturbelegungDurchgehen (LadenPrüfenExtern => True,
                                                    DateiLadenExtern  => TastenbelegungLaden);
              
         when False =>
            StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
      end case;
      
      Close (File => TastenbelegungLaden);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTastaturLogik.Tastaturbelegung - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
         
         case
           Is_Open (File => TastenbelegungLaden)
         is
            when True =>
               Close (File => TastenbelegungLaden);
               
            when False =>
               null;
         end case;
      
   end Tastaturbelegung;
   
   
   
   function TastaturbelegungDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
     return Boolean
   is begin
      
      TastenbelegungDatenbank.AllgemeineBelegungArray'Read (Stream (File => DateiLadenExtern),
                                                            AllgemeineBelegung);
      
      TastenbelegungDatenbank.EinheitenbelegungArray'Read (Stream (File => DateiLadenExtern),
                                                           Einheitenbelegung);
      
      TastenbelegungDatenbank.StadtbelegungArray'Read (Stream (File => DateiLadenExtern),
                                                       Stadtbelegung);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            TastenbelegungDatenbank.AllgemeineBelegung := AllgemeineBelegung;
            TastenbelegungDatenbank.Einheitenbelegung := Einheitenbelegung;
            TastenbelegungDatenbank.Stadtbelegung := Stadtbelegung;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTastaturLogik.TastaturbelegungDurchgehen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end TastaturbelegungDurchgehen;

end EinlesenTastaturLogik;
