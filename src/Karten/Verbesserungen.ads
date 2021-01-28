with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with SchleifenPruefungen, GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, Karten, Anzeige, WerteFestlegen, GlobaleRecords;
use GlobaleDatentypen;

package Verbesserungen is

   type Befehle is (Leer, Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Einheit_Auflösen, Plündern);

   procedure Verbesserung (RasseExtern : in GlobaleDatentypen.Rassen; Befehl : in Befehle; EinheitNummer : in Positive);   
   procedure VerbesserungFertiggestellt;
   
private
   
   Wahl : Boolean;

   Straßenwert : Integer;

   KartenWert : GlobaleRecords.AchsenAusKartenfeld;
   
   procedure VerbesserungeFestgelegt (RasseExtern : in GlobaleDatentypen.Rassen; Befehl : in Befehle; EinheitNummer : in Positive);
   procedure VerbesserungAngelegt (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive);

   procedure StraßeBerechnung (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv) with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

end Verbesserungen;
