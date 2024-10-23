with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with KartenDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package LeseKIVariablen is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function Kriegszustand
     return Boolean;

   function Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AbschnittExtern : in EinheitenDatentypen.Bewegungsplan)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  Stadtverbindung'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  Stadtverbindung'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

end LeseKIVariablen;
