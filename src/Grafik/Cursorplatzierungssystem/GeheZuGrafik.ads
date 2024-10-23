with SpeziesDatentypen;

private with KartenRecords;
private with KartenDatentypen;

with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package GeheZuGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure GeheZuFestlegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   AktuelleSichtweite : KartenRecords.KartenfeldumgebungPositivRecord;
   
   SenkrechteÜbergänge : KartenRecords.KartenformSenkrechteRecord;
   WaagerechteÜbergänge : KartenRecords.KartenformWaagerechteRecord;
   
   Kartenwert : KartenRecords.KartenfeldNaturalRecord;
   KartenwertKoordinatenberechnung : KartenRecords.KartenfeldNaturalRecord;
   
   
   
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              ),
         
       Post => (
                  Koordinatenberechnung'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  Koordinatenberechnung'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

end GeheZuGrafik;
