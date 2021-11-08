pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;
with KartenRecords;

with Karten;

package SpielEinstellungenRasseSpieler is

   procedure StartwerteErmitteln;

   procedure StartpunktFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   
   
   function RassenWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function UmgebungPrüfen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
private
   
   StartpositionGefunden : Boolean;
   
   FreieFelder : KartenDatentypen.SichtweiteMitNullwert;
   
   RassenAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   SpielerartAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   SpieleranzahlAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   
   GezogeneWerte : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type KoordinatenArray is array (1 .. 2) of KartenRecords.AchsenKartenfeldPositivRecord;
   StartKoordinaten : KoordinatenArray;
   
   procedure FelderBestimmen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure BelegungÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function EineRasseBelegt
     return Boolean;

end SpielEinstellungenRasseSpieler;
