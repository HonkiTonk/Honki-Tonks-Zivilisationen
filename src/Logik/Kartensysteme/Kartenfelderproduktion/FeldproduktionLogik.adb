with KartenRecordKonstanten;
with ProduktionKonstanten;
with SpielDatentypen;

with LeseEffekteDatenbank;
with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;
with LeseAllgemeines;

-- Erste einmal ein allumfassendes Feldproduktionssystem bauen und später feiner aufteilen. äöü
package body FeldproduktionLogik is
   
   function Feldproduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
      use type KartenextraDatentypen.Ressourcen_Enum;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
      use type ProduktionDatentypen.Produktionsbonus;
   begin
      
      Gesamtgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        Gesamtgrund
      is
         when KartengrundDatentypen.Vernichtet_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            Gesamtwert := LeseKartenDatenbanken.WirtschaftBasisgrund (GrundExtern         => Gesamtgrund,
                                                                      SpeziesExtern       => SpeziesExtern,
                                                                      WirtschaftArtExtern => ProduktionsartExtern);
            
            Gesamtwert := Gesamtwert + LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                                                    SpeziesExtern       => SpeziesExtern,
                                                                                    WirtschaftArtExtern => ProduktionsartExtern);
            
            RessourceVorhanden := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
            VerbesserungVorhanden := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      end case;
      
      if
        RessourceVorhanden /= KartenextraDatentypen.Leer_Ressource_Enum
        and
          VerbesserungVorhanden /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Verbesserungsbonus := LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => VerbesserungVorhanden,
                                                                                   SpeziesExtern      => SpeziesExtern,
                                                                                   WelcherWertExtern  => ProduktionsartExtern);
         Ressourcenbonus := LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => RessourceVorhanden,
                                                                        SpeziesExtern       => SpeziesExtern,
                                                                        WirtschaftArtExtern => ProduktionsartExtern);
         
      elsif
        RessourceVorhanden /= KartenextraDatentypen.Leer_Ressource_Enum
      then
         Ressourcenbonus := LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => RessourceVorhanden,
                                                                        SpeziesExtern       => SpeziesExtern,
                                                                        WirtschaftArtExtern => ProduktionsartExtern);
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
         
      elsif
        VerbesserungVorhanden /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Verbesserungsbonus := LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => VerbesserungVorhanden,
                                                                                   SpeziesExtern      => SpeziesExtern,
                                                                                   WelcherWertExtern  => ProduktionsartExtern);
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         
      else
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
      end if;
            
      Wegbonus := LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern         => LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern),
                                                             SpeziesExtern     => SpeziesExtern,
                                                             WelcherWertExtern => ProduktionsartExtern);
      
      Flussbonus := LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern),
                                                           SpeziesExtern       => SpeziesExtern,
                                                           WirtschaftArtExtern => ProduktionsartExtern);
      
      Feldeffektmalus := FeldeffektemalusFestlegen (KoordinatenExtern    => KoordinatenExtern,
                                                    SpeziesExtern        => SpeziesExtern,
                                                    ProduktionsartExtern => ProduktionsartExtern);
      
      Gesamtbonus := Grenzpruefungen.Produktionsbonus (RessourcenbonusExtern    => Ressourcenbonus,
                                                       VerbesserungsbonusExtern => Verbesserungsbonus,
                                                       WegebonusExtern          => Wegbonus,
                                                       FlussbonusExtern         => Flussbonus,
                                                       FeldeffektmalusExtern    => Feldeffektmalus);
      
      case
        LeseAllgemeines.Schwierigkeitsgrad
      is
         when SpielDatentypen.Schwierigkeitsgrad_Schwer_Enum =>
            Gesamtwert
              := ProduktionDatentypen.Feldproduktion (ProduktionDatentypen.Produktionsbonus'Floor (ProduktionDatentypen.Produktionsbonus (Gesamtwert) * Ressourcenbonus * Verbesserungsbonus * Flussbonus * Wegbonus));
            
         when others =>
            Gesamtwert
              := ProduktionDatentypen.Feldproduktion (ProduktionDatentypen.Produktionsbonus'Ceiling (ProduktionDatentypen.Produktionsbonus (Gesamtwert) * Ressourcenbonus * Verbesserungsbonus * Flussbonus * Wegbonus));
      end case;
      
      if
        Gesamtwert < ProduktionKonstanten.LeerProduktion
      then
         return ProduktionKonstanten.LeerProduktion;
         
      else
         return Gesamtwert;
      end if;
      
   end Feldproduktion;
   
   

   function FeldeffektemalusFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
   is
      use type KartenRecords.FeldeffektArray;
   begin
      
      FeldeffekteVorhanden := LeseWeltkarte.Feldeffekte (KoordinatenExtern => KoordinatenExtern);
      
      if
        FeldeffekteVorhanden = KartenRecordKonstanten.LeerEffekte
      then
         return ProduktionKonstanten.LeerBonus;
         
      else
         FeldeffektmalusZwischenspeicher := ProduktionKonstanten.LeerBonus;
      end if;
      
      EffekteSchleife:
      for EffekteSchleifenwert in FeldeffekteVorhanden'Range loop
         
         case
           FeldeffekteVorhanden (EffekteSchleifenwert)
         is
            when True =>
               FeldeffektmalusZwischenspeicher := MultiplikationPrüfen (KommazahlEinsExtern => FeldeffektmalusZwischenspeicher,
                                                                         KommazahlZweiExtern => LeseEffekteDatenbank.Produktion (EffektExtern           => EffekteSchleifenwert,
                                                                                                                                 SpeziesExtern          => SpeziesExtern,
                                                                                                                                 ProduktionszweigExtern => ProduktionsartExtern));
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
      return FeldeffektmalusZwischenspeicher;
      
   end FeldeffektemalusFestlegen;

end FeldproduktionLogik;
