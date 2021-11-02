pragma SPARK_Mode (On);

with SystemDatentypen;
with KartenRecords;
with KartenKonstanten;
with KartenDatentypen;

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
                                            SystemDatentypen.Karte_Größe_20_20     => (20, 20),
                                            SystemDatentypen.Karte_Größe_40_40     => (40, 40),
                                            SystemDatentypen.Karte_Größe_80_80     => (80, 80),
                                            SystemDatentypen.Karte_Größe_120_80    => (120, 80),
                                            SystemDatentypen.Karte_Größe_120_160   => (120, 160),
                                            SystemDatentypen.Karte_Größe_160_160   => (160, 160),
                                            SystemDatentypen.Karte_Größe_240_240   => (240, 240),
                                            SystemDatentypen.Karte_Größe_320_320   => (320, 320),
                                            SystemDatentypen.Karte_Größe_1000_1000 => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                            SystemDatentypen.Karte_Größe_Nutzer    => (KartenDatentypen.KartenfeldPositiv'First, KartenDatentypen.KartenfeldPositiv'First)
                                           );

   Kartengröße : KartenDatentypen.Kartengröße_Enum;

   type LandartenRecord is record

      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;

   end record;

   -- Inseln, Kontinente, Pangäa
   -- Alle Größen- und Abstandsangaben sind Radien.
   type GrößeLandartArray is array (KartenDatentypen.Kartenart_Verwendet_Enum'Range) of LandartenRecord;
   GrößeLandart : GrößeLandartArray := (
                                            SystemDatentypen.Karte_Art_Inseln     => (3, 3),
                                            SystemDatentypen.Karte_Art_Kontinente => (7, 7),
                                            SystemDatentypen.Karte_Art_Pangäa     => (1, 1),
                                            others                       => (1, 1)
                                           );
   FelderVonLandartZuLandart : GrößeLandartArray := (
                                                       SystemDatentypen.Karte_Art_Inseln     => (15, 15),
                                                       SystemDatentypen.Karte_Art_Kontinente => (22, 22),
                                                       SystemDatentypen.Karte_Art_Pangäa     => (1, 1),
                                                       others                       => (1, 1)
                                                      );

   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   Kartenart : KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Inseln;
   KartenartGemischt : Boolean := False;
   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   Kartentemperatur : KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Kalt;
   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht
   Kartenform : KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_X_Zylinder;
   -- Arm, Wenig, Mittel, Viel, Überfluss
   Kartenressourcen : KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Mittel;

   type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of KartenDatentypen.Karten_Grund_Enum;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

end Karten;
