with ProduktionKonstanten;

with LeseEffekteDatenbank;
with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

with Produktionsgrenzen;

-- Wie bei den Kampfwerten aufbauen, allerdings mit Basis/Zusatzgrund als Grundwert. äöü
-- Keine Separierung nötig, da die Logik das nur noch Rundenende aufruft und die Grafik nur während einer Runde.
-- Das System hier und das System zur Berechnung der Kampfwerte haben ein Problem. Wenn Irgendwo die Werte das Maximum überschreiten dann erhält man am Schluss bei den Effekten weniger als möglich. äöü
-- Irgendwann mal anpasssen. äöü
package body FeldproduktionLogik is
   
   function Feldproduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
     -- Datentypen in ProduktionDatentypen mal an das nweue System anpassen. äöü
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        Basisgrund
      is
         when KartengrundDatentypen.Vernichtet_Enum =>
            -- Das beist sich ein wenig mit der Möglichkeit eine Stadt auf vernichtet zu bauen. Ändern oder einfach so lassen und sagen das ist ein Spielerproblem? äöü
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            Gesamtwert := LeseKartenDatenbanken.ProduktionBasisgrund (GrundExtern          => Basisgrund,
                                                                      SpeziesExtern        => SpeziesExtern,
                                                                      ProduktionsartExtern => ProduktionsartExtern)
              + LeseKartenDatenbanken.ProduktionZusatzgrund (GrundExtern          => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                             SpeziesExtern        => SpeziesExtern,
                                                             ProduktionsartExtern => ProduktionsartExtern);
      end case;
      
      if
        Gesamtwert <= ProduktionKonstanten.LeerProduktion
      then
         return ProduktionKonstanten.LeerProduktion;
         
      else
         -- Das hioer noch einmal ein wenig übersichtlicher schreiben. äöü
         Gesamtwert := Produktionsgrenzen.ProduktionswertProduktionsbonus (ProduktionswertExtern  => Gesamtwert,
                                                                           ProduktionsbonusExtern =>
                                                                             LeseVerbesserungenDatenbank.ProduktionVerbesserung (VerbesserungExtern   => LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern),
                                                                                                                                 SpeziesExtern        => SpeziesExtern,
                                                                                                                                 ProduktionsartExtern => ProduktionsartExtern));
         
         Gesamtwert := Produktionsgrenzen.ProduktionswertProduktionsbonus (ProduktionswertExtern  => Gesamtwert,
                                                                           ProduktionsbonusExtern =>
                                                                             LeseKartenDatenbanken.ProduktionRessourcen (RessourceExtern      => LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern),
                                                                                                                         SpeziesExtern        => SpeziesExtern,
                                                                                                                         ProduktionsartExtern => ProduktionsartExtern));
         
         Gesamtwert := Produktionsgrenzen.ProduktionswertProduktionsbonus (ProduktionswertExtern  => Gesamtwert,
                                                                           ProduktionsbonusExtern =>
                                                                             LeseVerbesserungenDatenbank.ProduktionWeg (WegExtern            => LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern),
                                                                                                                        SpeziesExtern        => SpeziesExtern,
                                                                                                                        ProduktionsartExtern => ProduktionsartExtern));
         
         Gesamtwert := Produktionsgrenzen.ProduktionswertProduktionsbonus (ProduktionswertExtern  => Gesamtwert,
                                                                           ProduktionsbonusExtern =>
                                                                             LeseKartenDatenbanken.ProduktionFluss (FlussExtern          => LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern),
                                                                                                                    SpeziesExtern        => SpeziesExtern,
                                                                                                                    ProduktionsartExtern => ProduktionsartExtern));
      end if;
      
      EffekteSchleife:
      for EffekteSchleifenwert in KartenRecords.FeldeffektArray'Range loop
         
         case
           LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                 WelcherEffektExtern => EffekteSchleifenwert)
         is
            when True =>
               Gesamtwert := Produktionsgrenzen.ProduktionswertProduktionsbonus (ProduktionswertExtern  => Gesamtwert,
                                                                                 ProduktionsbonusExtern => LeseEffekteDatenbank.Produktion (EffektExtern         => EffekteSchleifenwert,
                                                                                                                                            SpeziesExtern        => SpeziesExtern,
                                                                                                                                            ProduktionsartExtern => ProduktionsartExtern));
               
            when False =>
               null;
         end case;
      
      end loop EffekteSchleife;
      
      return Gesamtwert;
      
   end Feldproduktion;

end FeldproduktionLogik;
