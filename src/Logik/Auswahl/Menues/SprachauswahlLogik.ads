with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package SprachauswahlLogik is
   pragma Elaborate_Body;
      
   -- Das auch mal in irgendwas Globales verschieben? äöü
   type AktuelleSprachenArray is array (1 .. 11) of Unbounded_Wide_Wide_String;
   AktuelleSprachen : AktuelleSprachenArray;
   
   

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
