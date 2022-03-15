pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen;
with KartenRecords;
with KartenEinstellungenKonstanten;

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
   ZusatzHügel : constant ZusatzHügelArray := (
                                                 0 => 0.10,
                                                 1 => 0.15,
                                                 2 => 0.15,
                                                 3 => 0.15,
                                                 4 => 0.20,
                                                 5 => 0.20,
                                                 6 => 0.25,
                                                 7 => 0.30,
                                                 8 => 0.40
                                                );
   
   type KartengrundWahrscheinlichkeitenArray is array (KartenDatentypen.Kartentemperatur_Verwendet_Enum'Range,
                                                       KartenGrundDatentypen.Landschaft_Wahrscheinlichkeit_Enum'Range,
                                                       KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray :=
     (
      KartenEinstellungenKonstanten.TemperaturKaltKonstante => 
        (
         KartenGrundDatentypen.Tundra    => (0 => 0.25, 1 => 0.30, 2 => 0.30, 3 => 0.35, 4 => 0.40, 5 => 0.45, 6 => 0.50, 7 => 0.55, 8 => 0.70),
         KartenGrundDatentypen.Wüste     => (0 => 0.05, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.20, 6 => 0.25, 7 => 0.25, 8 => 0.30),
         KartenGrundDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Wald      => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         KartenGrundDatentypen.Dschungel => (0 => 0.10, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.25, 6 => 0.25, 7 => 0.30, 8 => 0.35),
         KartenGrundDatentypen.Sumpf     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.25, 6 => 0.30, 7 => 0.30, 8 => 0.40)
        ),
                                                                                       
      KartenEinstellungenKonstanten.TemperaturGemäßigtKonstante =>
        (
         KartenGrundDatentypen.Tundra    => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.35, 6 => 0.35, 7 => 0.40, 8 => 0.45),
         KartenGrundDatentypen.Wüste     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.35, 6 => 0.35, 7 => 0.40, 8 => 0.45),
         KartenGrundDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Wald      => (0 => 0.30, 1 => 0.35, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.50, 8 => 0.65),
         KartenGrundDatentypen.Dschungel => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40),
         KartenGrundDatentypen.Sumpf     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40)
        ),
                                                                                       
      KartenEinstellungenKonstanten.TemperaturHeißKonstante =>
        (
         KartenGrundDatentypen.Tundra    => (0 => 0.05, 1 => 0.10, 2 => 0.15, 3 => 0.15, 4 => 0.20, 5 => 0.20, 6 => 0.25, 7 => 0.25, 8 => 0.30),
         KartenGrundDatentypen.Wüste     => (0 => 0.25, 1 => 0.30, 2 => 0.30, 3 => 0.35, 4 => 0.40, 5 => 0.45, 6 => 0.50, 7 => 0.55, 8 => 0.70),
         KartenGrundDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Wald      => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         KartenGrundDatentypen.Dschungel => (0 => 0.30, 1 => 0.30, 2 => 0.35, 3 => 0.35, 4 => 0.40, 5 => 0.40, 6 => 0.40, 7 => 0.45, 8 => 0.55),
         KartenGrundDatentypen.Sumpf     => (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.30, 4 => 0.30, 5 => 0.30, 6 => 0.35, 7 => 0.35, 8 => 0.40)
        ),
                                                                                       
      KartenEinstellungenKonstanten.TemperaturEiszeitKonstante =>
        (
         KartenGrundDatentypen.Tundra    => (0 => 0.50, 1 => 0.55, 2 => 0.55, 3 => 0.60, 4 => 0.65, 5 => 0.70, 6 => 0.80, 7 => 0.90, 8 => 0.95),
         KartenGrundDatentypen.Wüste     => (0 => 0.01, 1 => 0.05, 2 => 0.05, 3 => 0.10, 4 => 0.10, 5 => 0.15, 6 => 0.15, 7 => 0.20, 8 => 0.25),
         KartenGrundDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Wald      => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         KartenGrundDatentypen.Dschungel => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30),
         KartenGrundDatentypen.Sumpf     => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30)
        ),
                                                                                       
      KartenEinstellungenKonstanten.TemperaturWüsteKonstante =>
        (
         KartenGrundDatentypen.Tundra    => (0 => 0.01, 1 => 0.05, 2 => 0.05, 3 => 0.10, 4 => 0.10, 5 => 0.15, 6 => 0.15, 7 => 0.20, 8 => 0.25),
         KartenGrundDatentypen.Wüste     => (0 => 0.50, 1 => 0.55, 2 => 0.55, 3 => 0.60, 4 => 0.65, 5 => 0.70, 6 => 0.80, 7 => 0.90, 8 => 0.95),
         KartenGrundDatentypen.Hügel     => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Gebirge   => (0 => 0.15, 1 => 0.15, 2 => 0.20, 3 => 0.20, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.45),
         KartenGrundDatentypen.Wald      => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         KartenGrundDatentypen.Dschungel => (0 => 0.15, 1 => 0.20, 2 => 0.20, 3 => 0.25, 4 => 0.25, 5 => 0.30, 6 => 0.30, 7 => 0.35, 8 => 0.40),
         KartenGrundDatentypen.Sumpf     => (0 => 0.05, 1 => 0.10, 2 => 0.10, 3 => 0.15, 4 => 0.15, 5 => 0.20, 6 => 0.20, 7 => 0.25, 8 => 0.30)
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
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum;
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
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return Boolean;

end KartenGeneratorLandschaft;
