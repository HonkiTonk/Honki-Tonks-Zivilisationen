with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

package LeseCursor is
   pragma Elaborate_Body;

   function KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord;
   pragma Inline (KoordinatenAktuell);
   
   function EAchseAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.EbeneVorhanden;
   pragma Inline (EAchseAktuell);

   function KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord;
   pragma Inline (KoordinatenAlt);
   
   function YAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv;
   pragma Inline (YAchseAlt);
   
   function XAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv;
   pragma Inline (XAchseAlt);
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.CursorRecord;
   pragma Inline (GanzerEintrag);

end LeseCursor;
