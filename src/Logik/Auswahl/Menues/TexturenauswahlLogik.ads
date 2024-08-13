with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextArrays;

package TexturenauswahlLogik is
   pragma Elaborate_Body;
   
   AktuelleTexturen : TextArrays.SprachenArray;
   
   

   function AuswahlTexturen
     return Unbounded_Wide_Wide_String;

private
   
   MehrereSeiten : Boolean;
   
   Ende : Positive;
   
   ZehnerReihe : Natural;
   AktuelleAuswahl : Natural;
   
   procedure TexturenlisteFestlegen;
   
   
   
   function AuswahlTexturenSFML
     return Unbounded_Wide_Wide_String;
   
end TexturenauswahlLogik;
