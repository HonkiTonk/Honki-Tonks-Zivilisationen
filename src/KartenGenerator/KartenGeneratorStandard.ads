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
                                                                            Masse_Eisschild    => (0.00, 0.05),
                                                                            Feld_Eisschild     => (0.05, 0.15),
                                                                            Masse_Normal       => (0.00, 0.25),
                                                                            Feld_Normal        => (0.25, 0.55),
                                                                            Feld_Sonstiges     => (0.00, 0.05),
                                                                            Feld_Fläche_Frei   => (0.00, 0.85),
                                                                            Feld_Fläche_Belegt => (0.00, 0.55)
                                                                           ),
                                                                                 
                                                                         GlobaleDatentypen.Kontinente =>
                                                                           (
                                                                            Masse_Eisschild    => (0.00, 0.05),
                                                                            Feld_Eisschild     => (0.05, 0.15),
                                                                            Masse_Normal       => (0.00, 0.25),
                                                                            Feld_Normal        => (0.25, 0.55),
                                                                            Feld_Sonstiges     => (0.00, 0.02),
                                                                            Feld_Fläche_Frei   => (0.00, 0.95),
                                                                            Feld_Fläche_Belegt => (0.00, 0.80)
                                                                           ),
                                                                                 
                                                                         GlobaleDatentypen.Pangäa =>
                                                                           (
                                                                            Masse_Eisschild    => (0.00, 0.05),
                                                                            Feld_Eisschild     => (0.05, 0.15),
                                                                            Masse_Normal       => (0.00, 0.25),
                                                                            Feld_Normal        => (0.25, 0.55),
                                                                            Feld_Sonstiges     => (0.00, 0.02),
                                                                            Feld_Fläche_Frei   => (0.00, 0.95),
                                                                            Feld_Fläche_Belegt => (0.00, 0.00)
                                                                           ),
                                                                         
                                                                         others =>
                                                                           (
                                                                            others => (0.00, 0.00)
                                                                           )
                                                                        );

   
   
   procedure GenerierungKartenart
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasse
     (YPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasseFläche
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure GenerierungNurLand;
   procedure EisrandGenerieren;
   procedure StandardKarteGenerieren;
   
   procedure LandFeldMasseEisschild
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv);
   
   procedure LandFeldMasseNormal
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv);
   
   procedure LandmasseGenerieren
     (YPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv);
   
   procedure AbstandGenerieren
     (YPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv);

end KartenGeneratorStandard;
