with WichtigesRecordKonstanten;
with SpielVariablen;

package body SchreibeCursor is

   procedure KoordinatenAktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := KoordinatenExtern;
      
   end KoordinatenAktuell;
   
   
   
   procedure EAchseAktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := EAchseExtern;
      
   end EAchseAktuell;
   
   

   procedure KoordinatenAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := KoordinatenExtern;
      
   end KoordinatenAlt;
   
   
   
   procedure EAchseAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse := EAchseExtern;
      
   end EAchseAlt;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.CursorImSpiel := (others => WichtigesRecordKonstanten.LeerCursor);
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in KartenRecords.CursorRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (RasseExtern) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeCursor;
