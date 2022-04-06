pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with KartenGrundDatentypen;
with SystemDatentypen;

package Karten is

   type WeltkarteArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of KartenRecords.KartenRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => KartenRecordKonstanten.LeerWeltkarte)));

   type StadtkarteArray is array (KartenDatentypen.Stadtfeld'Range, KartenDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : KartenDatentypen.KartenfeldPositiv;
      XAchsenGröße : KartenDatentypen.KartenfeldPositiv;

   end record;

   -- Wenn man das um die EAchse erweitert, dann könnte man auch die Anzahl der Ebenen vom Spieler bestimmen lassen. Mal drüber nachdenken. -------------------
   type KartengrößenArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := (
                                            SystemDatentypen.Karte_Größe_20_20_Enum     => (20, 20),
                                            SystemDatentypen.Karte_Größe_40_40_Enum     => (40, 40),
                                            SystemDatentypen.Karte_Größe_80_80_Enum     => (80, 80),
                                            SystemDatentypen.Karte_Größe_120_80_Enum    => (120, 80),
                                            SystemDatentypen.Karte_Größe_120_160_Enum   => (120, 160),
                                            SystemDatentypen.Karte_Größe_160_160_Enum   => (160, 160),
                                            SystemDatentypen.Karte_Größe_240_240_Enum   => (240, 240),
                                            SystemDatentypen.Karte_Größe_320_320_Enum   => (320, 320),
                                            SystemDatentypen.Karte_Größe_1000_1000_Enum => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                            SystemDatentypen.Karte_Größe_Nutzer_Enum    => (KartenDatentypen.KartenfeldPositiv'First, KartenDatentypen.KartenfeldPositiv'First)
                                           );

   type LandartenRecord is record

      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;

   end record;

   -- Inseln, Kontinente, Pangäa
   -- Alle Größen- und Abstandsangaben sind Radien.
   -- Später über einen Editor oder direkt im Kartengenerator änderbar machen? Möglicherweise die aktuelle Kartenart durch vorgegebene Werte und Nutzereingaben ersetzen?
   type GrößeLandartArray is array (KartenDatentypen.Kartenart_Verwendet_Enum'Range) of LandartenRecord;
   GrößeLandart : GrößeLandartArray := (
                                            SystemDatentypen.Karte_Art_Inseln_Enum     => (3, 3),
                                            SystemDatentypen.Karte_Art_Kontinente_Enum => (7, 7),
                                            SystemDatentypen.Karte_Art_Pangäa_Enum     => (1, 1),
                                            others                                     => (1, 1)
                                           );
   FelderVonLandartZuLandart : GrößeLandartArray := (
                                                       SystemDatentypen.Karte_Art_Inseln_Enum     => (15, 15),
                                                       SystemDatentypen.Karte_Art_Kontinente_Enum => (22, 22),
                                                       SystemDatentypen.Karte_Art_Pangäa_Enum     => (1, 1),
                                                       others                                     => (1, 1)
                                                      );

   Kartenparameter : KartenRecords.KartenparameterRecord := (
                                                             Kartengröße      => SystemDatentypen.Karte_Größe_20_20_Enum,

                                                             -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
                                                             Kartenart        => SystemDatentypen.Karte_Art_Inseln_Enum,

                                                             -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
                                                             Kartentemperatur => SystemDatentypen.Karte_Temperatur_Kalt_Enum,

                                                             -- Arm, Wenig, Mittel, Viel, Überfluss
                                                             Kartenressourcen => SystemDatentypen.Karte_Ressource_Mittel_Enum,

                                                             Kartenpole       => SystemDatentypen.Karten_Pole_YAchse,

                                                             -- EAchsenübergang, YAchsenübergang, XAchsenübergang
                                                             Kartenform       => KartenRecordKonstanten.KartenformStandard
                                                            );

   -- Später mehrere Kartenarten mischbar machen, das aber vielleicht nicht über einen Bool.
   -- Eventuell mehrere Kartenarten aktivierbar machen wie bei der Kartenform? Eventuell ein kompakteres System bauen.
   KartenartGemischt : Boolean := False;

   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht
   Kartenform : KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_X_Zylinder_Enum;

   type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of KartenGrundDatentypen.Karten_Grund_Enum;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

end Karten;
