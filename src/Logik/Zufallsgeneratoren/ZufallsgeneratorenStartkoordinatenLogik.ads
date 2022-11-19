private with Ada.Numerics.Discrete_Random;

with KartenDatentypen;
with RassenDatentypen;
with SpielVariablen;
with KartenRecords;

with LeseWeltkarteneinstellungen;

package ZufallsgeneratorenStartkoordinatenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;
     
   function Startkoordinaten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
           
       Post => (
                  Startkoordinaten'Result.EAchse in -1 .. 0
                and
                  Startkoordinaten'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  Startkoordinaten'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

private
   
   Startkoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;

   package KartenpunktWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.KartenfeldPositiv);

   KartenpunktGewählt : KartenpunktWählen.Generator;

end ZufallsgeneratorenStartkoordinatenLogik;
