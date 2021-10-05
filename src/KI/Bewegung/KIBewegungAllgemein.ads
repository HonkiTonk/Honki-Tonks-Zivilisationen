pragma SPARK_Mode (On);

with EinheitStadtRecords, KartenDatentypen, GlobaleVariablen, KartenRecords, SonstigeDatentypen;
use SonstigeDatentypen, KartenDatentypen;

with Karten;

package KIBewegungAllgemein is
   
   function FeldBetreten
     (FeldPositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.LoopRangeMinusEinsZuEins
     with
       Pre =>
         (FeldPositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            FeldPositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
private

   BlockierendeEinheit : SonstigeDatentypen.Rassen_Enum;
   BlockierendeStadt : SonstigeDatentypen.Rassen_Enum;
   
   function FeldAngreifen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     return KartenDatentypen.LoopRangeMinusEinsZuEins;

end KIBewegungAllgemein;
