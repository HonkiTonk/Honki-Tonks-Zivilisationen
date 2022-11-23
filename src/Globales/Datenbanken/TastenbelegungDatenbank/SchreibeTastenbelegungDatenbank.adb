with TastenbelegungDatenbank;

package body SchreibeTastenbelegungDatenbank is
   
   procedure AllgemeineBelegung
     (BefehlExtern : in TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      TastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern) := TasteExtern;
      
   end AllgemeineBelegung;
   
   
   
   procedure Einheitenbelegung
     (BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      TastenbelegungDatenbank.Einheitenbelegung (BefehlExtern) := TasteExtern;
      
   end Einheitenbelegung;
   
   
      
   procedure Stadtbelegung
     (BefehlExtern : in BefehleDatentypen.Stadtbefehle_Auswählen_Enum;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      TastenbelegungDatenbank.Stadtbelegung (BefehlExtern) := TasteExtern;
      
   end Stadtbelegung;

end SchreibeTastenbelegungDatenbank;
