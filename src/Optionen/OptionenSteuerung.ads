pragma SPARK_Mode (On);

with Sf.Window.Keyboard;

with SystemDatentypen;

package OptionenSteuerung is

   function SteuerungBelegen
     return Integer;

private

   NeueTasteKonsole : Wide_Wide_Character;

   NeueAuswahl : SystemDatentypen.Tastenbelegung_Enum;

   NeueTasteSFML : Sf.Window.Keyboard.sfKeyCode;

   AuswahlWert : Integer;

   procedure AlteTasteEntfernen;
   procedure NeueTasteFestlegen;
   procedure AlteTasteEntfernenKonsole;
   procedure AlteTasteEntfernenSFML;
   procedure NeueTasteFestlegenKonsole;
   procedure NeueTasteFestlegenSFML;

end OptionenSteuerung;
