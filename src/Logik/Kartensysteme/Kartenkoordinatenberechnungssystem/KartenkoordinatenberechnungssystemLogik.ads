with KartenDatentypen;
with KartenKonstanten;
with KartenRecords;
with SystemDatentypen;

with LeseWeltkarteneinstellungen;

package KartenkoordinatenberechnungssystemLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type KartenDatentypen.Ebene;

   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.KartenfeldRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                (if
                      Kartenkoordinatenberechnungssystem'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                        then
                  (Kartenkoordinatenberechnungssystem'Result.Waagerechte = KartenKonstanten.LeerWaagerechte
                   and
                     Kartenkoordinatenberechnungssystem'Result.Ebene = KartenKonstanten.LeerEbene)
               )
                and
                  (if
                         Kartenkoordinatenberechnungssystem'Result.Waagerechte = KartenKonstanten.LeerWaagerechte
                           then
                     (Kartenkoordinatenberechnungssystem'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                      and
                        Kartenkoordinatenberechnungssystem'Result.Ebene = KartenKonstanten.LeerEbene)
                  )
                and
                  (if
                         Kartenkoordinatenberechnungssystem'Result.Ebene = KartenKonstanten.LeerEbene
                           then
                     (Kartenkoordinatenberechnungssystem'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                      and
                        Kartenkoordinatenberechnungssystem'Result.Waagerechte = KartenKonstanten.LeerWaagerechte)
                  )
                and
                  Kartenkoordinatenberechnungssystem'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  Kartenkoordinatenberechnungssystem'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
private
   
   type NeueKoordinateArray is array (SystemDatentypen.Task_Enum'Range) of KartenRecords.KartenfeldNaturalRecord;
   NeueKoordinate : NeueKoordinateArray;
   
end KartenkoordinatenberechnungssystemLogik;
