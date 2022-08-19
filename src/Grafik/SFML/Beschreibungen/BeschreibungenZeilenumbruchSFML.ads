pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package BeschreibungenZeilenumbruchSFML is

   function ZeilenumbruchBerechnen
     (TextExtern : in Wide_Wide_String)
      return Wide_Wide_String;
   
private
   
   SchleifenAnfang : Natural;
   SchleifenEnde : Natural;

   Zwischenwert : Integer;
   
   BreiteTextfeld : Float;
   
   AktuellerTextbereichEins : Unbounded_Wide_Wide_String;
   AktuellerTextbereichZwei : Unbounded_Wide_Wide_String;

end BeschreibungenZeilenumbruchSFML;
