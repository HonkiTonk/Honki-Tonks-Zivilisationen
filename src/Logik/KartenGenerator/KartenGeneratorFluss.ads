pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen;
with KartenRecords;
with KartenEinstellungenKonstanten;

with Karten;

package KartenGeneratorFluss is

   procedure GenerierungFlüsse;

private
   
   type WahscheinlichkeitFlussArray is array (KartenDatentypen.Kartentemperatur_Verwendet_Enum'Range) of Float;
   WahrscheinlichkeitFluss : constant WahscheinlichkeitFlussArray := (
                                                                      KartenEinstellungenKonstanten.TemperaturKaltKonstante     => 0.25,
                                                                      KartenEinstellungenKonstanten.TemperaturGemäßigtKonstante => 0.30,
                                                                      KartenEinstellungenKonstanten.TemperaturHeißKonstante     => 0.25,
                                                                      KartenEinstellungenKonstanten.TemperaturEiszeitKonstante  => 0.15,
                                                                      KartenEinstellungenKonstanten.TemperaturWüsteKonstante    => 0.15
                                                                     );
   
   type StandardFlussArray is array (KartenDatentypen.EbeneVorhanden'First .. 0) of KartenGrundDatentypen.Karten_Fluss_Enum;
   StandardFluss : constant StandardFlussArray := (
                                                   -2 => KartenGrundDatentypen.Lavasee,
                                                   -1 => KartenGrundDatentypen.Unterirdischer_See,
                                                   0  => KartenGrundDatentypen.See
                                                  );
   
   type WelcherFlusstypArray is array (StandardFlussArray'Range) of Natural;
   WelcherFlusstyp : constant WelcherFlusstypArray := (
                                                       -2 => KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenGrundDatentypen.Lavaflusskreuzung_Vier)
                                                       - KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier),
                                                       
                                                       -1 => KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenGrundDatentypen.Unterirdische_Flusskreuzung_Vier)
                                                       - KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum'Pos (KartenGrundDatentypen.Flusskreuzung_Vier),
                                                       
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
