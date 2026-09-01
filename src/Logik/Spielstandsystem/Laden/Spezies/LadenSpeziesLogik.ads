with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package LadenSpeziesLogik is
   pragma Elaborate_Body;

   function SpezieswerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private

   LadezeitBasis : Float;
   Ladezeit : Float;

end LadenSpeziesLogik;
