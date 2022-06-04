pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard;

with RueckgabeDatentypen;
with TastenbelegungDatentypen;

package OptionenSteuerung is

   function SteuerungBelegen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   NeueTasteTerminal : Wide_Wide_Character;

   NeueAuswahl : TastenbelegungDatentypen.Tastenbelegung_Enum;

   NeueTasteSFML : Sf.Window.Keyboard.sfKeyCode;

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure AlteTasteEntfernen;
   procedure NeueTasteFestlegen;
   procedure AlteTasteEntfernenTerminal;
   procedure AlteTasteEntfernenSFML;
   procedure NeueTasteFestlegenTerminal;
   procedure NeueTasteFestlegenSFML;

end OptionenSteuerung;
