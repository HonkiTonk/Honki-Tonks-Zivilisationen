pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Karten;

package KartenpoleKorrigieren is

   function KartenpoleKorrigieren
     return KartenRecords.KartenpoleKorrekturRecord
     with
       Post =>
         (KartenpoleKorrigieren'Result.Norden <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße / 2
          and
            KartenpoleKorrigieren'Result.Süden <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße / 2
          and
            KartenpoleKorrigieren'Result.Westen <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße / 2
          and
            KartenpoleKorrigieren'Result.Osten <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße / 2);
   
private
   
   SchleifenkorrekturNorden : KartenDatentypen.KartenfeldPositivMitNullwert;
   SchleifenkorrekturSüden : KartenDatentypen.KartenfeldPositivMitNullwert;
   SchleifenkorrekturWesten : KartenDatentypen.KartenfeldPositivMitNullwert;
   SchleifenkorrekturOsten : KartenDatentypen.KartenfeldPositivMitNullwert;

end KartenpoleKorrigieren;
