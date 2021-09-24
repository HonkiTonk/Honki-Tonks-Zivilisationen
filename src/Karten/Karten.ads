pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten, KartenRecords;
use GlobaleDatentypen;

package Karten is

   type WeltkarteArray is array (GlobaleDatentypen.EbeneVorhanden'Range, GlobaleDatentypen.KartenfeldPositiv'Range, GlobaleDatentypen.KartenfeldPositiv'Range) of KartenRecords.KartenRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => GlobaleKonstanten.LeerWeltkarte)));

   type StadtkarteArray is array (GlobaleDatentypen.Stadtfeld'Range, GlobaleDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      XAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;

   end record;

   type KartengrößenArray is array (GlobaleDatentypen.Kartengröße_Verwendet_Enum'Range) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := (
                                            GlobaleDatentypen.Karte_20_20     => (20, 20),
                                            GlobaleDatentypen.Karte_40_40     => (40, 40),
                                            GlobaleDatentypen.Karte_80_80     => (80, 80),
                                            GlobaleDatentypen.Karte_120_80    => (120, 80),
                                            GlobaleDatentypen.Karte_120_160   => (120, 160),
                                            GlobaleDatentypen.Karte_160_160   => (160, 160),
                                            GlobaleDatentypen.Karte_240_240   => (240, 240),
                                            GlobaleDatentypen.Karte_320_320   => (320, 320),
                                            GlobaleDatentypen.Karte_1000_1000 => (GlobaleDatentypen.KartenfeldPositiv'Last, GlobaleDatentypen.KartenfeldPositiv'Last),
                                            GlobaleDatentypen.Karte_Nutzer    => (GlobaleDatentypen.KartenfeldPositiv'First, GlobaleDatentypen.KartenfeldPositiv'First)
                                           );

   Kartengröße : GlobaleDatentypen.Kartengröße_Verwendet_Enum;

   type LandartenRecord is record

      YAchse : GlobaleDatentypen.KartenfeldPositiv;
      XAchse : GlobaleDatentypen.KartenfeldPositiv;

   end record;

   -- Inseln, Kontinente, Pangäa
   -- Alle Größen- und Abstandsangaben sind Radien.
   type GrößeLandartArray is array (GlobaleDatentypen.Kartenart_Verwendet_Enum'Range) of LandartenRecord;
   GrößeLandart : GrößeLandartArray := (
                                            GlobaleDatentypen.Inseln     => (3, 3),
                                            GlobaleDatentypen.Kontinente => (7, 7),
                                            GlobaleDatentypen.Pangäa     => (1, 1),
                                            others                       => (1, 1)
                                           );
   FelderVonLandartZuLandart : GrößeLandartArray := (
                                                       GlobaleDatentypen.Inseln     => (15, 15),
                                                       GlobaleDatentypen.Kontinente => (22, 22),
                                                       GlobaleDatentypen.Pangäa     => (1, 1),
                                                       others                       => (1, 1)
                                                      );

   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   Kartenart : GlobaleDatentypen.Kartenart_Verwendet_Enum := GlobaleDatentypen.Inseln;
   KartenartGemischt : Boolean := False;
   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   Kartentemperatur : GlobaleDatentypen.Kartentemperatur_Verwendet_Enum := GlobaleDatentypen.Kalt;
   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht
   Kartenform : GlobaleDatentypen.Kartenform_Verwendet_Enum := GlobaleDatentypen.X_Zylinder;
   -- Arm, Wenig, Mittel, Viel, Überfluss
   Kartenressourcen : GlobaleDatentypen.Karten_Ressourcen_Reichtum_Verwendet_Enum := GlobaleDatentypen.Mittel;

   type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of GlobaleDatentypen.Karten_Grund_Enum;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

end Karten;
