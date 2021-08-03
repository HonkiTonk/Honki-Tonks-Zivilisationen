pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package SpielEinstellungenRasseSpieler is

   procedure StartwerteErmitteln;

   procedure StartpunktFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   
   
   function SpieleranzahlWählen
     return Integer
     with
       Post =>
         (SpieleranzahlWählen'Result >= -2);

   function SpielerbelegungWählen
     return Integer
     with
       Post =>
         (SpielerbelegungWählen'Result >= -2);

   function RasseWählen
     return Integer
     with
       Post =>
         (RasseWählen'Result >= -2);

   function UmgebungPrüfen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
private
   
   SicherheitsTestWert : GlobaleDatentypen.KartenfeldPositivMitNullwert;
   
   Spieler : Natural;
   
   SpielerAnzahl : Integer;
   SpieleranzahlAuswahl : Integer;
   SpielerartAuswahl : Integer;
   RassenAuswahl : Integer;
   
   GezogeneWerte : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type KoordinatenArray is array (1 .. 2) of GlobaleRecords.AchsenKartenfeldPositivRecord;
   StartKoordinaten : KoordinatenArray;

end SpielEinstellungenRasseSpieler;
