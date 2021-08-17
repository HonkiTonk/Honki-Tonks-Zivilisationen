pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package LeseKarten is

   function Grund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (Grund'Result not in GlobaleDatentypen.Karten_Fluss_Enum'Range);
   
   function Hügel
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function Sichtbar
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function Fluss
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (Fluss'Result in GlobaleDatentypen.Karten_Fluss_Enum'Range
            or
              Fluss'Result = GlobaleDatentypen.Leer);

   function VerbesserungWeg
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (VerbesserungWeg'Result in GlobaleDatentypen.Karten_Weg_Enum'Range
            or
              VerbesserungWeg'Result = GlobaleDatentypen.Leer);

   function VerbesserungGebiet
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (VerbesserungGebiet'Result = GlobaleDatentypen.Leer
            or
              VerbesserungGebiet'Result in Karten_Verbesserung_Gebilde_Enum'Range);

   function Ressource
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (Ressource'Result = GlobaleDatentypen.Leer
            or
              Ressource'Result in GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range);

   function Bewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function BelegterGrund
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function BelegterGrundLeer
     (KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

end LeseKarten;
