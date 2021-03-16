pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package WerteFestlegen is
   
   procedure KartenfelderBewerten (GenerierungExtern : in Boolean; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) with
     Pre => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

private
   
   type KartenwertArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   Kartenwert : KartenwertArray;

   procedure KartenfelderBewertenKleineSchleife (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) with
     Pre => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure BewertungSelbst (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord; YAchseFeldAufschlagExtern, XAchseFeldAufschlagExtern : in GlobaleDatentypen.KartenfeldPositiv;
                              TeilerExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei) with
     Pre => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and TeilerExtern > 0);

end WerteFestlegen;
