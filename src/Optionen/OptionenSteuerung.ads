pragma SPARK_Mode (On);

with Sf.Window.Keyboard;
use Sf.Window.Keyboard;

with GlobaleDatentypen;
use GlobaleDatentypen;

package OptionenSteuerung is

   function SteuerungBelegen
     return Integer;

private

   NeueAuswahl : GlobaleDatentypen.Tastenbelegung_Enum;

   NeueTaste : Sf.Window.Keyboard.sfKeyCode;

   AuswahlWert : Integer;

   procedure AlteTasteEntfernen;
   procedure NeueTasteFestlegen;

end OptionenSteuerung;
