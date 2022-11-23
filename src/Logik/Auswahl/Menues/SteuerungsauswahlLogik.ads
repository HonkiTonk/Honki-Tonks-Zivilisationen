with Sf.Window.Keyboard;

with RueckgabeDatentypen;

package SteuerungsauswahlLogik is
   pragma Elaborate_Body;
   
   -- Das hier später noch in irgendwas Globales schieben. äöü
   type Tastenbelegungskategorie_Enum is (
                                          Allgemeine_Belegung_Enum, Einheitenbelegung_Enum, Stadtbelegung_Enum
                                         );
   
   WelcheSteuerung : Tastenbelegungskategorie_Enum := Allgemeine_Belegung_Enum;
   
   
   
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
private
   use type Sf.Window.Keyboard.sfKeyCode;

   Anfang : constant Positive := 1;
   Ende : Positive;
   
   AktuelleAuswahl : Integer;
   
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   NeueTaste : Sf.Window.Keyboard.sfKeyCode;
   
   type NummerZuKategorieArray is array (-3 .. -1) of Tastenbelegungskategorie_Enum;
   NummerZuKategorie : constant NummerZuKategorieArray := (
                                                           -1 => Allgemeine_Belegung_Enum,
                                                           -2 => Einheitenbelegung_Enum,
                                                           -3 => Stadtbelegung_Enum
                                                          );
      
   procedure TasteBelegen
     (AuswahlExtern : in Positive;
      WelcheSteuerungExtern : in Tastenbelegungskategorie_Enum);
   
   procedure AllgemeineBelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
     with
       Pre => (
                 TasteExtern /= Sf.Window.Keyboard.sfKeyUnknown
              );
   
   procedure Einheitenbelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
     with
       Pre => (
                 TasteExtern /= Sf.Window.Keyboard.sfKeyUnknown
              );
   
   procedure Stadtbelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
     with
       Pre => (
                 TasteExtern /= Sf.Window.Keyboard.sfKeyUnknown
              );
   
end SteuerungsauswahlLogik;
