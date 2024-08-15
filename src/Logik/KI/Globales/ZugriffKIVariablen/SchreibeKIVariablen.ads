with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package SchreibeKIVariablen is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure Kriegszustand
     (ZustandExtern : in Boolean);

   procedure Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      AbschnittExtern : in EinheitenDatentypen.Bewegungsplan;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Standardeinstellungen;

end SchreibeKIVariablen;
