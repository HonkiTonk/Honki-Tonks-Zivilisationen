with WichtigesRecordKonstanten;
with SpielVariablen;

package body SchreibeCursor is

   procedure KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAktuell := KoordinatenExtern;
      
   end KoordinatenAktuell;
   
   
   
   procedure EbeneAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAktuell.Ebene := EbeneExtern;
      
   end EbeneAktuell;
   
   

   procedure KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAlt := KoordinatenExtern;
      
   end KoordinatenAlt;
   
   
   
   procedure EbeneAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern).KoordinatenAlt.Ebene := EbeneExtern;
      
   end EbeneAlt;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.CursorImSpiel := (others => WichtigesRecordKonstanten.LeerCursor);
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EintragExtern : in KartenRecords.ZeigerRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (SpeziesExtern) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeCursor;
