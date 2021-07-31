pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorLandschaft is

   procedure GenerierungLandschaft;

private

   HügelGebirgeUmgebung : SichtweiteMitNullwert;

   BeliebigerLandschaftwert : Float;
   BeliebigerLandschaftFeldwert : Float;
   BeliebigerHügelwert : Float;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertHügel : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type WahrscheinlichkeitenRecord is record
         
      Anfangswert : Float;
      Endwert : Float;
         
   end record;
   
   type KartengrundWahrscheinlichkeitenArray is array (GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Range, Landschaft_Wahrscheinlichkeit_Enum'Range) of WahrscheinlichkeitenRecord;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray := (
                                                                                       GlobaleDatentypen.Kalt => 
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => (0.00, 0.25),
                                                                                          GlobaleDatentypen.Wüste     => (0.25, 0.30),
                                                                                          GlobaleDatentypen.Hügel     => (0.30, 0.40),
                                                                                          GlobaleDatentypen.Gebirge   => (0.40, 0.50),
                                                                                          GlobaleDatentypen.Wald      => (0.50, 0.65),
                                                                                          GlobaleDatentypen.Dschungel => (0.65, 0.70),
                                                                                          GlobaleDatentypen.Sumpf     => (0.70, 0.80)
                                                                                         ),
                                                                                       
                                                                                       GlobaleDatentypen.Gemäßigt =>
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => (0.00, 0.15),
                                                                                          GlobaleDatentypen.Wüste     => (0.15, 0.30),
                                                                                          GlobaleDatentypen.Hügel     => (0.30, 0.40),
                                                                                          GlobaleDatentypen.Gebirge   => (0.40, 0.50),
                                                                                          GlobaleDatentypen.Wald      => (0.50, 0.70),
                                                                                          GlobaleDatentypen.Dschungel => (0.70, 0.75),
                                                                                          GlobaleDatentypen.Sumpf     => (0.75, 0.85)
                                                                                         ),
                                                                                       
                                                                                       GlobaleDatentypen.Heiß =>
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => (0.00, 0.05),
                                                                                          GlobaleDatentypen.Wüste     => (0.05, 0.35),
                                                                                          GlobaleDatentypen.Hügel     => (0.35, 0.45),
                                                                                          GlobaleDatentypen.Gebirge   => (0.45, 0.50),
                                                                                          GlobaleDatentypen.Wald      => (0.50, 0.65),
                                                                                          GlobaleDatentypen.Dschungel => (0.65, 0.70),
                                                                                          GlobaleDatentypen.Sumpf     => (0.70, 0.90)
                                                                                         ),
                                                                                       
                                                                                       GlobaleDatentypen.Eiszeit =>
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => (0.00, 0.40),
                                                                                          GlobaleDatentypen.Wüste     => (0.40, 0.44),
                                                                                          GlobaleDatentypen.Hügel     => (0.44, 0.45),
                                                                                          GlobaleDatentypen.Gebirge   => (0.45, 0.55),
                                                                                          GlobaleDatentypen.Wald      => (0.55, 0.70),
                                                                                          GlobaleDatentypen.Dschungel => (0.70, 0.71),
                                                                                          GlobaleDatentypen.Sumpf     => (0.71, 0.80)
                                                                                         ),
                                                                                       
                                                                                       GlobaleDatentypen.Wüste =>
                                                                                         (
                                                                                          GlobaleDatentypen.Tundra    => (0.00, 0.05),
                                                                                          GlobaleDatentypen.Wüste     => (0.05, 0.50),
                                                                                          GlobaleDatentypen.Hügel     => (0.50, 0.55),
                                                                                          GlobaleDatentypen.Gebirge   => (0.55, 0.60),
                                                                                          GlobaleDatentypen.Wald      => (0.60, 0.70),
                                                                                          GlobaleDatentypen.Dschungel => (0.70, 0.75),
                                                                                          GlobaleDatentypen.Sumpf     => (0.75, 0.95)
                                                                                         )
                                                                                      );
   
   procedure LandschaftBestimmen
     (YPositionExtern, XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YPositionExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XPositionExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
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
