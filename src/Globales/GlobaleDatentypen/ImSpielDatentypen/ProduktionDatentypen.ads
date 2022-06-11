pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ProduktionDatentypen is

   type Produktion is range -10_000 .. 10_000;
   subtype Stadtproduktion is Produktion range -5000 .. 5000;
   subtype Feldproduktion is Stadtproduktion range 0 .. 50;
   subtype Einzelproduktion is Feldproduktion range 0 .. 10;
   subtype Zwischenlösung is Stadtproduktion range -1 .. 1;

   -------------------------- Das hier wird für Einheiten und Gebäude benutzt.
   type Permanente_Kosten_Enum is (
                                   Leer_Permanente_Kosten_Enum,
                                   
                                   Nahrung_Enum, Geld_Enum, Ressourcen_Enum, Hier_Spezielle_Ressourcen_Einbauen_Enum
                                  );
   
   subtype Permanente_Kosten_Verwendet_Enum is Permanente_Kosten_Enum range Nahrung_Enum .. Permanente_Kosten_Enum'Last;
   
   ------------------------------ Es werden benötigt:
   ------------------------------ Datentypen für diplomatischen Zustand, später in passendere Datei verschieben:
   
   
   ------------------------------ Datentypen für Zufriedenheit:
   
   
   ------------------------------ Datentypen für Einwohner:
   type Einwohner is range 0 .. 100;
   
   ------------------------------ Die noch für den Kampf verwendeten Datentypen entsprechend später einbauen und die aktuell verwendeten ProduktionDatentypenverwendung entfernen.

end ProduktionDatentypen;
