with SpielVariablen;

package body LeseCursor is

   function KoordinatenAktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
   end KoordinatenAktuell;
   
   
   
   function EAchseAktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.EbeneVorhanden
   is begin
      
      return SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse;
      
   end EAchseAktuell;
   
   

   function KoordinatenAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt;
      
   end KoordinatenAlt;
   
   
   
   function YAchseAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse;
      
   end YAchseAlt;
   
   
   
   function XAchseAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse;
      
   end XAchseAlt;
   
   
      
   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.CursorRecord
   is begin
      
      return SpielVariablen.CursorImSpiel (RasseExtern);
      
   end GanzerEintrag;

end LeseCursor;
