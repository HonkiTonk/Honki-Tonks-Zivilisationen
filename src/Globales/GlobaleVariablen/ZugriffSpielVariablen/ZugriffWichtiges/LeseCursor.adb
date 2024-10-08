with SpielVariablen;

package body LeseCursor is

   function KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAktuell;
      
   end KoordinatenAktuell;
   
   
   
   function EAchseAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.Ebene
   is begin
      
      return SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAktuell.EAchse;
      
   end EAchseAktuell;
   
   

   function KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAlt;
      
   end KoordinatenAlt;
   
   
   
   function YAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.SenkrechtePositiv
   is begin
      
      return SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAlt.YAchse;
      
   end YAchseAlt;
   
   
   
   function XAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.WaagerechtePositiv
   is begin
      
      return SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAlt.XAchse;
      
   end XAchseAlt;
   
   
      
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.CursorRecord
   is begin
      
      return SpielVariablen.CursorImSpiel (SpeziesExtern);
      
   end GanzerEintrag;

end LeseCursor;
