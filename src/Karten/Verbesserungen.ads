pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package Verbesserungen is

   type Befehle_Enum is (Leer, Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Einheit_Auflösen, Plündern);

   procedure Verbesserung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Befehl : in Befehle_Enum) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 1));
   
   procedure VerbesserungFertiggestellt;
   
private
   
   Wahl : Boolean;

   Straßenwert : Integer;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

   procedure VerbesserungFehler (WelcherFehler : in Positive);
   
   procedure VerbesserungeFestgelegt (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Befehl : in Befehle_Enum) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0));

   procedure VerbesserungAngelegt (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0));

   procedure StraßeBerechnung (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) with
     Pre => (Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end Verbesserungen;
