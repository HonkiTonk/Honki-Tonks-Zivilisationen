pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;

package Karten is

   ----------------------- Später die Anzahl der Ebenen auch vom Nutzer einstellbar machen.
   type WeltkarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of KartenRecords.KartenRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => KartenRecordKonstanten.LeerWeltkarte)));

   type StadtkarteArray is array (KartenDatentypen.Stadtfeld'Range, KartenDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   ------------------- Wenn man das um die EAchse erweitert, dann könnte man auch die Anzahl der Ebenen vom Spieler bestimmen lassen.
   ------------------- Besser aber nicht hier einbauen, sonst ergibt das zu viele Fälle. Wobei es ja nur den Fall Nutzer und Zufall (was ja auch wieder Nutzer ist) gibt. Alle anderen wären dann einfach fünf.
   type KartengrößenArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range) of KartenRecords.YXAchsenKartenfeldPositivRecord;
   Kartengrößen : KartengrößenArray := (
                                            KartenDatentypen.Kartengröße_20_20_Enum     => (20, 20),
                                            KartenDatentypen.Kartengröße_40_40_Enum     => (40, 40),
                                            KartenDatentypen.Kartengröße_80_80_Enum     => (80, 80),
                                            KartenDatentypen.Kartengröße_120_80_Enum    => (120, 80),
                                            KartenDatentypen.Kartengröße_120_160_Enum   => (120, 160),
                                            KartenDatentypen.Kartengröße_160_160_Enum   => (160, 160),
                                            KartenDatentypen.Kartengröße_240_240_Enum   => (240, 240),
                                            KartenDatentypen.Kartengröße_320_320_Enum   => (320, 320),
                                            KartenDatentypen.Kartengröße_1000_1000_Enum => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                            KartenDatentypen.Kartengröße_Nutzer_Enum    => (KartenDatentypen.KartenfeldPositiv'First, KartenDatentypen.KartenfeldPositiv'First)
                                           );

   -------------------------------- In zwei Teile aufteilen, einen der gespeichert werden muss und einer der nach der Kartengenerierung egal ist.
   Kartenparameter : KartenRecords.KartenparameterRecord := KartenRecordKonstanten.KartenparameterStandard;

   Polgrößen : KartenDatentypen.PolregionenArray := KartenRecordKonstanten.Eisrand;
   Eisschild : KartenDatentypen.PolregionenArray := KartenRecordKonstanten.Eisschild;

   -- False ist Minimum, True ist Maximum.
   -- Alle Angaben sind Radien.
   type AngabenArray is array (Boolean'Range) of KartenRecords.YXAchsenKartenfeldPositivRecord;
   Landgrößen : AngabenArray := (
                                   False => (3, 6),
                                   True  => (3, 6)
                                  );

   Abstände : AngabenArray := (
                                False => (3, 6),
                                True  => (3, 6)
                               );

end Karten;
