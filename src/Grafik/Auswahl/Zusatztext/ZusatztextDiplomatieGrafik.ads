with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

package ZusatztextDiplomatieGrafik is
   pragma Elaborate_Body;

   function ZusatztextDiplomatie
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
               and
                 RealeViewbreiteExtern >= 0.00
              ),
         
       Post => (
                  ZusatztextDiplomatie'Result.x >= 0.00
                and
                  ZusatztextDiplomatie'Result.y >= 0.00
               );
   
private
   
   Zustandnummer : Positive;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   Rückgabewert : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function TextSetzen
     (TextnummerExtern : in Positive)
      return Wide_Wide_String;

end ZusatztextDiplomatieGrafik;
