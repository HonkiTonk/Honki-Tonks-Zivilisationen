with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;

package LadenEinheitenLogik is
   pragma Elaborate_Body;

   function Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadennExtern : in File_Type)
      return Boolean;
   
private
   
   
   
   

   function Einheitenwerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadennExtern : in File_Type)
      return Boolean;

end LadenEinheitenLogik;
