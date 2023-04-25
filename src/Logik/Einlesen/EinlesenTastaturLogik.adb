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
            
            PrüfungErfolgreich := TastaturbelegungDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => TastenbelegungLaden);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Tastenbelegung,
                  Form => "WCEM=8");
                        
            Nullwert := TastaturbelegungDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => TastenbelegungLaden);
            
         when False =>
            StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
      end case;
      
   end Tastaturbelegung;
   
   
   
   function TastaturbelegungDurchgehen
     (LadenPrüfenExtern : in Boolean)
     return Boolean
   is begin
      
      TastenbelegungDatenbank.AllgemeineBelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                            AllgemeineBelegung);
      
      TastenbelegungDatenbank.EinheitenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                           Einheitenbelegung);
      
      TastenbelegungDatenbank.StadtbelegungArray'Read (Stream (File => TastenbelegungLaden),
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
      when Constraint_Error | End_Error =>
         return False;
      
   end TastaturbelegungDurchgehen;

end EinlesenTastaturLogik;
