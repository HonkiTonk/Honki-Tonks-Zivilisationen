pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard;

with RueckgabeDatentypen;
with TastenbelegungDatentypen;

package OptionenSteuerung is

   function SteuerungBelegen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   NeueTasteKonsole : Wide_Wide_Character;

   NeueAuswahl : TastenbelegungDatentypen.Tastenbelegung_Enum;

   NeueTasteSFML : Sf.Window.Keyboard.sfKeyCode;

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure AlteTasteEntfernen;
   procedure NeueTasteFestlegen;
   procedure AlteTasteEntfernenKonsole;
   procedure AlteTasteEntfernenSFML;
   procedure NeueTasteFestlegenKonsole;
   procedure NeueTasteFestlegenSFML;

end OptionenSteuerung;
