with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;
with LeseEffekteDatenbank;

with Kampfgrenzen;

package body FeldkampfStadtLogik is

   function Feldkampf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum;
      KampfBasiswertExtern : in KampfDatentypen.KampfwerteAllgemein;
      StadttypExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        Basisgrund
      is
         when KartengrundDatentypen.Vernichtet_Enum =>
            return KampfBasiswertExtern;
            
         when others =>
            Gesamtwert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => KampfBasiswertExtern,
                                                            KampfbonusExtern => LeseKartenDatenbanken.KampfBasisgrund (GrundExtern    => Basisgrund,
                                                                                                                       SpeziesExtern  => SpeziesExtern,
                                                                                                                       KampfartExtern => KampfartExtern));
            
            Gesamtwert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert,
                                                            KampfbonusExtern => LeseKartenDatenbanken.KampfZusatzgrund (GrundExtern    => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                                                                                        SpeziesExtern  => SpeziesExtern,
                                                                                                                        KampfartExtern => KampfartExtern));
            
            Gesamtwert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert,
                                                            KampfbonusExtern => LeseKartenDatenbanken.KampfRessource (RessourceExtern => LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern),
                                                                                                                      SpeziesExtern   => SpeziesExtern,
                                                                                                                      KampfartExtern  => KampfartExtern));
            
            Gesamtwert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert,
                                                            KampfbonusExtern => LeseVerbesserungenDatenbank.KampfWeg (WegExtern      => LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern),
                                                                                                                      SpeziesExtern  => SpeziesExtern,
                                                                                                                      KampfartExtern => KampfartExtern));
            
            Gesamtwert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert,
                                                            KampfbonusExtern => LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => StadttypExtern,
                                                                                                                               SpeziesExtern      => SpeziesExtern,
                                                                                                                               KampfartExtern     => KampfartExtern));
            
            Gesamtwert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert,
                                                            KampfbonusExtern => LeseKartenDatenbanken.KampfFluss (FlussExtern    => LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern),
                                                                                                                  SpeziesExtern  => SpeziesExtern,
                                                                                                                  KampfartExtern => KampfartExtern));
            
            FeldeffekteVorhanden := LeseWeltkarte.Feldeffekte (KoordinatenExtern => KoordinatenExtern);
      end case;
      
      EffekteSchleife:
      for EffekteSchleifenwert in FeldeffekteVorhanden'Range loop
         
         case
           FeldeffekteVorhanden (EffekteSchleifenwert)
         is
            when True =>
               Gesamtwert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert,
                                                               KampfbonusExtern => LeseEffekteDatenbank.Kampf (EffektExtern   => EffekteSchleifenwert,
                                                                                                               SpeziesExtern  => SpeziesExtern,
                                                                                                               KampfartExtern => KampfartExtern));
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
      return Gesamtwert;

   end Feldkampf;

end FeldkampfStadtLogik;
