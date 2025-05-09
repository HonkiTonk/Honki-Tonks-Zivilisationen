with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;

private with SpielRecords;

package LadenDiplomatieLogik is
   pragma Elaborate_Body;

   function Diplomatie
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private

   Diplomatieeintrag : SpielRecords.DiplomatieRecord;

end LadenDiplomatieLogik;
