pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   
   
   function RassenWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function UmgebungPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
private
   
   StartpositionGefunden : Boolean;
   
   FreieFelder : KartenDatentypen.SichtweiteMitNullwert;
   
   RassenAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   SpielerartAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   SpieleranzahlAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   
   GezogeneWerte : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type NotAus is range 1 .. 100;
   
   type KoordinatenArray is array (1 .. 2) of KartenRecords.AchsenKartenfeldPositivRecord;
   StartKoordinaten : KoordinatenArray;
   
   procedure FelderBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure BelegungÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function EineRasseBelegt
     return Boolean;

end SpielEinstellungenRasseSpieler;
