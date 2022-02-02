pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with KartenKonstanten;

with Karten;

package KartenGeneratorFluss is

   procedure GenerierungFlüsse;

private
   
   type WahscheinlichkeitFlussArray is array (KartenDatentypen.Kartentemperatur_Verwendet_Enum'Range) of Float;
   WahrscheinlichkeitFluss : constant WahscheinlichkeitFlussArray := (
                                                                      KartenKonstanten.TemperaturKaltKonstante     => 0.25,
                                                                      KartenKonstanten.TemperaturGemäßigtKonstante => 0.30,
                                                                      KartenKonstanten.TemperaturHeißKonstante     => 0.25,
                                                                      KartenKonstanten.TemperaturEiszeitKonstante  => 0.15,
                                                                      KartenKonstanten.TemperaturWüsteKonstante    => 0.15
                                                                     );
   
   type StandardFlussArray is array (KartenDatentypen.EbeneVorhanden'First .. 0) of KartenDatentypen.Karten_Fluss_Enum;
   StandardFluss : constant StandardFlussArray := (
                                                   -2 => KartenDatentypen.Lavafluss_Einzeln,
                                                   -1 => KartenDatentypen.Unterirdischer_Fluss_Einzeln,
                                                   0  => KartenDatentypen.Fluss_Einzeln
                                                  );
   
   type WelcherFlusstypArray is array (StandardFlussArray'Range) of Natural;
   WelcherFlusstyp : constant WelcherFlusstypArray := (
                                                       -2 => KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (Lavaflusskreuzung_Vier) - KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (Flusskreuzung_Vier),
                                                       
                                                       -1 => KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (Unterirdische_Flusskreuzung_Vier)
                                                       - KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (Flusskreuzung_Vier),
                                                       
                                                       0 => 0
                                                      );
   Flusswert : WelcherFlusstypArray;
   
   type BeliebigerFlusswertArray is array (StandardFlussArray'Range) of Float;
   BeliebigerFlusswert : BeliebigerFlusswertArray;

   type KartenWertArray is array (StandardFlussArray'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenWertArray;
   KartenWertTesten : KartenWertArray;
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure FlussUmgebungTesten
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure FlussBerechnung
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure BerechnungLinks
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungRechts
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure FlussPlatzieren
     (YKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden);

end KartenGeneratorFluss;
