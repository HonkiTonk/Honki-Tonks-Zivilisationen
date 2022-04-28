pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenRecords;

with KartengeneratorBerechnungenAllgemein;
with Karten;

package KartengeneratorLandschaft is

   procedure GenerierungLandschaft;

private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
      
   AnzahlGleicherGrund : KartengeneratorBerechnungenAllgemein.AnzahlGleicherFelder;
   
   NeuerGrund : KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum;
   ZusatzberechnungenGrund : KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum;
   
   WelcherGrund : KartengrundDatentypen.Kartengrund_Enum;
   
   type KartengrundWahrscheinlichkeitArray is array (KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range) of Float;
   KartengrundWahrscheinlichkeit : KartengrundWahrscheinlichkeitArray := (
                                                                          KartengrundDatentypen.Tundra_Enum    => 0.30,
                                                                          KartengrundDatentypen.Wüste_Enum     => 0.30,
                                                                          KartengrundDatentypen.Hügel_Enum     => 0.25,
                                                                          KartengrundDatentypen.Gebirge_Enum   => 0.25,
                                                                          KartengrundDatentypen.Wald_Enum      => 0.40,
                                                                          KartengrundDatentypen.Dschungel_Enum => 0.30,
                                                                          KartengrundDatentypen.Sumpf_Enum     => 0.30,
                                                                          KartengrundDatentypen.Flachland_Enum => 0.50
                                                                         );
   GezogeneZahlen : KartengrundWahrscheinlichkeitArray;
   
   type WelcheMöglichkeitenArray is array (KartengrundWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;
   
   type ZusatzHügelArray is array (KartengeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
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
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum;
   
   function GrundZusatzberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungTundra
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungWüste
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungHügel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungGebirge
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungWald
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungDschungel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungSumpf
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungFlachland
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum;

end KartengeneratorLandschaft;
