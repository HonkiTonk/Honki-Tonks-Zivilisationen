with KampfKonstanten;
with ProduktionKonstanten;
with SpielDatentypen;
with KartenRecordKonstanten;

with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;
with LeseAllgemeines;
with LeseEffekteDatenbank;

package body FeldkampfEinheitLogik is

   function Feldkampf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is
      use type KartenextraDatentypen.Ressourcen_Enum;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
      use type ProduktionDatentypen.Produktionsbonus;
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      Gesamtgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        Gesamtgrund
      is
         when KartengrundDatentypen.Vernichtet_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            Gesamtwert := LeseKartenDatenbanken.KampfBasisgrund (GrundExtern    => Gesamtgrund,
                                                                 SpeziesExtern  => SpeziesExtern,
                                                                 KampfartExtern => KampfartExtern);
            
            Gesamtwert := Gesamtwert + LeseKartenDatenbanken.KampfZusatzgrund (GrundExtern    => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                                               SpeziesExtern  => SpeziesExtern,
                                                                               KampfartExtern => KampfartExtern);
            
            RessourceVorhanden := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
            VerbesserungVorhanden := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      end case;
      
      if
        RessourceVorhanden /= KartenextraDatentypen.Leer_Ressource_Enum
        and
          VerbesserungVorhanden /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Verbesserungsbonus := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => VerbesserungVorhanden,
                                                                              SpeziesExtern      => SpeziesExtern,
                                                                              KampfartExtern     => KampfartExtern);
         Ressourcenbonus := LeseKartenDatenbanken.KampfRessource (RessourceExtern => RessourceVorhanden,
                                                                  SpeziesExtern   => SpeziesExtern,
                                                                  KampfartExtern  => KampfartExtern);
         
      elsif
        RessourceVorhanden /= KartenextraDatentypen.Leer_Ressource_Enum
      then
         Ressourcenbonus := LeseKartenDatenbanken.KampfRessource (RessourceExtern => RessourceVorhanden,
                                                                  SpeziesExtern   => SpeziesExtern,
                                                                  KampfartExtern  => KampfartExtern);
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
         
      elsif
        VerbesserungVorhanden /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Verbesserungsbonus := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => VerbesserungVorhanden,
                                                                              SpeziesExtern      => SpeziesExtern,
                                                                              KampfartExtern     => KampfartExtern);
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         
      else
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
      end if;
            
      Wegbonus := LeseVerbesserungenDatenbank.KampfWeg (WegExtern      => LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern),
                                                        SpeziesExtern  => SpeziesExtern,
                                                        KampfartExtern => KampfartExtern);
      
      Flussbonus := LeseKartenDatenbanken.KampfFluss (FlussExtern    => LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern),
                                                      SpeziesExtern  => SpeziesExtern,
                                                      KampfartExtern => KampfartExtern);
      
      Feldeffektmalus := FeldeffektemalusFestlegen (KoordinatenExtern => KoordinatenExtern,
                                                    SpeziesExtern     => SpeziesExtern,
                                                    KampfartExtern    => KampfartExtern);
      
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
              := KampfDatentypen.KampfwerteAllgemein (ProduktionDatentypen.Produktionsbonus'Floor (ProduktionDatentypen.Produktionsbonus (Gesamtwert) * Ressourcenbonus * Verbesserungsbonus * Flussbonus * Wegbonus));
            
         when others =>
            Gesamtwert
              := KampfDatentypen.KampfwerteAllgemein (ProduktionDatentypen.Produktionsbonus'Ceiling (ProduktionDatentypen.Produktionsbonus (Gesamtwert) * Ressourcenbonus * Verbesserungsbonus * Flussbonus * Wegbonus));
      end case;
      
      -- Das ergibt bei Kampf eher wenig Sinn, oder? äöü
      if
        Gesamtwert < KampfKonstanten.LeerKampfwert
      then
         return KampfKonstanten.LeerKampfwert;
         
      else
         return Gesamtwert;
      end if;
      
   end Feldkampf;
   
   

   function FeldeffektemalusFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
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
                                                                         KommazahlZweiExtern => LeseEffekteDatenbank.Kampf (EffektExtern   => EffekteSchleifenwert,
                                                                                                                            SpeziesExtern  => SpeziesExtern,
                                                                                                                            KampfartExtern => KampfartExtern));
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
      return FeldeffektmalusZwischenspeicher;
      
   end FeldeffektemalusFestlegen;

end FeldkampfEinheitLogik;
