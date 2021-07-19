pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   procedure SichtbarkeitsprüfungFürEinheitNeu
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

private

   SichtweiteObjekt : GlobaleDatentypen.Sichtweite;
   BereitsGetestet : GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
   Umgebung : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   AktuellerGrund : GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum;

   Wert : Integer;

   FremdeEinheitStadt : GlobaleRecords.RassePlatznummerRecord;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   type SichtbarkeitRecord is new GlobaleRecords.AchsenKartenfeldPositivRecord with record

      Bewertung : Integer;

   end record;

   type SichtbarkeitUmgebungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of SichtbarkeitRecord;
   SichtbarkeitUmgebung : SichtbarkeitUmgebungArray;

   procedure SichtbarkeitSetzen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

end Sichtbarkeit;
