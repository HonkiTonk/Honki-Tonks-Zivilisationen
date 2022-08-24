pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Window.Keyboard;

with RueckgabeDatentypen;

private with TastenbelegungDatentypen;

package OptionenSteuerung is

   function SteuerungBelegen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   NeueAuswahl : TastenbelegungDatentypen.Tastenbelegung_Enum;

   NeueTasteSFML : Sf.Window.Keyboard.sfKeyCode;

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure AlteTasteEntfernenSFML;
   procedure NeueTasteFestlegenSFML;

end OptionenSteuerung;
