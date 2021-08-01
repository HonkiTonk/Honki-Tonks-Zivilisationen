pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorFluss is

   procedure GenerierungFlüsse;

private

   type WahscheinlichkeitFlussArray is array (GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Range) of Float;
   WahrscheinlichkeitFluss : constant WahscheinlichkeitFlussArray := (
                                                                      GlobaleDatentypen.Kalt     => 0.25,
                                                                      GlobaleDatentypen.Gemäßigt => 0.30,
                                                                      GlobaleDatentypen.Heiß     => 0.25,
                                                                      GlobaleDatentypen.Eiszeit  => 0.15,
                                                                      GlobaleDatentypen.Wüste    => 0.15
                                                                     );

   Flusswert : Positive;

   BeliebigerFlusswert : Float;
   
   StandardFluss : constant GlobaleDatentypen.Karten_Grund_Fluss_Enum := GlobaleDatentypen.Fluss_Einzeln;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   procedure FlussUmgebungTesten
     (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure FlussBerechnung
     (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorFluss;
