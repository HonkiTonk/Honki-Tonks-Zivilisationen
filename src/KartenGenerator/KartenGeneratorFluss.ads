pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords;
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
   
   type StandardFlussArray is array (GlobaleDatentypen.EbeneVorhanden'First .. 0) of GlobaleDatentypen.Karten_Fluss_Enum;
   StandardFluss : constant StandardFlussArray := (
                                                   -2 => GlobaleDatentypen.Lavafluss_Einzeln,
                                                   -1 => GlobaleDatentypen.Unterirdischer_Fluss_Einzeln,
                                                   0 => GlobaleDatentypen.Fluss_Einzeln
                                                  );
   
   type WelcherFlusstypArray is array (StandardFlussArray'Range) of Natural;
   WelcherFlusstyp : constant WelcherFlusstypArray := (
                                                       -2 => GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (Lavaflusskreuzung_Vier) - GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (Flusskreuzung_Vier),
                                                       
                                                       -1 => GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (Unterirdische_Flusskreuzung_Vier)
                                                       - GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (Flusskreuzung_Vier),
                                                       
                                                       0 => 0
                                                      );
   Flusswert : WelcherFlusstypArray;
   
   type BeliebigerFlusswertArray is array (StandardFlussArray'Range) of Float;
   BeliebigerFlusswert : BeliebigerFlusswertArray;

   type KartenWertArray is array (StandardFlussArray'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenWertArray;
   KartenWertTesten : KartenWertArray;
   
   procedure FlussGenerierung
     (EbeneExtern : in GlobaleDatentypen.EbeneVorhanden);
   
   procedure FlussUmgebungTesten
     (YKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv;
      EbeneExtern : in GlobaleDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure FlussBerechnung
     (YKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv;
      EbeneExtern : in GlobaleDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure BerechnungLinks
     (EbeneExtern : in GlobaleDatentypen.EbeneVorhanden);
   
   procedure BerechnungRechts
     (EbeneExtern : in GlobaleDatentypen.EbeneVorhanden);
   
   procedure BerechnungOben
     (EbeneExtern : in GlobaleDatentypen.EbeneVorhanden);
   
   procedure BerechnungUnten
     (EbeneExtern : in GlobaleDatentypen.EbeneVorhanden);
   
   procedure FlussPlatzieren
     (YKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv;
      EbeneExtern : in GlobaleDatentypen.EbeneVorhanden);

end KartenGeneratorFluss;
