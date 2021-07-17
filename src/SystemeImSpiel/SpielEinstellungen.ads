pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package SpielEinstellungen is

   function SpielEinstellungen
     return Integer
     with
       Post =>
         (SpielEinstellungen'Result in -1 .. 0);

private

   PrüfungEinheit : Boolean;
   PrüfungGrund : Boolean;
   RassenVorhanden : Boolean;

   SicherheitsTestWert : GlobaleDatentypen.KartenfeldPositivMitNullwert;

   SpielerAnzahl : Positive;

   Spieler : Natural;

   HauptAuswahl : Integer;
   KartengrößeAuswahl : Integer;
   KartenartAuswahl : Integer;
   KartenformAuswahl : Integer;
   KartentemperaturAuswahl : Integer;
   SpieleranzahlAuswahl : Integer;
   SpielerartAuswahl : Integer;
   RassenAuswahl : Integer;
   JaOderNein : Integer;
   SchwierigkeitAuswahl : Integer;
   BenutzerdefinierteGröße : Integer;
   Zufallswahl : Integer;

   PositionWert : GlobaleRecords.RassePlatznummerRecord;
   GezogeneWerte : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   PlatzBelegt : GlobaleRecords.RassePlatznummerRecord;

   type KoordinatenArray is array (1 .. 2) of GlobaleRecords.AchsenKartenfeldRecord;
   Koordinaten : KoordinatenArray;

   procedure StartwerteErmitteln;

   procedure StartpunktFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   function KartengrößeWählen
     return Integer
     with
       Post =>
         (KartengrößeWählen'Result >= -2);

   function KartenartWählen
     return Integer
     with
       Post =>
         (KartenartWählen'Result >= -2);

   function KartenformWählen
     return Integer
     with
       Post =>
         (KartenformWählen'Result >= -2);

   function KartentemperaturWählen
     return Integer
     with
       Post =>
         (KartentemperaturWählen'Result >= -2);

   function SpieleranzahlWählen
     return Integer
     with
       Post =>
         (SpieleranzahlWählen'Result >= -2);

   function MenschlicheSpieleranzahl
     return Integer
     with
       Post =>
         (MenschlicheSpieleranzahl'Result >= -2);

   function RasseWählen
     return Integer
     with
       Post =>
         (RasseWählen'Result >= -2);

   function UmgebungPrüfen
     (YPositionExtern, XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv;
      RasseExtern : in GlobaleDatentypen.Rassen)
      return Boolean
     with
       Pre =>
         (YPositionExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XPositionExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   function SchwierigkeitsgradFestlegen
     return Integer
     with
       Post =>
         (SchwierigkeitsgradFestlegen'Result >= -2);

end SpielEinstellungen;
