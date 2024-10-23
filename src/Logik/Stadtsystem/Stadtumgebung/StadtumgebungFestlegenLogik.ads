with SpeziesDatentypen;
with StadtKonstanten;
with StadtRecords;
with StadtDatentypen;
with KartenDatentypen;

private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package StadtumgebungFestlegenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type StadtDatentypen.Einwohner;
   
   procedure StadtumgebungFestlegenTechnologie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure StadtumgebungFestlegen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   GrundBelegbar : Boolean;
   
   GrößeAlt : KartenRecords.UmgebungDreiRecord;
   GrößeNeu : KartenRecords.UmgebungDreiRecord;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   UmgebendesKartenwert : KartenRecords.KartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.KartenfeldNaturalRecord;
   BelegungKartenwert : KartenRecords.KartenfeldNaturalRecord;
   
   procedure GrundBelegen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure UmgebendeStädteAnpassen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrößeAltExtern : in KartenRecords.UmgebungDreiRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end StadtumgebungFestlegenLogik;
