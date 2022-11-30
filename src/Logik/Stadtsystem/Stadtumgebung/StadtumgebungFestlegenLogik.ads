with RassenDatentypen;
with StadtKonstanten;
with StadtRecords;
with ProduktionDatentypen;
with KartenDatentypen;

private with KartenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

private with LeseWeltkarteneinstellungen;

package StadtumgebungFestlegenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type ProduktionDatentypen.Einwohner;
   
   procedure StadtumgebungFestlegenTechnologie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure StadtumgebungFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
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
