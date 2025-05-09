with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;

package LadenStaedteLogik is
   pragma Elaborate_Body;

   function Städte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadennExtern : in File_Type)
      return Boolean;
   
private
   
   
   
   
   
   function Städtewerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadennExtern : in File_Type)
      return Boolean;

end LadenStaedteLogik;
