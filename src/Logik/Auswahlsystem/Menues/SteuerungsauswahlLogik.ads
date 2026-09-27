with Sf.Window.Keyboard;

private with SystemRecords;

with RueckgabeDatentypen;
with TastenbelegungDatentypen;

package SteuerungsauswahlLogik is
   pragma Elaborate_Body;
   
   -- Das auch mal auslagern und mit Schreibe/Leseprozeduren/funktionen versehen. äöü
   WelcheSteuerung : TastenbelegungDatentypen.Tastenbelegungskategorie_Enum := TastenbelegungDatentypen.Allgemeinbelegung_Enum;
   
   
   
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
private
   use type Sf.Window.Keyboard.sfKeyCode;

   Anfang : constant Positive := 1;
   Ende : Positive;
   
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   AllgemeineAuswahl : TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   
   NeueTaste : Sf.Window.Keyboard.sfKeyCode;
   
   AktuelleAuswahl : SystemRecords.DoppelauswahlRecord;
   
   type NummerZuKategorieArray is array (-3 .. -1) of TastenbelegungDatentypen.Tastenbelegungskategorie_Enum;
   NummerZuKategorie : constant NummerZuKategorieArray := (
                                                           -1 => TastenbelegungDatentypen.Allgemeinbelegung_Enum,
                                                           -2 => TastenbelegungDatentypen.Einheitenbelegung_Enum,
                                                           -3 => TastenbelegungDatentypen.Stadtbelegung_Enum
                                                          );
      
   procedure TasteBelegen
     (AuswahlExtern : in Positive;
      WelcheSteuerungExtern : in TastenbelegungDatentypen.Tastenbelegungskategorie_Enum);
   
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
