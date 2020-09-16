package body ProzedurenListe is

   -- ProzedurenListe:
   -- 1 = InDerStadt.StadtProduktionPrüfen, ändert die Produktionswerte für die Städte
   -- 2 = 

   procedure ProzedurEinsProduktionWerteFestlegen (Rasse, StadtNummer, YAchse, XAchse : in Integer) is
   begin
      
      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsproduktion
        := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsproduktion + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Nahrungsgewinnung
        + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Ressource).Nahrungsgewinnung
        + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungStraße).Nahrungsbonus
        + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungGebiet).Nahrungsbonus;

      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate
        := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Ressourcengewinnung
        + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Ressource).Ressourcengewinnung
        + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungStraße).Ressourcenbonus
        + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungGebiet).Ressourcenbonus;

      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung
        := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Geldgewinnung
        + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Ressource).Geldgewinnung
        + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungStraße).Geldbonus
        + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungGebiet).Geldbonus;

      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate
        := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Wissensgewinnung
        + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Ressource).Wissensgewinnung
        + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungStraße).Wissensbonus
        + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungGebiet).Wissensbonus;
      
   end ProzedurEinsProduktionWerteFestlegen;

end ProzedurenListe;
