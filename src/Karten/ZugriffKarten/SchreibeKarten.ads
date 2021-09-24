pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, KartenRecords;
use GlobaleDatentypen;

with Karten;

package SchreibeKarten is

   procedure Grund
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GrundExtern /= GlobaleDatentypen.Leer);
   
   procedure Hügel
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      HügelExtern : in Boolean)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure Sichtbar
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure Fluss
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      FlussExtern : in GlobaleDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            (FlussExtern = GlobaleDatentypen.Leer
             or
               FlussExtern in GlobaleDatentypen.Karten_Fluss_Enum));

   procedure VerbesserungWeg
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      WegExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            (WegExtern = GlobaleDatentypen.Leer
             or
               WegExtern in GlobaleDatentypen.Karten_Weg_Enum));

   procedure VerbesserungGebiet
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            VerbesserungExtern not in GlobaleDatentypen.Karten_Weg_Enum);

   procedure Ressource
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RessourceExtern : in GlobaleDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            RessourceExtern in GlobaleDatentypen.Karten_Grund_Ressourcen_Enum);

   procedure BelegterGrund
     (PositionExtern : KartenRecords.AchsenKartenfeldPositivRecord;
      BelegterGrundExtern : in GlobaleDatentypen.BelegterGrund)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure Bewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end SchreibeKarten;
