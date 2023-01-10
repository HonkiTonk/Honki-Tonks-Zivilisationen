with WichtigesRecordKonstanten;
with SpielVariablen;

package body SchreibeCursor is

   procedure KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAktuell := KoordinatenExtern;
      
   end KoordinatenAktuell;
   
   
   
   procedure EAchseAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAktuell.EAchse := EAchseExtern;
      
   end EAchseAktuell;
   
   

   procedure KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAlt := KoordinatenExtern;
      
   end KoordinatenAlt;
   
   
   
   procedure EAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAlt.EAchse := EAchseExtern;
      
   end EAchseAlt;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.CursorImSpiel := (others => WichtigesRecordKonstanten.LeerCursor);
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in KartenRecords.CursorRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeCursor;
