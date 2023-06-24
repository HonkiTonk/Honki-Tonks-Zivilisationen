with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with KartenDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package LeseKIVariablen is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function Kriegszustand
     return Boolean;

   function Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AbschnittExtern : in EinheitenDatentypen.Bewegungsplan)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  Stadtverbindung'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  Stadtverbindung'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

end LeseKIVariablen;
