pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with RueckgabeDatentypen;

private with SystemRecords;

package SteuerungsauswahlLogik is
   
   WelcheSteuerung : Boolean := False;
   
   
   
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
private

   Anfang : constant Positive := 1;
   Ende : Positive;
   
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   NeueTaste : Sf.Window.Keyboard.sfKeyCode;

   AktuelleAuswahl : SystemRecords.MehrfacheAuswahlRecord;
      
   procedure TasteBelegen
     (AuswahlExtern : in Positive;
      WelcheSteuerungExtern : in Boolean);
   
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
   
end SteuerungsauswahlLogik;
