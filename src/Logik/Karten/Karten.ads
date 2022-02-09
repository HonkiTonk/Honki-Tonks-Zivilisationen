pragma SPARK_Mode (On);

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
                                            KartenKonstanten.Kartengröße2020Konstante     => (20, 20),
                                            KartenKonstanten.Kartengröße4040Konstante     => (40, 40),
                                            KartenKonstanten.Kartengröße8080Konstante     => (80, 80),
                                            KartenKonstanten.Kartengröße12080Konstante    => (120, 80),
                                            KartenKonstanten.Kartengröße120160Konstante   => (120, 160),
                                            KartenKonstanten.Kartengröße160160Konstante   => (160, 160),
                                            KartenKonstanten.Kartengröße240240Konstante   => (240, 240),
                                            KartenKonstanten.Kartengröße320320Konstante   => (320, 320),
                                            KartenKonstanten.Kartengröße10001000Konstante => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                            KartenKonstanten.KartengrößeNutzerKonstante   => (KartenDatentypen.KartenfeldPositiv'First, KartenDatentypen.KartenfeldPositiv'First)
                                           );

   -- Muss einen Startwert haben damit der Grafiktask die Kartenfelder korrekt berechnen kann.
   Kartengröße : KartenDatentypen.Kartengröße_Enum := KartenKonstanten.Kartengröße2020Konstante;

   type LandartenRecord is record

      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;

   end record;

   -- Inseln, Kontinente, Pangäa
   -- Alle Größen- und Abstandsangaben sind Radien.
   type GrößeLandartArray is array (KartenDatentypen.Kartenart_Verwendet_Enum'Range) of LandartenRecord;
   GrößeLandart : GrößeLandartArray := (
                                            KartenKonstanten.KartenartInselnKonstante     => (3, 3),
                                            KartenKonstanten.KartenartKontinenteKonstante => (7, 7),
                                            KartenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                            others                                        => (1, 1)
                                           );
   FelderVonLandartZuLandart : GrößeLandartArray := (
                                                       KartenKonstanten.KartenartInselnKonstante     => (15, 15),
                                                       KartenKonstanten.KartenartKontinenteKonstante => (22, 22),
                                                       KartenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                                       others                                        => (1, 1)
                                                      );

   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   Kartenart : KartenDatentypen.Kartenart_Verwendet_Enum := KartenKonstanten.KartenartInselnKonstante;
   KartenartGemischt : Boolean := False;

   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   Kartentemperatur : KartenDatentypen.Kartentemperatur_Verwendet_Enum := KartenKonstanten.TemperaturKaltKonstante;

   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht
   Kartenform : KartenDatentypen.Kartenform_Verwendet_Enum := KartenKonstanten.KartenformXZylinderKonstante;

   -- EAchsenübergang, YAchsenübergang, XAchsenübergang
   KartenformEingestellt : KartenRecords.KartenformRecord := KartenKonstanten.KartenformStandard;

   -- Arm, Wenig, Mittel, Viel, Überfluss
   Kartenressourcen : KartenDatentypen.Kartenressourcen_Verwendet_Enum := KartenKonstanten.RessourcenMittelKonstante;

   type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of KartenDatentypen.Karten_Grund_Enum;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

end Karten;
