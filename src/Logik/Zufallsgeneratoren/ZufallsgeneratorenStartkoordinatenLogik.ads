pragma Warnings (Off, "*array aggregate*");

private with Ada.Numerics.Discrete_Random;

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with KartenRecords;
with Weltkarte;

package ZufallsgeneratorenStartkoordinatenLogik is
   pragma Elaborate_Body;
     
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
                  Startkoordinaten'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  Startkoordinaten'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );

private
   
   Startkoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;

   package KartenpunktWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.KartenfeldPositiv);

   KartenpunktGewählt : KartenpunktWählen.Generator;

end ZufallsgeneratorenStartkoordinatenLogik;
