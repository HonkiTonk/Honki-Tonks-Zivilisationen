pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorStandard is

   procedure StandardKarte;

private

   BeliebigerLandwert : Float;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type Land_Erzeugung_Enum is (Leer, Feld_Eisschild, Masse_Eisschild, Feld_Normal, Masse_Normal, Feld_Sonstiges, Feld_Fläche_Frei, Feld_Fläche_Belegt);
   for Land_Erzeugung_Enum use (Leer => 0, Feld_Eisschild => 1, Masse_Eisschild => 2, Feld_Normal => 3, Masse_Normal => 4, Feld_Sonstiges => 5, Feld_Fläche_Frei => 6, Feld_Fläche_Belegt => 7);
   subtype Land_Erzeugung_Verwendet_Enum is Land_Erzeugung_Enum range Feld_Eisschild .. Land_Erzeugung_Enum'Last;
   
   type WahrscheinlichkeitenRecord is record
      
      Anfangswert : Float;
      Endwert : Float;
      
   end record;
   
   -- Dafür noch feste Standardwerte einbauen? Wäre dann später bei weiterführenden Einstellungen wie viel Wasser sinnvoll.
   type WahrscheinlichkeitenLandArray is array (GlobaleDatentypen.Kartenart_Verwendet_Enum'Range, Land_Erzeugung_Verwendet_Enum'Range) of WahrscheinlichkeitenRecord;
   WahrscheinlichkeitenLand : constant WahrscheinlichkeitenLandArray := (
                                                                         GlobaleDatentypen.Inseln =>
                                                                           (
                                                                            Masse_Eisschild    => (0.00, 0.02),
                                                                            Feld_Eisschild     => (0.02, 0.10),
                                                                            Masse_Normal       => (0.00, 0.20),
                                                                            Feld_Normal        => (0.20, 0.45),
                                                                            Feld_Sonstiges     => (0.00, 0.02),
                                                                            Feld_Fläche_Frei   => (0.00, 0.85),
                                                                            Feld_Fläche_Belegt => (0.00, 0.30)
                                                                           ),
                                                                                 
                                                                         GlobaleDatentypen.Kontinente =>
                                                                           (
                                                                            Masse_Eisschild    => (0.00, 0.02),
                                                                            Feld_Eisschild     => (0.02, 0.10),
                                                                            Masse_Normal       => (0.00, 0.20),
                                                                            Feld_Normal        => (0.20, 0.45),
                                                                            Feld_Sonstiges     => (0.00, 0.02),
                                                                            Feld_Fläche_Frei   => (0.00, 0.85),
                                                                            Feld_Fläche_Belegt => (0.00, 0.30)
                                                                           ),
                                                                                 
                                                                         GlobaleDatentypen.Pangäa =>
                                                                           (
                                                                            Masse_Eisschild    => (0.00, 0.02),
                                                                            Feld_Eisschild     => (0.02, 0.10),
                                                                            Masse_Normal       => (0.00, 0.20),
                                                                            Feld_Normal        => (0.20, 0.45),
                                                                            Feld_Sonstiges     => (0.00, 0.02),
                                                                            Feld_Fläche_Frei   => (0.00, 0.85),
                                                                            Feld_Fläche_Belegt => (0.00, 0.30)
                                                                           ),
                                                                         
                                                                         others =>
                                                                           (
                                                                            Masse_Eisschild    => (0.00, 0.00),
                                                                            Feld_Eisschild     => (0.00, 0.00),
                                                                            Masse_Normal       => (0.00, 0.00),
                                                                            Feld_Normal        => (0.00, 0.00),
                                                                            Feld_Sonstiges     => (0.00, 0.00),
                                                                            Feld_Fläche_Frei   => (0.00, 0.00),
                                                                            Feld_Fläche_Belegt => (0.00, 0.00)
                                                                           )
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
   
   procedure EisrandGenerieren;

end KartenGeneratorStandard;
