with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

package LeseCursor is
   pragma Elaborate_Body;

   function KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function EAchseAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.EbeneVorhanden;

   function KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function YAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv;
   
   function XAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv;
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.CursorRecord;

end LeseCursor;
