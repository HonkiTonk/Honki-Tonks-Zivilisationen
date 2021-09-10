pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package FelderwerteFestlegen is
   
   procedure EinzelnesKartenfeldBewerten
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure KartenfelderBewertenKleineSchleife 
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
private
      
   type KartenwertArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertEins : KartenwertArray;
   KartenWertZwei : KartenwertArray;
   
   procedure BewertungSelbst
     (KoordinatenFeldExtern, KoordinatenUmgebungExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Enum;
      TeilerExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
     with
       Pre =>
         (KoordinatenFeldExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenFeldExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            TeilerExtern > 0);

end FelderwerteFestlegen;
