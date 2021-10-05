pragma SPARK_Mode (On);

with KartenRecords, KartenDatentypen, SonstigeDatentypen;
use KartenDatentypen;

with Karten;

package FelderwerteFestlegen is
   
   procedure EinzelnesKartenfeldBewerten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure KartenfelderBewertenKleineSchleife
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
private
      
   type KartenwertArray is array (KartenDatentypen.EbeneVorhanden'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertEins : KartenwertArray;
   KartenWertZwei : KartenwertArray;
   
   procedure BewertungSelbst
     (KoordinatenFeldExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      KoordinatenUmgebungExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Enum;
      TeilerExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei)
     with
       Pre =>
         (KoordinatenFeldExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenFeldExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            TeilerExtern > 0);

end FelderwerteFestlegen;
