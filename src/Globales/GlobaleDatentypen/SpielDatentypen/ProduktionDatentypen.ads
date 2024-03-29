package ProduktionDatentypen is
   pragma Pure;

   -- Produktion rauswerfen, Stadtproduktion auf -10.000 .. 10.000 und StadtLagermenge auf 0 .. 10.000 erweitern? äöü
   -- Wobei ich ja für die Stadt prinzipiell kleinere Werte brauche als für die Gesamtwerte aller Städte. äöü
   type Produktion is range -10_000 .. 10_000;
   subtype Lagermenge is Produktion range 0 .. 10_000;
   subtype Stadtproduktion is Produktion range -5_000 .. 5_000;
   subtype StadtLagermenge is Stadtproduktion range 0 .. 5_000;
   
   subtype Feldproduktion is Stadtproduktion range -10 .. 100;
   subtype Einzelproduktion is Feldproduktion range -10 .. 10;
   subtype Vorzeichenwechsel is Stadtproduktion range -1 .. 1;
   
   
   
   -- Hier eine Begrenzung/Delta hinzufügen? äöü
   type BonusMalus is new Float range 0.00 .. 10.00;
   subtype Produktionsbonus is BonusMalus range 1.00 .. 10.00;
   subtype Produktionsmalus is BonusMalus range 0.00 .. 1.00;
   
   
   
   -- Das hier ist für die Kartenfelder, das darunter für die Einheiten- und Gebäudekosten.
   type Produktion_Enum is (
                            Nahrung_Enum, Material_Enum, Geld_Enum, Forschung_Enum
                           );
   
   

   -- Das hier wird für Einheiten und Gebäude benutzt, das darüber für die Kartenfelder.
   type Permanente_Kosten_Enum is (
                                   Leer_Permanente_Kosten_Enum,
                                   
                                   Nahrung_Enum, Material_Enum, Geld_Enum
                                   
                                   -- Noch spezielles Ressourcen hier einbauen, weglassen oder ein eigenes Enum dafür erstellen? äöü
                                  );
   
   subtype Permanente_Kosten_Vorhanden_Enum is Permanente_Kosten_Enum range Permanente_Kosten_Enum'Succ (Permanente_Kosten_Enum'First) .. Permanente_Kosten_Enum'Last;
   
   
   
   type Arbeitszeit is range -1 .. 100;
   subtype ArbeitszeitVorhanden is Arbeitszeit range 0 .. Arbeitszeit'Last;
   
   
   
   type Zufriedenheit is range -100 .. 100;
   subtype ZufriedenheitVorhanden is Zufriedenheit range 0 .. Zufriedenheit'Last;

end ProduktionDatentypen;
