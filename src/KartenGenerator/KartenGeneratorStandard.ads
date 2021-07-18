pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorStandard is

   procedure StandardKarte;

private

   BeliebigerLandwert : Float;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type Land_Erzeugung_Enum is (Leer, Land_Eisschild, Landmasse_Eisschild, Land_Normal, Landmasse_Normal, Land_Sonstiges, Land_Fläche_Frei, Land_Fläche_Belegt);
   for Land_Erzeugung_Enum use (Leer => 0, Land_Eisschild => 1, Landmasse_Eisschild => 2, Land_Normal => 3, Landmasse_Normal => 4, Land_Sonstiges => 5, Land_Fläche_Frei => 6, Land_Fläche_Belegt => 7);
   subtype Land_Erzeugung_Verwendet_Enum is Land_Erzeugung_Enum range Land_Eisschild .. Land_Fläche_Belegt;

   type WahrscheinlichkeitenFürLandArray is array (GlobaleDatentypen.Kartenart_Verwendet_Enum'Range, Land_Erzeugung_Verwendet_Enum'Range) of Float;
   WahrscheinlichkeitenFürLand : constant WahrscheinlichkeitenFürLandArray := (
                                                                                 GlobaleDatentypen.Inseln =>
                                                                                   (
                                                                                    Land_Eisschild => 0.92,
                                                                                    Landmasse_Eisschild => 0.98,
                                                                                    Land_Normal => 0.75,
                                                                                    Landmasse_Normal => 0.80,
                                                                                    Land_Sonstiges => 0.98,
                                                                                    Land_Fläche_Frei => 0.15,
                                                                                    Land_Fläche_Belegt => 0.70),
                                                                                 
                                                                                 GlobaleDatentypen.Kontinente =>
                                                                                   (
                                                                                    Land_Eisschild => 0.92,
                                                                                    Landmasse_Eisschild => 0.98,
                                                                                    Land_Normal => 0.75,
                                                                                    Landmasse_Normal => 0.80,
                                                                                    Land_Sonstiges => 0.98,
                                                                                    Land_Fläche_Frei => 0.15,
                                                                                    Land_Fläche_Belegt => 0.70),
                                                                                 
                                                                                 GlobaleDatentypen.Pangäa =>
                                                                                   (
                                                                                    Land_Eisschild => 0.92,
                                                                                    Landmasse_Eisschild => 0.98,
                                                                                    Land_Normal => 0.75,
                                                                                    Landmasse_Normal => 0.80,
                                                                                    Land_Sonstiges => 0.98,
                                                                                    Land_Fläche_Frei => 0.15,
                                                                                    Land_Fläche_Belegt => 0.70),
                                                                                 
                                                                                 GlobaleDatentypen.Nur_Land =>
                                                                                   (
                                                                                    Land_Eisschild => 0.50,
                                                                                    Landmasse_Eisschild => 0.00,
                                                                                    Land_Normal => 0.50,
                                                                                    Landmasse_Normal => 0.00,
                                                                                    Land_Sonstiges => 0.50,
                                                                                    Land_Fläche_Frei => 0.00,
                                                                                    Land_Fläche_Belegt => 0.50),
                                                                                 
                                                                                 GlobaleDatentypen.Chaos =>
                                                                                   (
                                                                                    Land_Eisschild => 0.00,
                                                                                    Landmasse_Eisschild => 0.00, 
                                                                                    Land_Normal => 0.00,
                                                                                    Landmasse_Normal => 0.00,
                                                                                    Land_Sonstiges => 0.00,
                                                                                    Land_Fläche_Frei => 0.00,
                                                                                    Land_Fläche_Belegt => 0.00)
                                                                                );

   -- Immer berücksichtigen dass das ein Radiuswert ist und die Landgröße ein Durchmesser.
   -- Sollte so aber ganz gut sein, da bei halbem Loop zu wenig Wasser ist, aber eventuell Werte ein wenig verringern.
   type FelderVonLandartZuLandartArray is array (GlobaleDatentypen.Kartenart_Verwendet_Enum'Range) of GlobaleDatentypen.KartenfeldPositiv;
   FelderVonLandartZuLandart : constant FelderVonLandartZuLandartArray := (12, 30, 1, 1, 1);
   
   procedure GenerierungKartenart
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasse
     (YPositionLandmasseExtern, XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasseFläche
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungPangäa
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure GenerierungNurLand;

end KartenGeneratorStandard;
