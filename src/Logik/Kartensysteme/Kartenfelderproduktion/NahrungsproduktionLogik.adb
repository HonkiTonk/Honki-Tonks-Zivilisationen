with SpielDatentypen;
with ProduktionKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseAllgemeines;
with LeseVerbesserungenDatenbank;

with Grenzpruefungen;

package body NahrungsproduktionLogik is

   function NahrungsproduktionKartenfeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
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
                                                                      WirtschaftArtExtern => ProduktionKonstanten.WirtschaftNahrung);
            
            Gesamtwert := Gesamtwert + LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                                                    SpeziesExtern       => SpeziesExtern,
                                                                                    WirtschaftArtExtern => ProduktionKonstanten.WirtschaftNahrung);
            
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
                                                                                   WelcherWertExtern  => ProduktionKonstanten.WirtschaftNahrung);
         Ressourcenbonus := LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => RessourceVorhanden,
                                                                        SpeziesExtern       => SpeziesExtern,
                                                                        WirtschaftArtExtern => ProduktionKonstanten.WirtschaftNahrung);
         
      elsif
        RessourceVorhanden /= KartenextraDatentypen.Leer_Ressource_Enum
      then
         Ressourcenbonus := LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => RessourceVorhanden,
                                                                        SpeziesExtern       => SpeziesExtern,
                                                                        WirtschaftArtExtern => ProduktionKonstanten.WirtschaftNahrung);
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
         
      elsif
        VerbesserungVorhanden /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Verbesserungsbonus := LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => VerbesserungVorhanden,
                                                                                   SpeziesExtern      => SpeziesExtern,
                                                                                   WelcherWertExtern  => ProduktionKonstanten.WirtschaftNahrung);
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         
      else
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
      end if;
            
      Wegbonus := LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern         => LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern),
                                                             SpeziesExtern     => SpeziesExtern,
                                                             WelcherWertExtern => ProduktionKonstanten.WirtschaftNahrung);
      
      Flussbonus := LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern),
                                                           SpeziesExtern       => SpeziesExtern,
                                                           WirtschaftArtExtern => ProduktionKonstanten.WirtschaftNahrung);
      
      Feldeffektmalus := 1.00;
      
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
      
   end NahrungsproduktionKartenfeld;
   
   
   
   function FeldeffektemalusFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
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
         ZwischenspeicherMalus := ProduktionKonstanten.LeerBonus;
      end if;
      
      case
        SpeziesExtern
      is
         when others =>
            null;
      end case;
      
      return ProduktionKonstanten.LeerBonus;
      
   end FeldeffektemalusFestlegen;
     
end NahrungsproduktionLogik;
