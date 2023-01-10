with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

package SchreibeCursor is
   pragma Elaborate_Body;

   procedure KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord);
   
   procedure EAchseAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden);

   procedure KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord);
   
   procedure EAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure Standardeinstellungen;
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in KartenRecords.CursorRecord);

end SchreibeCursor;
