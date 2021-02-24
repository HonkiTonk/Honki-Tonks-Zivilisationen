pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package WerteFestlegen is
   
   procedure KartenfelderBewerten (Generierung : Boolean; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

private
   
   type KartenwertArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   Kartenwert : KartenwertArray;

   procedure KartenfelderBewertenKleineSchleife (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure BewertungSelbst (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord; YAchseFeldAufschlag, XAchseFeldAufschlag : GlobaleDatentypen.KartenfeldPositiv;
                              Teiler : GlobaleDatentypen.LoopRangeMinusDreiZuDrei) with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

end WerteFestlegen;
