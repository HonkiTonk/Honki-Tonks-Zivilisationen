pragma SPARK_Mode (On);

with Sf.Window.Keyboard;
use Sf.Window.Keyboard;

with SystemDatentypen;

package OptionenSteuerung is

   function SteuerungBelegen
     return Integer;

private

   NeueAuswahl : SystemDatentypen.Tastenbelegung_Enum;

   NeueTaste : Sf.Window.Keyboard.sfKeyCode;

   AuswahlWert : Integer;

   procedure AlteTasteEntfernen;
   procedure NeueTasteFestlegen;

end OptionenSteuerung;
