with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package ZeilenumbruchberechnungGrafik is
   pragma Elaborate_Body;
   
   function Zeilenumbruchberechnung
     (TextExtern : in Wide_Wide_String;
      TextfeldbreiteExtern : in Float;
      BreitenabzugExtern : in Float)
      return Wide_Wide_String
     with
       Pre => (
                 TextfeldbreiteExtern > 0.00
               and
                 BreitenabzugExtern >= 0.00
              );
   
private
   
   SchleifenAnfang : Positive;
   SchleifenEnde : Positive;

   Zwischenwert : Integer;
   
   Textfeldbreitenmultiplikator : constant Float := 0.75;
   Textfeldbreite : Float;
   
   NeuerText : Unbounded_Wide_Wide_String;

end ZeilenumbruchberechnungGrafik;
