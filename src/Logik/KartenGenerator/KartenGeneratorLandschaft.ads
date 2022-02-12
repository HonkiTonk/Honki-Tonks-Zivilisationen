pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with KartenKonstanten;

with KartenGeneratorBerechnungenAllgemein;
with Karten;

package KartenGeneratorLandschaft is

   procedure GenerierungLandschaft;

private
   
   KartenWertAbstand : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertHügel : KartenRecords.AchsenKartenfeldPositivRecord;
      
   AnzahlGleicherGrund : KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder;
   
   -- Später vielleicht noch um Kartenarten wie hügelig erweitern?
   type ZusatzHügelArray is array (KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
   ZusatzHügel : constant ZusatzHügelArray := (0 => 0.10, 1 => 0.15, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.20, 6 => 0.25, 7 => 0.30, 8 => 0.40);
   
   type KartengrundWahrscheinlichkeitenArray is array (KartenDatentypen.Kartentemperatur_Verwendet_Enum'Range,
                                                       KartenDatentypen.Landschaft_Wahrscheinlichkeit_Enum'Range,
                                                       KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray :=
     (
      KartenKonstanten.TemperaturKaltKonstante => 
        (
         KartenDatentypen.Tundra    => (0 => 0.25, 1 => 0.30, 2 => 0.30, 3 => 0.35, 4 => 0.40, 5 => 0.45, 6 => 0.50, 7 => 0.55, 8 => 0.70),
         KartenDatentypen.Wüste     => (0 => 0.05, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.20, 6 => 0.25, 7 => 0.25, 8 => 0.30),
         KartenDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Wald      => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         KartenDatentypen.Dschungel => (0 => 0.10, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.25, 6 => 0.25, 7 => 0.30, 8 => 0.35),
         KartenDatentypen.Sumpf     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.25, 6 => 0.30, 7 => 0.30, 8 => 0.40)
        ),
                                                                                       
      KartenKonstanten.TemperaturGemäßigtKonstante =>
        (
         KartenDatentypen.Tundra    => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.35, 6 => 0.35, 7 => 0.40, 8 => 0.45),
         KartenDatentypen.Wüste     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.35, 6 => 0.35, 7 => 0.40, 8 => 0.45),
         KartenDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Wald      => (0 => 0.30, 1 => 0.35, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.50, 8 => 0.65),
         KartenDatentypen.Dschungel => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40),
         KartenDatentypen.Sumpf     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40)
        ),
                                                                                       
      KartenKonstanten.TemperaturHeißKonstante =>
        (
         KartenDatentypen.Tundra    => (0 => 0.05, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.20, 6 => 0.25, 7 => 0.25, 8 => 0.30),
         KartenDatentypen.Wüste     => (0 => 0.25, 1 => 0.30, 2 => 0.30, 3 => 0.35, 4 => 0.40, 5 => 0.45, 6 => 0.50, 7 => 0.55, 8 => 0.70),
         KartenDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Wald      => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         KartenDatentypen.Dschungel => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         KartenDatentypen.Sumpf     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40)
        ),
                                                                                       
      KartenKonstanten.TemperaturEiszeitKonstante =>
        (
         KartenDatentypen.Tundra    => (0 => 0.50, 1 => 0.55, 2 => 0.55, 3 => 0.60, 4 => 0.65, 5 => 0.70, 6 => 0.80, 7 => 0.90, 8 => 0.95),
         KartenDatentypen.Wüste     => (0 => 0.01, 1 => 0.05, 2 => 0.05, 3 => 0.10, 4 => 0.10, 5 => 0.15, 6 => 0.15, 7 => 0.20, 8 => 0.25),
         KartenDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Wald      => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         KartenDatentypen.Dschungel => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30),
         KartenDatentypen.Sumpf     => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30)
        ),
                                                                                       
      KartenKonstanten.TemperaturWüsteKonstante =>
        (
         KartenDatentypen.Tundra    => (0 => 0.01, 1 => 0.05, 2 => 0.05, 3 => 0.10, 4 => 0.10, 5 => 0.15, 6 => 0.15, 7 => 0.20, 8 => 0.25),
         KartenDatentypen.Wüste     => (0 => 0.50, 1 => 0.55, 2 => 0.55, 3 => 0.60, 4 => 0.65, 5 => 0.70, 6 => 0.80, 7 => 0.90, 8 => 0.95),
         KartenDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenDatentypen.Wald      => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         KartenDatentypen.Dschungel => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         KartenDatentypen.Sumpf     => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30)
        )
     );
   
   procedure LandschaftBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure AbstandTundraWüste
     (GrundExtern : in KartenDatentypen.Karten_Grund_Generator_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure WeitereHügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure AbstandEisschicht;
   
   procedure XAchseAbstandEisschicht
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv);
   
   
      
   function GrundFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Generator_Enum)
      return Boolean;

end KartenGeneratorLandschaft;
