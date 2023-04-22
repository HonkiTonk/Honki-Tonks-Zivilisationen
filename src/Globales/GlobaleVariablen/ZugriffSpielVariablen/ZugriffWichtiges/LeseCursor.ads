with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package LeseCursor is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KoordinatenAktuell'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  KoordinatenAktuell'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   pragma Inline (KoordinatenAktuell);
   
   function EAchseAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.EbeneVorhanden
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (EAchseAktuell);

   function KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KoordinatenAlt'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  KoordinatenAlt'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   pragma Inline (KoordinatenAlt);
   
   function YAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  YAchseAlt'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   pragma Inline (YAchseAlt);
   
   function XAchseAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  XAchseAlt'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   pragma Inline (XAchseAlt);
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.CursorRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  GanzerEintrag'Result.KoordinatenAktuell.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  GanzerEintrag'Result.KoordinatenAktuell.XAchse <= LeseWeltkarteneinstellungen.XAchse
                and
                  GanzerEintrag'Result.KoordinatenAlt.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  GanzerEintrag'Result.KoordinatenAlt.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   pragma Inline (GanzerEintrag);

end LeseCursor;
