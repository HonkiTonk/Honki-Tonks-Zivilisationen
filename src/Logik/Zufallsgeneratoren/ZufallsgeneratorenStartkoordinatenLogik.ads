private with Ada.Numerics.Discrete_Random;

with KartenDatentypen;
with SpeziesDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package ZufallsgeneratorenStartkoordinatenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
     
   function Startkoordinaten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
           
       Post => (
                  Startkoordinaten'Result.Ebene in KartenDatentypen.EbeneUnterflächeOberfläche'Range
                and
                  Startkoordinaten'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  Startkoordinaten'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

private
   
   Startkoordinate : KartenRecords.KartenfeldNaturalRecord;

   package YKartenpunktWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.SenkrechtePositiv);
   package XKartenpunktWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.WaagerechtePositiv);

   YKartenpunktGewählt : YKartenpunktWählen.Generator;
   XKartenpunktGewählt : XKartenpunktWählen.Generator;

end ZufallsgeneratorenStartkoordinatenLogik;
