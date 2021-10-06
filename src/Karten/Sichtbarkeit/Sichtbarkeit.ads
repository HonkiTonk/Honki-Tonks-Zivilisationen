pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;

with Karten;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

   procedure SichtbarkeitSetzen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

private

   BereitsGetestet : KartenDatentypen.LoopRangeMinusZweiZuZwei;
   Umgebung : KartenDatentypen.LoopRangeMinusDreiZuDrei;

   SichtweiteObjekt : KartenDatentypen.Sichtweite;

   AktuellerGrund : KartenDatentypen.Karten_Grund_Alle_Felder_Enum;

   Wert : Integer;

   FremdeEinheitStadt : EinheitStadtRecords.RassePlatznummerRecord;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenQuadrantWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenBlockadeWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KoordinatenEinheit : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

   procedure QuadrantenDurchlaufen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure QuadrantEins
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantZwei
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantDrei
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);

   procedure QuadrantVier
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite);



   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.Sichtweite
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern : in KartenDatentypen.LoopRangeMinusZweiZuZwei;
      XÄnderungExtern : in KartenDatentypen.LoopRangeMinusZweiZuZwei;
      SichtweiteExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end Sichtbarkeit;
