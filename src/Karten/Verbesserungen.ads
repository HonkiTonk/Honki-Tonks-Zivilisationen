pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package Verbesserungen is

   type Befehle_Enum is (Leer, Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Einheit_Auflösen, Plündern);

   procedure Verbesserung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in Befehle_Enum)
     with
       Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 1));
   
   procedure VerbesserungFertiggestellt;
   
private
   
   Wahl : Boolean;

   Straßenwert : Integer;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

   procedure VerbesserungFehler
     (WelcherFehlerExtern : in Positive);

   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure VerbesserungeFestgelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in Befehle_Enum)
     with
       Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));

   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));

   procedure StraßeBerechnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end Verbesserungen;
