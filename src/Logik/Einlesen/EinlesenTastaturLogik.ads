with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with TastenbelegungDatenbank;

package EinlesenTastaturLogik is
   pragma Elaborate_Body;
   
   procedure Tastaturbelegung;
   
private
   
   PrüfungErfolgreich : Boolean;
   Nullwert : Boolean;
   
   TastenbelegungLaden : File_Type;
   
   AllgemeineBelegung : TastenbelegungDatenbank.AllgemeineBelegungArray;
   
   Einheitenbelegung : TastenbelegungDatenbank.EinheitenbelegungArray;
   
   Stadtbelegung : TastenbelegungDatenbank.StadtbelegungArray;
   
   
   
   function TastaturbelegungDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;

end EinlesenTastaturLogik;
