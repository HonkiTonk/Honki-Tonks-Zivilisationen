with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;

private with StadtRecords;
private with StadtDatentypen;

package LadenStaedteLogik is
   pragma Elaborate_Body;

   function Städte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private

   Stadt : StadtRecords.StadtGebautRecord;

   VorhandeneStädte : StadtDatentypen.Städtebereich;
   
   
   
   function Stadtwerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type;
      StadtExtern : in StadtDatentypen.StädtebereichVorhanden)
      return Boolean;

end LadenStaedteLogik;
