with Sf.Window.Keyboard;

private with Sf.Window.Mouse;

with TastenbelegungDatentypen;
with BefehleDatentypen;

package TasteneingabeLogik is
   pragma Elaborate_Body;
   
   function VereinfachteEingabe
     return TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   
   function ErweiterteVereinfachteEingabe
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
   
   Tasteneingabe : TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   
   type TastenRecord is record
      
      Maustaste : Sf.Window.Mouse.sfMouseButton;
      
      Tastaturtaste : Sf.Window.Keyboard.sfKeyCode;
      
      Mausrad : Float;
      
   end record;
   
   VereinfachteEingabeTasten : TastenRecord;
   AllgemeineTasteTasten : TastenRecord;
   EinheitentasteTasten : TastenRecord;
   StadttasteTasten : TastenRecord;
   TastenbelegungAnpassenTasten : TastenRecord;
   
   
   
   function EingabeanfangSetzen
     return TastenRecord;
   
end TasteneingabeLogik;
