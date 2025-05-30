with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ArraysHTSEB;

package SetauswahlLogik is
   pragma Elaborate_Body;
   
   Auswahlmöglichkeiten : ArraysHTSEB.SetsArray;
   
   

   function Setauswahl
     (SpracheExtern : in Boolean)
      return Unbounded_Wide_Wide_String;
   
private

   MehrereSeiten : Boolean;

   Ende : Positive;
      
   ZehnerReihe : Natural;
   AktuelleAuswahl : Natural;
   
   procedure SetlisteFestlegen;
   
   
   
   function AuswahlSet
     return Unbounded_Wide_Wide_String;

end SetauswahlLogik;
