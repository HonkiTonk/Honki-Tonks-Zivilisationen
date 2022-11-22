with RassenDatentypen;
with KartenRecords;
with KartenDatentypen;

package LeseCursor is
   pragma Elaborate_Body;

   function KoordinatenAktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function EAchseAktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.EbeneVorhanden;

   function KoordinatenAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function YAchseAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv;
   
   function XAchseAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv;
   
   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.CursorRecord;

end LeseCursor;
