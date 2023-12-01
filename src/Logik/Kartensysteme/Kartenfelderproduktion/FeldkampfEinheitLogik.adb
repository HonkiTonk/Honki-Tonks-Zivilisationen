with KartengrundDatentypen;

with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;
with LeseEffekteDatenbank;

with Kampfgrenzen;

-- Mal nicht mit FeldkampfStadtLogik zusammenführen, für den Fall das ich später noch spezielle Einheitenmodifikationen einbauen will.
package body FeldkampfEinheitLogik is

   function Feldkampf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum;
      KampfBasiswertExtern : in KampfDatentypen.KampfwerteEinheiten;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern)
      is
         when KartengrundDatentypen.Vernichtet_Enum =>
            return KampfBasiswertExtern;
            
         when others =>
            Gesamtwert (TaskExtern)
              := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => KampfBasiswertExtern,
                                                   KampfbonusExtern => LeseKartenDatenbanken.KampfBasisgrund (GrundExtern    => LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern),
                                                                                                              SpeziesExtern  => SpeziesExtern,
                                                                                                              KampfartExtern => KampfartExtern));
            
            Gesamtwert (TaskExtern)
              := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert (TaskExtern),
                                                   KampfbonusExtern => LeseKartenDatenbanken.KampfZusatzgrund (GrundExtern    => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                                                                               SpeziesExtern  => SpeziesExtern,
                                                                                                               KampfartExtern => KampfartExtern));
            
            Gesamtwert (TaskExtern) := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert (TaskExtern),
                                                                         KampfbonusExtern => LeseKartenDatenbanken.KampfRessource (RessourceExtern => LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern),
                                                                                                                                   SpeziesExtern   => SpeziesExtern,
                                                                                                                                   KampfartExtern  => KampfartExtern));
            
            Gesamtwert (TaskExtern) := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert (TaskExtern),
                                                                         KampfbonusExtern => LeseVerbesserungenDatenbank.KampfWeg (WegExtern      => LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern),
                                                                                                                                   SpeziesExtern  => SpeziesExtern,
                                                                                                                                   KampfartExtern => KampfartExtern));
            
            Gesamtwert (TaskExtern)
              := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert (TaskExtern),
                                                   KampfbonusExtern => LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern),
                                                                                                                      SpeziesExtern      => SpeziesExtern,
                                                                                                                      KampfartExtern     => KampfartExtern));
            
            Gesamtwert (TaskExtern) := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert (TaskExtern),
                                                                         KampfbonusExtern => LeseKartenDatenbanken.KampfFluss (FlussExtern    => LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern),
                                                                                                                               SpeziesExtern  => SpeziesExtern,
                                                                                                                               KampfartExtern => KampfartExtern));
      end case;
      
      EffekteSchleife:
      for EffekteSchleifenwert in KartenRecords.FeldeffektArray'Range loop
         
         case
           LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                 WelcherEffektExtern => EffekteSchleifenwert)
         is
            when True =>
               Gesamtwert (TaskExtern) := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Gesamtwert (TaskExtern),
                                                                            KampfbonusExtern => LeseEffekteDatenbank.Kampf (EffektExtern   => EffekteSchleifenwert,
                                                                                                                            SpeziesExtern  => SpeziesExtern,
                                                                                                                            KampfartExtern => KampfartExtern));
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
      return Gesamtwert (TaskExtern);
      
   end Feldkampf;

end FeldkampfEinheitLogik;
