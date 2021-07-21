pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorLandschaft is

   procedure GenerierungLandschaft;

private

   HügelGebirgeUmgebung : Natural;

   BeliebigerLandschaftwert : Float;
   BeliebigerLandschaftFeldwert : Float;
   BeliebigerHügelwert : Float;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertHügel : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type KartengrundWahrscheinlichkeitenArray is array (GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Range, Landschaft_Wahrscheinlichkeit_Enum'Range) of Float;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray := (
                                                                                       -- 4 = Tundra, 5 = Wüste, 6 = Hügel, 7 = Gebirge, 8 = Wald, 9 = Dschungel, 10 = Sumpf
                                                                                       GlobaleDatentypen.Kalt => 
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => 0.25,
                                                                                          GlobaleDatentypen.Wüste     => 0.30,
                                                                                          GlobaleDatentypen.Hügel     => 0.40,
                                                                                          GlobaleDatentypen.Gebirge   => 0.50,
                                                                                          GlobaleDatentypen.Wald      => 0.65,
                                                                                          GlobaleDatentypen.Dschungel => 0.70,
                                                                                          GlobaleDatentypen.Sumpf     => 0.80),
                                                                                       
                                                                                       GlobaleDatentypen.Gemäßigt =>
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => 0.15,
                                                                                          GlobaleDatentypen.Wüste     => 0.30,
                                                                                          GlobaleDatentypen.Hügel     => 0.40,
                                                                                          GlobaleDatentypen.Gebirge   => 0.50,
                                                                                          GlobaleDatentypen.Wald      => 0.70,
                                                                                          GlobaleDatentypen.Dschungel => 0.75,
                                                                                          GlobaleDatentypen.Sumpf     => 0.85),
                                                                                       
                                                                                       GlobaleDatentypen.Heiß =>
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => 0.05,
                                                                                          GlobaleDatentypen.Wüste     => 0.35,
                                                                                          GlobaleDatentypen.Hügel     => 0.45,
                                                                                          GlobaleDatentypen.Gebirge   => 0.50,
                                                                                          GlobaleDatentypen.Wald      => 0.65,
                                                                                          GlobaleDatentypen.Dschungel => 0.70,
                                                                                          GlobaleDatentypen.Sumpf     => 0.90),
                                                                                       
                                                                                       GlobaleDatentypen.Eiszeit =>
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => 0.40,
                                                                                          GlobaleDatentypen.Wüste     => 0.44,
                                                                                          GlobaleDatentypen.Hügel     => 0.45,
                                                                                          GlobaleDatentypen.Gebirge   => 0.55,
                                                                                          GlobaleDatentypen.Wald      => 0.70,
                                                                                          GlobaleDatentypen.Dschungel => 0.71,
                                                                                          GlobaleDatentypen.Sumpf     => 0.80),
                                                                                       
                                                                                       GlobaleDatentypen.Wüste =>
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => 0.00,
                                                                                          GlobaleDatentypen.Wüste     => 0.50,
                                                                                          GlobaleDatentypen.Hügel     => 0.55,
                                                                                          GlobaleDatentypen.Gebirge   => 0.60,
                                                                                          GlobaleDatentypen.Wald      => 0.70,
                                                                                          GlobaleDatentypen.Dschungel => 0.75,
                                                                                          GlobaleDatentypen.Sumpf     => 0.95)
                                                                                      );
   
   procedure GenerierungLandschaftFelder
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (GrundExtern /= GlobaleDatentypen.Leer
          and
            YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandschaftHügel
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorLandschaft;
