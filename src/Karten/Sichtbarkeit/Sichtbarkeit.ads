pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

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

private

   BereitsGetestet : GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
   Umgebung : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   SichtweiteObjekt : GlobaleDatentypen.Sichtweite;

   AktuellerGrund : GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum;

   Wert : Integer;

   FremdeEinheitStadt : GlobaleRecords.RassePlatznummerRecord;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenQuadrantWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenBlockadeWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KoordinatenEinheit : GlobaleRecords.AchsenKartenfeldPositivRecord;

   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteExtern : in GlobaleDatentypen.Sichtweite)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   procedure QuadrantenDurchlaufen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

   procedure QuadrantEins
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite);

   procedure QuadrantZwei
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite);

   procedure QuadrantDrei
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite);

   procedure QuadrantVier
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite);



   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Sichtweite
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
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
