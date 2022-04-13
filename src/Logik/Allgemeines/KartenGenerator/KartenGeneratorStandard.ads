pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen;
with KartenRecords;

with Karten;

package KartenGeneratorStandard is

   procedure StandardKarte;

private

   BeliebigerLandwert : Float;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type Land_Erzeugung_Enum is (
                                Leer_Enum,
                                
                                Feld_Eisschild_Enum, Masse_Eisschild_Enum, Feld_Normal_Enum, Masse_Normal_Enum, Feld_Sonstiges_Enum, Feld_Fläche_Frei_Enum, Feld_Fläche_Belegt_Enum
                               );
   subtype Land_Erzeugung_Verwendet_Enum is Land_Erzeugung_Enum range Feld_Eisschild_Enum .. Land_Erzeugung_Enum'Last;
   
   type WahrscheinlichkeitenRecord is record
      
      Anfangswert : Float;
      Endwert : Float;
      
   end record;
   
   -- Dafür noch feste Standardwerte einbauen? Wäre dann später bei weiterführenden Einstellungen wie viel Wasser sinnvoll.
   type WahrscheinlichkeitenLandArray is array (KartenDatentypen.Kartenart_Verwendet_Enum'Range, Land_Erzeugung_Verwendet_Enum'Range) of WahrscheinlichkeitenRecord;
   WahrscheinlichkeitenLand : constant WahrscheinlichkeitenLandArray := (
                                                                         SystemDatentypen.Karte_Art_Inseln_Enum =>
                                                                           (
                                                                            Masse_Eisschild_Enum    => (0.00, 0.05),
                                                                            Feld_Eisschild_Enum     => (0.05, 0.15),
                                                                            Masse_Normal_Enum       => (0.00, 0.25),
                                                                            Feld_Normal_Enum        => (0.25, 0.55),
                                                                            Feld_Sonstiges_Enum     => (0.00, 0.05),
                                                                            Feld_Fläche_Frei_Enum   => (0.00, 0.85),
                                                                            Feld_Fläche_Belegt_Enum => (0.00, 0.55)
                                                                           ),
                                                                                 
                                                                         SystemDatentypen.Karte_Art_Kontinente_Enum =>
                                                                           (
                                                                            Masse_Eisschild_Enum    => (0.00, 0.05),
                                                                            Feld_Eisschild_Enum     => (0.05, 0.15),
                                                                            Masse_Normal_Enum       => (0.00, 0.25),
                                                                            Feld_Normal_Enum        => (0.25, 0.55),
                                                                            Feld_Sonstiges_Enum     => (0.00, 0.02),
                                                                            Feld_Fläche_Frei_Enum   => (0.00, 0.95),
                                                                            Feld_Fläche_Belegt_Enum => (0.00, 0.80)
                                                                           ),
                                                                                 
                                                                         SystemDatentypen.Karte_Art_Pangäa_Enum =>
                                                                           (
                                                                            Masse_Eisschild_Enum    => (0.00, 0.05),
                                                                            Feld_Eisschild_Enum     => (0.05, 0.15),
                                                                            Masse_Normal_Enum       => (0.00, 0.25),
                                                                            Feld_Normal_Enum        => (0.25, 0.55),
                                                                            Feld_Sonstiges_Enum     => (0.00, 0.02),
                                                                            Feld_Fläche_Frei_Enum   => (0.00, 0.95),
                                                                            Feld_Fläche_Belegt_Enum => (0.00, 0.00)
                                                                           ),
                                                                         
                                                                         others =>
                                                                           (
                                                                            others => (0.00, 0.00)
                                                                           )
                                                                        );

   
   
   procedure GenerierungKartenart
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasse
     (YKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YKoordinateLandmasseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            XKoordinateLandmasseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasseFläche
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
   
   procedure GenerierungNurLand;
   procedure EisrandGenerieren;
   procedure StandardKarteGenerieren;
   
   procedure LandFeldMasseEisschild
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);
   
   procedure LandFeldMasseNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);
   
   procedure LandmasseGenerieren
     (YKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv);
   
   procedure AbstandGenerieren
     (YKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv);

end KartenGeneratorStandard;
