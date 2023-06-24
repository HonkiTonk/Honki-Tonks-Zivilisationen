with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextArrays;

package SprachauswahlLogik is
   pragma Elaborate_Body;
      
   AktuelleSprachen : TextArrays.SprachenArray;
   
   
   
   function AuswahlSprache
     return Unbounded_Wide_Wide_String;
   
private

   SchriftartFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   MehrereSeiten : Boolean;

   Ende : Positive;
      
   ZehnerReihe : Natural;
   AktuelleAuswahl : Natural;
   
   procedure SprachenListeFestlegen;
   
   
   
   function AuswahlSpracheSFML
     return Unbounded_Wide_Wide_String;

end SprachauswahlLogik;
