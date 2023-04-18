with Sf.Window.Keyboard;

private with Sf.Window.Mouse;

with TastenbelegungDatentypen;
with BefehleDatentypen;

package TasteneingabeLogik is
   pragma Elaborate_Body;
   
   function VereinfachteEingabe
     return TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   
   function AllgemeineTaste
     return TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   
   function Einheitentaste
     return BefehleDatentypen.Einheitenbelegung_Enum;
   
   function Stadttaste
     return BefehleDatentypen.Stadtbefehle_Enum;
   
   function TastenbelegungAnpassen
     return Sf.Window.Keyboard.sfKeyCode;
   
private
   
   Maustaste : Sf.Window.Mouse.sfMouseButton;
   
   Taste : Sf.Window.Keyboard.sfKeyCode;
   
   procedure EingabeanfangSetzen;
   
end TasteneingabeLogik;
