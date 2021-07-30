pragma SPARK_Mode (On);

with GlobaleDatentypen;

package DatenbankRecords is

   -- EinheitenDatenbank
   type PassierbarkeitArray is array (GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range) of Boolean;

   type EinheitenListeRecord is record
      
      EinheitenGrafik : Wide_Wide_Character;
      
      -- Leer, Unbewaffnet, Nahkämpfer, Fernkämpfer, Beides, Sonstiges
      EinheitArt : GlobaleDatentypen.Einheit_Art_Enum;
      PreisGeld : GlobaleDatentypen.KostenLager;
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      PermanenteKosten : GlobaleDatentypen.PermanenteKostenArray;
      Anforderungen : GlobaleDatentypen.ForschungIDMitNullWert;

      -- Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
      Passierbarkeit : PassierbarkeitArray;
      
      MaximaleLebenspunkte : GlobaleDatentypen.MaximaleEinheiten;
      MaximaleBewegungspunkte : Float;
      WirdVerbessertZu : GlobaleDatentypen.EinheitenIDMitNullWert;

      -- In BenötigteErfahrungspunkte umbenennen?
      Beförderungsgrenze : GlobaleDatentypen.MaximaleStädte;
      MaximalerRang : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Reichweite : GlobaleDatentypen.ProduktionFeld;
      Angriff : GlobaleDatentypen.ProduktionFeld;
      Verteidigung : GlobaleDatentypen.ProduktionFeld;

      KannTransportieren : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      KannTransportiertWerden : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      Transportkapazität : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   type EinheitenListeArray is array (GlobaleDatentypen.EinheitenID'Range) of EinheitenListeRecord;
   -- EinheitenDatenbank
   
   

   -- ForschungsDatenbank
   type ForschungListeRecord is record

      PreisForschung : GlobaleDatentypen.KostenLager;
      AnforderungForschung : GlobaleDatentypen.AnforderungForschungArray;      

   end record;
   
   type ForschungListeArray is array (GlobaleDatentypen.ForschungID'Range) of ForschungListeRecord;
   -- ForschungsDatenbank


   
   type WertNahrungRessourcenGeldWissenVerteidigungArray is array (1 .. 5) of GlobaleDatentypen.ProduktionFeld;

   -- GebaeudeDatenbank
   type GebäudeListeRecord is record
      
      GebäudeGrafik : Wide_Wide_Character;
      
      PreisGeld : GlobaleDatentypen.KostenLager;      
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      PermanenteKosten : GlobaleDatentypen.PermanenteKostenArray;
      
      Anforderungen : GlobaleDatentypen.ForschungIDMitNullWert;
      
      ProduktionBonus : GlobaleDatentypen.ProduktionFeld;
      GeldBonus : GlobaleDatentypen.ProduktionFeld;
      WissenBonus : GlobaleDatentypen.ProduktionFeld;
      VerteidigungBonus : GlobaleDatentypen.ProduktionFeld;
      NahrungBonus : GlobaleDatentypen.ProduktionFeld;
      
      -- Auch in ein Array umschreiben wie die permanenten Kosten?
      GebäudeSpezielleEigenschaft : GlobaleDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudeListeArray is array (GlobaleDatentypen.GebäudeID'Range) of GebäudeListeRecord;
   -- GebaeudeDatenbank



   -- KartenDatenbankz
   type KartenListeRecord is record

      KartenGrafik : Wide_Wide_Character;
      
      -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
      Passierbarkeit : PassierbarkeitArray;

      Nahrungsgewinnung : GlobaleDatentypen.ProduktionFeld;
      Ressourcengewinnung : GlobaleDatentypen.ProduktionFeld;
      Geldgewinnung : GlobaleDatentypen.ProduktionFeld;
      Wissensgewinnung : GlobaleDatentypen.ProduktionFeld;
      Verteidigungsbonus : GlobaleDatentypen.ProduktionFeld;
      
   end record;
   -- KartenDatenbank



   -- VerbesserungenDatenbank
   type VerbesserungListeRecord is record

      VerbesserungGrafik : Wide_Wide_Character;
      
      -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
      Passierbarkeit : PassierbarkeitArray;

      Nahrungsbonus : GlobaleDatentypen.ProduktionFeld;
      Ressourcenbonus : GlobaleDatentypen.ProduktionFeld;
      Geldbonus : GlobaleDatentypen.ProduktionFeld;
      Wissensbonus : GlobaleDatentypen.ProduktionFeld;
      Verteidigungsbonus : GlobaleDatentypen.ProduktionFeld;
      
   end record;
   -- verbesserungenDatenbank
   
   
   
   -- RassenDatenbank
   type RassenListeRecord is record
      
      Aggressivität : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Expansion : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Wissenschaft : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Produktion : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Wirtschaft : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Bewirtschaftung : GlobaleDatentypen.MaximaleStädteMitNullWert;
      
      GültigeStaatsformen : GlobaleDatentypen.StaatsformenArray;
      -- Besondere Eigenschaften hinzufügen, als Enum? oder was Anderes?
      
   end record;
   -- RassenDatenbank
   
end DatenbankRecords;
