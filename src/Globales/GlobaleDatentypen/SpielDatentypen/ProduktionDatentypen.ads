pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ProduktionDatentypen is

   ----------------------- Produktion rauswerfen, Stadtproduktion auf -10000 .. 10000 und StadtLagermenge auf 0 .. 10000 erweitern?
   ----------------------- Wobei ich ja für die Stadt prinzipiell kleinere Werte brauche als für die Gesamtwerte aller Städte.
   type Produktion is range -10_000 .. 10_000;
   subtype Lagermenge is Produktion range 0 .. 10_000;
   subtype Stadtproduktion is Produktion range -5_000 .. 5_000;
   subtype StadtLagermenge is Stadtproduktion range 0 .. 5_000;
   subtype Feldproduktion is Stadtproduktion range 0 .. 50;
   subtype Einzelproduktion is Feldproduktion range 0 .. 10;
   subtype Zwischenlösung is Stadtproduktion range -1 .. 1;

   -------------------------- Das hier wird für Einheiten und Gebäude benutzt.
   -------------------------- Besser benennen und generell mal bessere Benennung für Produktion und Ressource einbauen, damit man die produzierte Menge in einer Stadt besser von den Kartenressourcen unterscheiden kann.
   type Permanente_Kosten_Enum is (
                                   Leer_Permanente_Kosten_Enum,
                                   
                                   Nahrung_Enum, Geld_Enum, Ressourcen_Enum, Hier_Spezielle_Ressourcen_Einbauen_Enum
                                  );
   
   subtype Permanente_Kosten_Verwendet_Enum is Permanente_Kosten_Enum range Nahrung_Enum .. Permanente_Kosten_Enum'Last;
   
   -------------------------------------- subtype von den Produktionstypen?
   type Arbeitszeit is range -100 .. 100;
   subtype ArbeitszeitVorhanden is Arbeitszeit range 1 .. Arbeitszeit'Last;
   
   ------------------------------ Es werden benötigt:
   ------------------------------ Datentypen für diplomatischen Zustand, später in passendere Datei verschieben:
   
   
   ------------------------------ Datentypen für Zufriedenheit:
   
   
   ------------------------------ Datentypen für Einwohner:
   type Einwohner is range 0 .. 100;
   
   ------------------------------ Die noch für den Kampf verwendeten Datentypen entsprechend später einbauen und die aktuell verwendeten ProduktionDatentypenverwendung entfernen.

end ProduktionDatentypen;
