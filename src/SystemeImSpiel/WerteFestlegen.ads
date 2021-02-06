pragma SPARK_Mode (On);

with GlobaleDatentypen, Karten, GlobaleRecords;
use GlobaleDatentypen;

package WerteFestlegen is
   
   procedure KartenfelderBewerten (Generierung : Boolean; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

private
   
   type KartenwertArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of GlobaleRecords.AchsenAusKartenfeldRecord;
   Kartenwert : KartenwertArray;

   procedure KartenfelderBewertenKleineSchleife (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure BewertungSelbst (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord; YAchseFeldAufschlag, XAchseFeldAufschlag : GlobaleDatentypen.KartenfeldPositiv;
                              Teiler : GlobaleDatentypen.LoopRangeMinusDreiZuDrei) with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

end WerteFestlegen;
