pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package ZeilenumbruchberechnungGrafik is

   function ZeilenumbruchBerechnen
     (TextExtern : in Wide_Wide_String;
      BreiteExtern : in Float)
      return Wide_Wide_String
     with
       Pre => (
                 BreiteExtern > 0.00
              );
   
private
   
   SchleifenAnfang : Natural;
   SchleifenEnde : Natural;

   Zwischenwert : Integer;
   
   BreiteTextfeld : Float;
   
   NeuerText : Unbounded_Wide_Wide_String;

end ZeilenumbruchberechnungGrafik;
