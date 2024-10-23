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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Standardeinstellungen;

end SchreibeKIVariablen;
