pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with KartenRecords;
with SystemKonstanten;

package KarteKonsole is

   procedure AnzeigeKarteKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);
   
private

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld);

end KarteKonsole;
