with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with RueckgabeDatentypen;

package SteuerungsauswahlLogik is
   pragma Elaborate_Body;
   
   -- Das hier später noch in irgendwas Globales schieben. äöü
   type Kategorie_Enum is (
                           Kategorie_Eins_Enum, Kategorie_Zwei_Enum, Kategorie_Drei_Enum
                          );
   
   WelcheSteuerung : Kategorie_Enum := Kategorie_Eins_Enum;
   
   
   
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
private

   Anfang : constant Positive := 1;
   Ende : Positive;
   
   AktuelleAuswahl : Integer;
   
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   NeueTaste : Sf.Window.Keyboard.sfKeyCode;
   
   type NummerZuKategorieArray is array (-3 .. -1) of Kategorie_Enum;
   NummerZuKategorie : constant NummerZuKategorieArray := (
                                                           -1 => Kategorie_Eins_Enum,
                                                           -2 => Kategorie_Zwei_Enum,
                                                           -3 => Kategorie_Drei_Enum
                                                          );
      
   procedure TasteBelegen
     (AuswahlExtern : in Positive;
      WelcheSteuerungExtern : in Kategorie_Enum);
   
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
