with SpeziesDatentypen;
with StadtKonstanten;
with StadtRecords;
with ProduktionDatentypen;
with KartenDatentypen;

private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package StadtumgebungFestlegenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type ProduktionDatentypen.Einwohner;
   
   procedure StadtumgebungFestlegenTechnologie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
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
   use type KartenDatentypen.Kartenfeld;
   
   GrundBelegbar : Boolean;
   
   GrößeAlt : KartenDatentypen.UmgebungsbereichDrei;
   GrößeNeu : KartenDatentypen.UmgebungsbereichDrei;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   UmgebendesKartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   BelegungKartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure GrundBelegen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure UmgebendeStädteAnpassen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrößeAltExtern : in KartenDatentypen.UmgebungsbereichDrei)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end StadtumgebungFestlegenLogik;
