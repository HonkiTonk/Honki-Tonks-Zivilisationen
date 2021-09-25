pragma SPARK_Mode (On);

with GlobaleDatentypen, EinheitStadtRecords, GlobaleVariablen, KartenRecords;
use GlobaleDatentypen;

with Karten;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   procedure SichtbarkeitSetzen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

private

   BereitsGetestet : GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
   Umgebung : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   SichtweiteObjekt : GlobaleDatentypen.Sichtweite;

   AktuellerGrund : GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum;

   Wert : Integer;

   FremdeEinheitStadt : EinheitStadtRecords.RassePlatznummerRecord;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenQuadrantWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenBlockadeWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KoordinatenEinheit : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteExtern : in GlobaleDatentypen.Sichtweite)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   procedure QuadrantenDurchlaufen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure QuadrantEins
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite);

   procedure QuadrantZwei
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite);

   procedure QuadrantDrei
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite);

   procedure QuadrantVier
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite);



   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Sichtweite
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern : in GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
      XÄnderungExtern : in GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
      SichtweiteExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end Sichtbarkeit;
