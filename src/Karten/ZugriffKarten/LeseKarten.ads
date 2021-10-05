pragma SPARK_Mode (On);

with GlobaleVariablen, KartenRecords, EinheitStadtRecords, KartenDatentypen, SonstigeDatentypen, EinheitStadtDatentypen;
use SonstigeDatentypen;

with Karten;

package LeseKarten is

   function Grund
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Grund_Enum
     with
       Pre =>
         (PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (Grund'Result not in KartenDatentypen.Karten_Fluss_Enum'Range);
   
   function Hügel
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function Sichtbar
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer
          and
            PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function Fluss
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Grund_Enum
     with
       Pre =>
         (PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function VerbesserungWeg
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Verbesserung_Enum
     with
       Pre =>
         (PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function VerbesserungGebiet
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Verbesserung_Enum
     with
       Pre =>
         (PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function Ressource
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Grund_Enum
     with
       Pre =>
         (PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function Bewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function BelegterGrund
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer
          and
            KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function BelegterGrundLeer
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end LeseKarten;
