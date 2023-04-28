private with Ada.Numerics.Discrete_Random;

with KartenDatentypen;
with SpeziesDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package ZufallsgeneratorenStartkoordinatenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
     
   function Startkoordinaten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
           
       Post => (
                  Startkoordinaten'Result.EAchse in KartenDatentypen.EbeneUnterflächeOberfläche'Range
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
