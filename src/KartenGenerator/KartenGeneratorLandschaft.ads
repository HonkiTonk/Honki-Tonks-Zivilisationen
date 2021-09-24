pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords;
use GlobaleDatentypen;

with Karten, KartenGeneratorBerechnungenAllgemein;
use KartenGeneratorBerechnungenAllgemein;

package KartenGeneratorLandschaft is

   procedure GenerierungLandschaft;

private
   
   KartenWertAbstand : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertHügel : KartenRecords.AchsenKartenfeldPositivRecord;
      
   AnzahlGleicherGrund : KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder;
   
   -- Später vielleicht noch um Kartenarten wie hügelig erweitern?
   type ZusatzHügelArray is array (KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
   ZusatzHügel : constant ZusatzHügelArray := (0 => 0.10, 1 => 0.15, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.20, 6 => 0.25, 7 => 0.30, 8 => 0.40);
   
   type KartengrundWahrscheinlichkeitenArray is array (GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Range,
                                                       GlobaleDatentypen.Landschaft_Wahrscheinlichkeit_Enum'Range,
                                                       KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray :=
     (
      GlobaleDatentypen.Kalt => 
        (
         GlobaleDatentypen.Tundra    => (0 => 0.25, 1 => 0.30, 2 => 0.30, 3 => 0.35, 4 => 0.40, 5 => 0.45, 6 => 0.50, 7 => 0.55, 8 => 0.70),
         GlobaleDatentypen.Wüste     => (0 => 0.05, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.20, 6 => 0.25, 7 => 0.25, 8 => 0.30),
         GlobaleDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Wald      => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         GlobaleDatentypen.Dschungel => (0 => 0.10, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.25, 6 => 0.25, 7 => 0.30, 8 => 0.35),
         GlobaleDatentypen.Sumpf     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.25, 6 => 0.30, 7 => 0.30, 8 => 0.40)
        ),
                                                                                       
      GlobaleDatentypen.Gemäßigt =>
        (
         GlobaleDatentypen.Tundra    => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.35, 6 => 0.35, 7 => 0.40, 8 => 0.45),
         GlobaleDatentypen.Wüste     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.35, 6 => 0.35, 7 => 0.40, 8 => 0.45),
         GlobaleDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Wald      => (0 => 0.30, 1 => 0.35, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.50, 8 => 0.65),
         GlobaleDatentypen.Dschungel => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40),
         GlobaleDatentypen.Sumpf     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40)
        ),
                                                                                       
      GlobaleDatentypen.Heiß =>
        (
         GlobaleDatentypen.Tundra    => (0 => 0.05, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.20, 6 => 0.25, 7 => 0.25, 8 => 0.30),
         GlobaleDatentypen.Wüste     => (0 => 0.25, 1 => 0.30, 2 => 0.30, 3 => 0.35, 4 => 0.40, 5 => 0.45, 6 => 0.50, 7 => 0.55, 8 => 0.70),
         GlobaleDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Wald      => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         GlobaleDatentypen.Dschungel => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         GlobaleDatentypen.Sumpf     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40)
        ),
                                                                                       
      GlobaleDatentypen.Eiszeit =>
        (
         GlobaleDatentypen.Tundra    => (0 => 0.50, 1 => 0.55, 2 => 0.55, 3 => 0.60, 4 => 0.65, 5 => 0.70, 6 => 0.80, 7 => 0.90, 8 => 0.95),
         GlobaleDatentypen.Wüste     => (0 => 0.01, 1 => 0.05, 2 => 0.05, 3 => 0.10, 4 => 0.10, 5 => 0.15, 6 => 0.15, 7 => 0.20, 8 => 0.25),
         GlobaleDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Wald      => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         GlobaleDatentypen.Dschungel => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30),
         GlobaleDatentypen.Sumpf     => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30)
        ),
                                                                                       
      GlobaleDatentypen.Wüste =>
        (
         GlobaleDatentypen.Tundra    => (0 => 0.01, 1 => 0.05, 2 => 0.05, 3 => 0.10, 4 => 0.10, 5 => 0.15, 6 => 0.15, 7 => 0.20, 8 => 0.25),
         GlobaleDatentypen.Wüste     => (0 => 0.50, 1 => 0.55, 2 => 0.55, 3 => 0.60, 4 => 0.65, 5 => 0.70, 6 => 0.80, 7 => 0.90, 8 => 0.95),
         GlobaleDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         GlobaleDatentypen.Wald      => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         GlobaleDatentypen.Dschungel => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         GlobaleDatentypen.Sumpf     => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30)
        )
     );
   
   procedure LandschaftBestimmen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure AbstandTundraWüste
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Generator_Enum;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure WeitereHügel
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure AbstandEisschicht;
   
   procedure XAchseAbstandEisschicht
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv);
   
   
      
   function GrundFestlegen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Generator_Enum)
      return Boolean;

end KartenGeneratorLandschaft;
