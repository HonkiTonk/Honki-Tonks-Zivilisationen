with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;
with StandardTastenbelegungDatenbank;

package body EinlesenTastaturLogik is

   procedure Tastaturbelegung
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Tastenbelegung)
      is
         when False =>
            StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
            return;
            
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Tastenbelegung,
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
      when Constraint_Error | End_Error | Ada.Streams.Stream_IO.Status_Error | Mode_Error | Ada.Streams.Stream_IO.Name_Error | Ada.Streams.Stream_IO.Use_Error | Ada.Streams.Stream_IO.Device_Error | Data_Error =>
         return False;
      
   end TastaturbelegungDurchgehen;

end EinlesenTastaturLogik;
