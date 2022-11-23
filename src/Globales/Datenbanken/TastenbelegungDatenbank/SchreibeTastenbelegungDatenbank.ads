with Sf.Window.Keyboard;

with TastenbelegungDatentypen;
with BefehleDatentypen;

package SchreibeTastenbelegungDatenbank is
   pragma Elaborate_Body;

   procedure AllgemeineBelegung
     (BefehlExtern : in TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode);
   
   procedure Einheitenbelegung
     (BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode);
   
   procedure Stadtbelegung
     (BefehlExtern : in BefehleDatentypen.Stadtbefehle_Auswählen_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode);

end SchreibeTastenbelegungDatenbank;
