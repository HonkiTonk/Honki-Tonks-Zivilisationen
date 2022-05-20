pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ProduktionDatentypen is

   ---------------------- Das hier mal an die neuen Produktionsidee anpassen.
   type KostenLager is range -10_000 .. 10_000;
   subtype GesamtePermanenteKosten is KostenLager range -500 .. 5_000;
   subtype GesamtproduktionStadt is GesamtePermanenteKosten range -500 .. 500;
   subtype ProduktionFeld is GesamtproduktionStadt range -100 .. 100;
   subtype ProduktionElement is ProduktionFeld range 0 .. 10;

   type ProduktionSonstiges is new ProduktionFeld range -1 .. 100;

   -------------------------- Das hier wird für Einheiten und Gebäude benutzt.
   type Permanente_Kosten_Enum is (
                                   Leer_Permanente_Kosten_Enum,
                                   
                                   Nahrung_Enum, Geld_Enum, Ressourcen_Enum, Hier_Spezielle_Ressourcen_Einbauen_Enum
                                  );
   
   subtype Permanente_Kosten_Verwendet_Enum is Permanente_Kosten_Enum range Nahrung_Enum .. Permanente_Kosten_Enum'Last;

end ProduktionDatentypen;
