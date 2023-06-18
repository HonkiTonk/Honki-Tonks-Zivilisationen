with Sf.Window.Keyboard;

with TastenbelegungDatentypen;
with BefehleDatentypen;
with TastenbelegungDatenbank;

package SchreibeTastenbelegungDatenbank is
   pragma Elaborate_Body;

   procedure AllgemeineBelegung
     (BefehlExtern : in TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode);
   pragma Inline (AllgemeineBelegung);
   
   procedure Einheitenbelegung
     (BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode);
   pragma Inline (Einheitenbelegung);
   
   procedure Stadtbelegung
     (BefehlExtern : in BefehleDatentypen.Stadtbefehle_Auswählen_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode);
   pragma Inline (Stadtbelegung);
   
   procedure GesamteAllgemeineTastenbelegung
     (BelegungExtern : in TastenbelegungDatenbank.AllgemeineBelegungArray);
   pragma Inline (GesamteAllgemeineTastenbelegung);
   
   procedure GesamteEinheitenbelegung
     (BelegungExtern : in TastenbelegungDatenbank.EinheitenbelegungArray);
   pragma Inline (GesamteEinheitenbelegung);
   
   procedure GesamteStadtbelegung
     (BelegungExtern : in TastenbelegungDatenbank.StadtbelegungArray);
   pragma Inline (GesamteStadtbelegung);

end SchreibeTastenbelegungDatenbank;
