with TastenbelegungDatenbank;

package body LeseTastenbelegungDatenbank is

   function AllgemeineBelegung
     (BefehlExtern : in TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum)
      return Sf.Window.Keyboard.sfKeyCode
   is begin
      
      return TastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern);
      
   end AllgemeineBelegung;
   
   

   function Einheitenbelegung
     (BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum)
      return Sf.Window.Keyboard.sfKeyCode
   is begin
      
      return TastenbelegungDatenbank.Einheitenbelegung (BefehlExtern);
      
   end Einheitenbelegung;
   
   

   function Stadtbelegung
     (BefehlExtern : in BefehleDatentypen.Stadtbefehle_Auswählen_Enum)
      return Sf.Window.Keyboard.sfKeyCode
   is begin
      
      return TastenbelegungDatenbank.Stadtbelegung (BefehlExtern);
      
   end Stadtbelegung;

end LeseTastenbelegungDatenbank;
