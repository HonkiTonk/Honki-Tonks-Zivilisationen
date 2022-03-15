pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenEinstellungenKonstanten;
with KartenRecordKonstanten;
with KartenGrundDatentypen;

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
                                            KartenEinstellungenKonstanten.Kartengröße2020Konstante     => (20, 20),
                                            KartenEinstellungenKonstanten.Kartengröße4040Konstante     => (40, 40),
                                            KartenEinstellungenKonstanten.Kartengröße8080Konstante     => (80, 80),
                                            KartenEinstellungenKonstanten.Kartengröße12080Konstante    => (120, 80),
                                            KartenEinstellungenKonstanten.Kartengröße120160Konstante   => (120, 160),
                                            KartenEinstellungenKonstanten.Kartengröße160160Konstante   => (160, 160),
                                            KartenEinstellungenKonstanten.Kartengröße240240Konstante   => (240, 240),
                                            KartenEinstellungenKonstanten.Kartengröße320320Konstante   => (320, 320),
                                            KartenEinstellungenKonstanten.Kartengröße10001000Konstante => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                            KartenEinstellungenKonstanten.KartengrößeNutzerKonstante   => (KartenDatentypen.KartenfeldPositiv'First, KartenDatentypen.KartenfeldPositiv'First)
                                           );

   -- Muss einen Startwert haben damit der Grafiktask die Kartenfelder korrekt berechnen kann.
   Kartengröße : KartenDatentypen.Kartengröße_Enum := KartenEinstellungenKonstanten.Kartengröße2020Konstante;

   type LandartenRecord is record

      YAchse : KartenDatentypen.KartenfeldPositiv;
      XAchse : KartenDatentypen.KartenfeldPositiv;

   end record;

   -- Inseln, Kontinente, Pangäa
   -- Alle Größen- und Abstandsangaben sind Radien.
   type GrößeLandartArray is array (KartenDatentypen.Kartenart_Verwendet_Enum'Range) of LandartenRecord;
   GrößeLandart : GrößeLandartArray := (
                                            KartenEinstellungenKonstanten.KartenartInselnKonstante     => (3, 3),
                                            KartenEinstellungenKonstanten.KartenartKontinenteKonstante => (7, 7),
                                            KartenEinstellungenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                            others                                                     => (1, 1)
                                           );
   FelderVonLandartZuLandart : GrößeLandartArray := (
                                                       KartenEinstellungenKonstanten.KartenartInselnKonstante     => (15, 15),
                                                       KartenEinstellungenKonstanten.KartenartKontinenteKonstante => (22, 22),
                                                       KartenEinstellungenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                                       others                                                     => (1, 1)
                                                      );

   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   Kartenart : KartenDatentypen.Kartenart_Verwendet_Enum := KartenEinstellungenKonstanten.KartenartInselnKonstante;
   KartenartGemischt : Boolean := False;

   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   Kartentemperatur : KartenDatentypen.Kartentemperatur_Verwendet_Enum := KartenEinstellungenKonstanten.TemperaturKaltKonstante;

   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht
   Kartenform : KartenDatentypen.Kartenform_Verwendet_Enum := KartenEinstellungenKonstanten.KartenformXZylinderKonstante;

   -- EAchsenübergang, YAchsenübergang, XAchsenübergang
   KartenformEingestellt : KartenRecords.KartenformRecord := KartenRecordKonstanten.KartenformStandard;

   -- Arm, Wenig, Mittel, Viel, Überfluss
   Kartenressourcen : KartenDatentypen.Kartenressourcen_Verwendet_Enum := KartenEinstellungenKonstanten.RessourcenMittelKonstante;

   type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of KartenGrundDatentypen.Karten_Grund_Enum;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

end Karten;
