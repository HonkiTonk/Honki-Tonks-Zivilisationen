with Sf.Window.Keyboard;

with TastenbelegungDatentypen;
with BefehleDatentypen;

-- Für die Datenbanken mal überall Zugriffdateien anlegen. äöü
package TastenbelegungDatenbank is
   pragma Elaborate_Body;

   type AllgemeineBelegungArray is array (TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   AllgemeineBelegung : AllgemeineBelegungArray;
   
   type EinheitenbelegungArray is array (BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   Einheitenbelegung : EinheitenbelegungArray;
   
   type StadtbelegungArray is array (BefehleDatentypen.Stadtbefehle_Auswählen_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   Stadtbelegung : StadtbelegungArray;

end TastenbelegungDatenbank;
