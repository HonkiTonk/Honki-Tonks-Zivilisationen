with KampfKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;
with LeseEffekteDatenbank;

package body FeldkampfStadtLogik is

   function Feldkampf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        Basisgrund
      is
         when KartengrundDatentypen.Vernichtet_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseKartenDatenbanken.KampfBasisgrund (GrundExtern    => Basisgrund,
                                                          SpeziesExtern  => SpeziesExtern,
                                                          KampfartExtern => KampfartExtern)
              + LeseKartenDatenbanken.KampfZusatzgrund (GrundExtern    => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                        SpeziesExtern  => SpeziesExtern,
                                                        KampfartExtern => KampfartExtern)
              + LeseKartenDatenbanken.KampfRessource (RessourceExtern => LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern),
                                                      SpeziesExtern   => SpeziesExtern,
                                                      KampfartExtern  => KampfartExtern)
              + LeseVerbesserungenDatenbank.KampfWeg (WegExtern      => LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern),
                                                      SpeziesExtern  => SpeziesExtern,
                                                      KampfartExtern => KampfartExtern)
              + LeseKartenDatenbanken.KampfFluss (FlussExtern    => LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern),
                                                  SpeziesExtern  => SpeziesExtern,
                                                  KampfartExtern => KampfartExtern);
      end case;

   end Feldkampf;
   
   

   function FeldeffektemalusFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
   is
      use type KartenRecords.FeldeffektArray;
   begin
      
      FeldeffekteVorhanden := LeseWeltkarte.Feldeffekte (KoordinatenExtern => KoordinatenExtern);
      
      if
        FeldeffekteVorhanden = KartenRecordKonstanten.LeerEffekte
      then
         return KampfKonstanten.LeerBonus;
         
      else
         Feldeffektmalus := KampfKonstanten.LeerBonus;
      end if;
      
      EffekteSchleife:
      for EffekteSchleifenwert in FeldeffekteVorhanden'Range loop
         
         case
           FeldeffekteVorhanden (EffekteSchleifenwert)
         is
            when True =>
               Feldeffektmalus := MultiplikationPrüfen (KommazahlEinsExtern => Feldeffektmalus,
                                                         KommazahlZweiExtern => LeseEffekteDatenbank.Kampf (EffektExtern   => EffekteSchleifenwert,
                                                                                                            SpeziesExtern  => SpeziesExtern,
                                                                                                            KampfartExtern => KampfartExtern));
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
      return Feldeffektmalus;
      
   end FeldeffektemalusFestlegen;

end FeldkampfStadtLogik;
