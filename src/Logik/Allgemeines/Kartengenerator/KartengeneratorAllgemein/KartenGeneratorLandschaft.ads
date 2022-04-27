pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen;
with KartenRecords;

with KartenGeneratorBerechnungenAllgemein;
with Karten;

package KartenGeneratorLandschaft is

   procedure GenerierungLandschaft;

private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
      
   AnzahlGleicherGrund : KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder;
   GleicheUmgebung : KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder;
   UngünstigeUmgebung : KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder;
   
   NeuerGrund : KartenGrundDatentypen.Karten_Grund_Generator_Enum;
   ZusatzberechnungenGrund : KartenGrundDatentypen.Karten_Grund_Generator_Enum;
   
   WelcherGrund : KartenGrundDatentypen.Kartengrund_Enum;
   
   type KartengrundWahrscheinlichkeitArray is array (KartenGrundDatentypen.Karten_Grund_Generator_Enum'Range) of Float;
   KartengrundWahrscheinlichkeit : KartengrundWahrscheinlichkeitArray := (
                                                                          KartenGrundDatentypen.Tundra_Enum    => 0.30,
                                                                          KartenGrundDatentypen.Wüste_Enum     => 0.30,
                                                                          KartenGrundDatentypen.Hügel_Enum     => 0.25,
                                                                          KartenGrundDatentypen.Gebirge_Enum   => 0.25,
                                                                          KartenGrundDatentypen.Wald_Enum      => 0.40,
                                                                          KartenGrundDatentypen.Dschungel_Enum => 0.30,
                                                                          KartenGrundDatentypen.Sumpf_Enum     => 0.30,
                                                                          KartenGrundDatentypen.Flachland_Enum => 0.50
                                                                         );
   GezogeneZahlen : KartengrundWahrscheinlichkeitArray;
   
   type WelcheMöglichkeitenArray is array (KartengrundWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;
   
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
   
   procedure GrundBestimmen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure WeitereHügel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
      
   
   
   function GrundErneutBestimmen
     (GrundExtern : in KartenGrundDatentypen.Kartengrund_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum;
   
   function GrundZusatzberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungTundra
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungWüste
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungHügel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungGebirge
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungWald
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungDschungel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungSumpf
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungFlachland
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum;

end KartenGeneratorLandschaft;
