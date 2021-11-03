pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;

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
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_KI);
   
private

   BlockierendeEinheit : SystemDatentypen.Rassen_Enum;
   BlockierendeStadt : SystemDatentypen.Rassen_Enum;
   
   function FeldAngreifen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     return KartenDatentypen.LoopRangeMinusEinsZuEins;

end KIBewegungAllgemein;
