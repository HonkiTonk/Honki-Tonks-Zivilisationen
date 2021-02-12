pragma SPARK_Mode (On);

with GlobaleDatentypen;

package DatenbankRecords is

   -- EinheitenDatenbank
   type EinheitenListeRecord is record
      
      -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
      -- Addieren für genaue Passierbarkeit
      
      EinheitenGrafik : Wide_Wide_Character;
      
      EinheitTyp : GlobaleDatentypen.EinheitenTyp; -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft
      PreisGeld : GlobaleDatentypen.KostenLager;
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      Anforderungen : Integer;

      Passierbarkeit : GlobaleDatentypen.PassierbarkeitType;
      MaximaleLebenspunkte : Integer;
      MaximaleBewegungspunkte : Float;

      Beförderungsgrenze : Integer;
      MaximalerRang : Integer;
      Reichweite : Integer;
      Angriff : GlobaleDatentypen.GrundwerteNRGWVA;
      Verteidigung : GlobaleDatentypen.GrundwerteNRGWVA;
      
   end record;
   -- EinheitenDatenbank
   
   

   -- ForschungsDatenbank
   type ForschungListeRecord is record

      PreisForschung : GlobaleDatentypen.KostenLager;
      AnforderungForschung : GlobaleDatentypen.AnforderungForschungArray;

   end record;
   -- ForschungsDatenbank



   -- GebaeudeDatenbank
   type GebäudeListeRecord is record
      
      GebäudeGrafik : Wide_Wide_Character;
      
      PreisGeld : GlobaleDatentypen.KostenLager;      
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      Anforderungen : Integer;
      PermanenteKosten : GlobaleDatentypen.KostenLager;
      
      ProduktionBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      GeldBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      WissenBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      VerteidigungBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      NahrungBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Anderes : Boolean;

   end record;
   -- GebaeudeDatenbank



   -- KartenDatenbank
   type KartenListeRecord is record

      KartenGrafik : Wide_Wide_Character := ' ';
      
      Passierbarkeit : GlobaleDatentypen.PassierbarkeitType; -- 1 = Landeinheiten können passieren, 2 = Wassereinheiten können passieren, Lufteinheiten können immer passieren
      -- Addieren für genaue Passierbarkeit

      Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
      Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
      Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
      Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
      Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      
   end record;
   -- KartenDatenbank



   -- VerbesserungenDatenbank
   type VerbesserungListeRecord is record

      VerbesserungGrafik : Wide_Wide_Character;
      
      Passierbarkeit : GlobaleDatentypen.PassierbarkeitType; -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
      -- Addieren für genaue Passierbarkeit

      Nahrungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Ressourcenbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Geldbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Wissensbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      
   end record;
   -- verbesserungenDatenbank
   
end DatenbankRecords;
