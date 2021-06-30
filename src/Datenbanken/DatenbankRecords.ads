pragma SPARK_Mode (On);

with GlobaleDatentypen;

package DatenbankRecords is

   -- EinheitenDatenbank
   type PassierbarkeitArray is array (GlobaleDatentypen.PassierbarkeitType'Range) of Boolean;
   type PreisArray is array (1 .. 2) of GlobaleDatentypen.KostenLager;
   type KampfwerteArray is array (1 .. 3) of GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;

   type EinheitenListeRecord is record
      
      EinheitenGrafik : Wide_Wide_Character;
      
      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft
      EinheitTyp : GlobaleDatentypen.EinheitenTyp;
      PreisGeld : GlobaleDatentypen.KostenLager;
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      Anforderungen : GlobaleDatentypen.ForschungIDMitNullWert;

      -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
      Passierbarkeit : PassierbarkeitArray;
      MaximaleLebenspunkte : Positive;
      MaximaleBewegungspunkte : Float;

      Beförderungsgrenze : Positive;
      MaximalerRang : Natural;
      Reichweite : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Angriff : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Verteidigung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;

      KannTransportieren : Natural;
      KannTransportiertWerden : Natural;
      Transportkapazität : Natural;
      
   end record;
   -- EinheitenDatenbank
   
   

   -- ForschungsDatenbank
   type ForschungListeRecord is record

      PreisForschung : GlobaleDatentypen.KostenLager;
      AnforderungForschung : GlobaleDatentypen.AnforderungForschungArray;

   end record;
   -- ForschungsDatenbank


   
   type WertNahrungRessourcenGeldWissenVerteidigungArray is array (1 .. 5) of GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;

   -- GebaeudeDatenbank
   type GebäudeListeRecord is record
      
      GebäudeGrafik : Wide_Wide_Character;
      
      PreisGeld : GlobaleDatentypen.KostenLager;      
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      Anforderungen : GlobaleDatentypen.ForschungIDMitNullWert;
      PermanenteKosten : GlobaleDatentypen.KostenLager;
      
      ProduktionBonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      GeldBonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      WissenBonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      VerteidigungBonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      NahrungBonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      
      -- Rauswerfen? Durch was besseres ersetzen?
      Anderes : Boolean;

   end record;
   -- GebaeudeDatenbank



   -- KartenDatenbank
   type KartenListeRecord is record

      KartenGrafik : Wide_Wide_Character;
      
      -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
      Passierbarkeit : PassierbarkeitArray;

      Nahrungsgewinnung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Ressourcengewinnung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Geldgewinnung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Wissensgewinnung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Verteidigungsbonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      
   end record;
   -- KartenDatenbank



   -- VerbesserungenDatenbank
   type VerbesserungListeRecord is record

      VerbesserungGrafik : Wide_Wide_Character;
      
      -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
      Passierbarkeit : PassierbarkeitArray;

      Nahrungsbonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Ressourcenbonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Geldbonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Wissensbonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      Verteidigungsbonus : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      
   end record;
   -- verbesserungenDatenbank
   
end DatenbankRecords;
