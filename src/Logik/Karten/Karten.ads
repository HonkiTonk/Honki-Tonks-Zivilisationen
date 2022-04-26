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

   -- Alle Größen- und Abstandsangaben sind Radien.
   ------------------------ Später über einen Editor oder direkt im Kartengenerator änderbar machen? Möglicherweise die aktuelle Kartenart durch vorgegebene Werte und Nutzereingaben ersetzen?
   type LandflächenArray is array (KartenDatentypen.Kartenart_Enum'Range) of KartenRecords.YXAchsenKartenfeldPositivRecord;
   GrößeLandfläche : LandflächenArray := (
                                              KartenDatentypen.Kartenart_Inseln_Enum     => (3, 3),
                                              KartenDatentypen.Kartenart_Kontinente_Enum => (7, 7),
                                              KartenDatentypen.Kartenart_Pangäa_Enum     => (1, 1),
                                              others                                     => (1, 1)
                                             );
   AbstandLandflächen : LandflächenArray := (
                                               KartenDatentypen.Kartenart_Inseln_Enum     => (15, 15),
                                               KartenDatentypen.Kartenart_Kontinente_Enum => (22, 22),
                                               KartenDatentypen.Kartenart_Pangäa_Enum     => (1, 1),
                                               others                                     => (1, 1)
                                              );

   Kartenparameter : KartenRecords.KartenparameterRecord := KartenRecordKonstanten.KartenparameterStandard;

   ---------------------- Später mehrere Kartenarten mischbar machen, das aber vielleicht nicht über einen Bool.
   ---------------------- Eventuell mehrere Kartenarten aktivierbar machen wie bei der Kartenform? Eventuell ein kompakteres System bauen.
   ---------------------- Vielleicht verschiedene Werte einstellbar machen und dann daraus zufällig einen ziehen?

end Karten;
