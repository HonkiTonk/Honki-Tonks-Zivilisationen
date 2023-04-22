with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package SchreibeCursor is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   pragma Inline (KoordinatenAktuell);
   
   procedure EAchseAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden);
   pragma Inline (EAchseAktuell);

   procedure KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   pragma Inline (KoordinatenAlt);
   
   procedure EAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EAchseExtern : in KartenDatentypen.EbeneVorhanden);
   pragma Inline (EAchseAlt);
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in KartenRecords.CursorRecord)
     with
       Pre => (
                 EintragExtern.KoordinatenAktuell.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 EintragExtern.KoordinatenAktuell.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EintragExtern.KoordinatenAlt.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 EintragExtern.KoordinatenAlt.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   pragma Inline (GanzerEintrag);

end SchreibeCursor;
