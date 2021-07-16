pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleKonstanten;
use GlobaleDatentypen;

package Karten is

   type WeltkarteArray is array (GlobaleDatentypen.EbeneVorhanden'Range, GlobaleDatentypen.KartenfeldPositiv'Range, GlobaleDatentypen.KartenfeldPositiv'Range) of GlobaleRecords.KartenRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => GlobaleKonstanten.LeererWertWeltkarte)));

   type StadtkarteArray is array (GlobaleDatentypen.Stadtfeld'Range, GlobaleDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      XAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      Ressourcenmenge : Natural;

   end record;

   type KartengrößenArray is array (GlobaleDatentypen.Kartengröße_Verwendet_Enum'Range) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := (
                                            GlobaleDatentypen.Karte_20_20 => (20, 20, 12),
                                            GlobaleDatentypen.Karte_40_40 => (40, 40, 50),
                                            GlobaleDatentypen.Karte_80_80 => (80, 80, 200),
                                            GlobaleDatentypen.Karte_120_80 => (120, 80, 300),
                                            GlobaleDatentypen.Karte_120_160 => (120, 160, 600),
                                            GlobaleDatentypen.Karte_160_160 => (160, 160, 800),
                                            GlobaleDatentypen.Karte_240_240 => (240, 240, 1_800),
                                            GlobaleDatentypen.Karte_320_320 => (320, 320, 3200),
                                            GlobaleDatentypen.Karte_1000_1000 => (1_000, 1_000, 31_250),
                                            GlobaleDatentypen.Karte_Nutzer => (1, 1, 1)
                                           );

   Kartengröße : GlobaleDatentypen.Kartengröße_Verwendet_Enum;

   -- Inseln, Kontinente, Pangäa
   -- GrößeLandart bekommt erst innerhalb der Kartengenerierung Werte, da sonst die Werte für Pangäa nicht bekannt wären.
   type GrößeLandartArray is array (GlobaleDatentypen.Kartenart_Verwendet_Enum'Range) of GlobaleDatentypen.KartenfeldPositiv;
   GrößeLandart : GrößeLandartArray;

   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   Kartenart : GlobaleDatentypen.Kartenart_Verwendet_Enum := GlobaleDatentypen.Inseln;
   -- Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, Wüste
   Kartentemperatur : GlobaleDatentypen.Kartentemperatur_Verwendet_Enum := GlobaleDatentypen.Kalt;
   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht
   Kartenform : GlobaleDatentypen.Kartenform_Verwendet_Enum := GlobaleDatentypen.X_Zylinder;

   type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of GlobaleDatentypen.Kartenfeld;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

end Karten;
