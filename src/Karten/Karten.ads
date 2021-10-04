pragma SPARK_Mode (On);

with KartenRecords, KartenKonstanten, KartenDatentypen;

package Karten is

   type WeltkarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of KartenRecords.KartenRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => KartenKonstanten.LeerWeltkarte)));

   type StadtkarteArray is array (KartenDatentypen.Stadtfeld'Range, KartenDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : KartenDatentypen.KartenfeldPositiv;
      XAchsenGröße : KartenDatentypen.KartenfeldPositiv;

   end record;

   type KartengrößenArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := (
                                            KartenDatentypen.Karte_20_20     => (20, 20),
                                            KartenDatentypen.Karte_40_40     => (40, 40),
                                            KartenDatentypen.Karte_80_80     => (80, 80),
                                            KartenDatentypen.Karte_120_80    => (120, 80),
                                            KartenDatentypen.Karte_120_160   => (120, 160),
                                            KartenDatentypen.Karte_160_160   => (160, 160),
                                            KartenDatentypen.Karte_240_240   => (240, 240),
                                            KartenDatentypen.Karte_320_320   => (320, 320),
                                            KartenDatentypen.Karte_1000_1000 => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                            KartenDatentypen.Karte_Nutzer    => (KartenDatentypen.KartenfeldPositiv'First, KartenDatentypen.KartenfeldPositiv'First)
                                           );

   Kartengröße : KartenDatentypen.Kartengröße_Verwendet_Enum;

   type LandartenRecord is record

      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;

   end record;

   -- Inseln, Kontinente, Pangäa
   -- Alle Größen- und Abstandsangaben sind Radien.
   type GrößeLandartArray is array (KartenDatentypen.Kartenart_Verwendet_Enum'Range) of LandartenRecord;
   GrößeLandart : GrößeLandartArray := (
                                            KartenDatentypen.Inseln     => (3, 3),
                                            KartenDatentypen.Kontinente => (7, 7),
                                            KartenDatentypen.Pangäa     => (1, 1),
                                            others                       => (1, 1)
                                           );
   FelderVonLandartZuLandart : GrößeLandartArray := (
                                                       KartenDatentypen.Inseln     => (15, 15),
                                                       KartenDatentypen.Kontinente => (22, 22),
                                                       KartenDatentypen.Pangäa     => (1, 1),
                                                       others                       => (1, 1)
                                                      );

   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   Kartenart : KartenDatentypen.Kartenart_Verwendet_Enum := KartenDatentypen.Inseln;
   KartenartGemischt : Boolean := False;
   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   Kartentemperatur : KartenDatentypen.Kartentemperatur_Verwendet_Enum := KartenDatentypen.Kalt;
   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht
   Kartenform : KartenDatentypen.Kartenform_Verwendet_Enum := KartenDatentypen.X_Zylinder;
   -- Arm, Wenig, Mittel, Viel, Überfluss
   Kartenressourcen : KartenDatentypen.Karten_Ressourcen_Reichtum_Verwendet_Enum := KartenDatentypen.Mittel;

   type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of KartenDatentypen.Karten_Grund_Enum;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

end Karten;
