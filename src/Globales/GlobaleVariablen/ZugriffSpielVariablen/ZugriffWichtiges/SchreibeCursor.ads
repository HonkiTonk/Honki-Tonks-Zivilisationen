with RassenDatentypen;
with KartenRecords;
with KartenDatentypen;

package SchreibeCursor is
   pragma Elaborate_Body;

   procedure KoordinatenAktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord);
   
   procedure EAchseAktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden);

   procedure KoordinatenAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord);
   
   procedure EAchseAlt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure Standardeinstellungen;
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in KartenRecords.CursorRecord);

end SchreibeCursor;
