private with Ada.Streams.Stream_IO;

private with TastenbelegungDatenbank;

package EinlesenTastatureinstellungenLogik is
   pragma Elaborate_Body;
   
   procedure Tastatureinstellungen;
   
private
   use Ada.Streams.Stream_IO;
   
   Nullwert : Boolean;
   
   DateiTastatureinstellungen : File_Type;
   
   AllgemeineBelegung : TastenbelegungDatenbank.AllgemeineBelegungArray;
   
   Einheitenbelegung : TastenbelegungDatenbank.EinheitenbelegungArray;
   
   Stadtbelegung : TastenbelegungDatenbank.StadtbelegungArray;
   
   
   
   function TastatureinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenTastatureinstellungenLogik;
