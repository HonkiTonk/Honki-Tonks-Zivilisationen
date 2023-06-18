with Sf.Window.Keyboard;

with TastenbelegungDatentypen;
with BefehleDatentypen;

package LeseTastenbelegungDatenbank is
   pragma Elaborate_Body;

   function AllgemeineBelegung
     (BefehlExtern : in TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum)
      return Sf.Window.Keyboard.sfKeyCode;
   pragma Inline (AllgemeineBelegung);
   
   function Einheitenbelegung
     (BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum)
      return Sf.Window.Keyboard.sfKeyCode;
   pragma Inline (Einheitenbelegung);
   
   function Stadtbelegung
     (BefehlExtern : in BefehleDatentypen.Stadtbefehle_Auswählen_Enum)
      return Sf.Window.Keyboard.sfKeyCode;
   pragma Inline (Stadtbelegung);

end LeseTastenbelegungDatenbank;
