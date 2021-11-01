pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen;
with GlobaleVariablen;
with KartenRecords;

with Karten;

package SpielEinstellungenRasseSpieler is

   procedure StartwerteErmitteln;

   procedure StartpunktFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   
   
   function SpieleranzahlWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function SpielerbelegungWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function RasseWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function UmgebungPrüfen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
private
   
   StartpositionGefunden : Boolean;
   
   FreieFelder : KartenDatentypen.SichtweiteMitNullwert;
   
   Spieler : Natural;
   
   RasseEntfernen : constant Positive := 20;
   
   SpielerAnzahl : Integer;
   SpieleranzahlAuswahl : Integer;
   SpielerartAuswahl : Integer;
   RassenAuswahl : Integer;
   
   GezogeneWerte : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type KoordinatenArray is array (1 .. 2) of KartenRecords.AchsenKartenfeldPositivRecord;
   StartKoordinaten : KoordinatenArray;
   
   procedure FelderBestimmen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

end SpielEinstellungenRasseSpieler;
