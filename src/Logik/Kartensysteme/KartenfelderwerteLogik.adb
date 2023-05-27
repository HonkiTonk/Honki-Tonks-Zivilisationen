with ProduktionKonstanten;
with KartenKonstanten;
with KampfKonstanten;
with SpielDatentypen;

with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseAllgemeines;
with LeseVerbesserungenDatenbank;

with KartenAllgemeinesLogik;
with KartenfeldereffekteLogik;

-- Das hier wird von Logik und Grafik aufgerufen, zum Berechnen der Stadtproduktion bei Rundenende und zur Anzeige der aktuellen Produktionswerte eines Feldes.
-- Sollte aber keine Probleme machen, da man nicht gleichzeitig in der Stadt und im Rundenende sein kann.
-- Aber könnte das nicht auch bei einer Umbelegung gleichzeitig aufgerufen werden? äöü
-- Eventuell doch negative Produktion zulassen? Nach dem Motto es kostet je auch was etwas zu bewirtschaften was nichts erbringt. äöü
package body KartenfelderwerteLogik is

   function FeldNahrung
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
                                                                      WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
            
            Gesamtwert := Gesamtwert + LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                                                    SpeziesExtern       => SpeziesExtern,
                                                                                    WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
            
            RessourceVorhanden := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
            VerbesserungVorhanden := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      end case;
      
      if
        RessourceVorhanden /= KartenextraDatentypen.Leer_Ressource_Enum
        and
          VerbesserungVorhanden /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         
      elsif
        RessourceVorhanden /= KartenextraDatentypen.Leer_Ressource_Enum
      then
         Ressourcenbonus := LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => RessourceVorhanden,
                                                                        SpeziesExtern       => SpeziesExtern,
                                                                        WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
         
      elsif
        VerbesserungVorhanden /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Verbesserungsbonus := LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => VerbesserungVorhanden,
                                                                                   SpeziesExtern      => SpeziesExtern,
                                                                                   WelcherWertExtern  => KartenKonstanten.WirtschaftNahrung);
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         
      else
         Ressourcenbonus := ProduktionKonstanten.LeerBonus;
         Verbesserungsbonus := ProduktionKonstanten.LeerBonus;
      end if;
      
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
           
         --      + KartenAllgemeinesLogik.WegNahrung (KoordinatenExtern => KoordinatenExtern,
         --                                           SpeziesExtern     => SpeziesExtern)
         --      + KartenAllgemeinesLogik.FlussNahrung (KoordinatenExtern => KoordinatenExtern,
         --                                             SpeziesExtern     => SpeziesExtern))
         -- / Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern));
      end if;
      
   end FeldNahrung;
     
   
   
   function FeldProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        Gesamtwert < ProduktionKonstanten.LeerProduktion
      then
         return ProduktionKonstanten.LeerProduktion;
         
      else
         return (KartenAllgemeinesLogik.GrundProduktion (KoordinatenExtern => KoordinatenExtern,
                                                         SpeziesExtern     => SpeziesExtern)
                 -- + KartenAllgemeinesLogik.RessourceProduktion (KoordinatenExtern => KoordinatenExtern,
                 --                                              SpeziesExtern     => SpeziesExtern)
                 + KartenAllgemeinesLogik.WegProduktion (KoordinatenExtern => KoordinatenExtern,
                                                         SpeziesExtern     => SpeziesExtern)
                 -- + KartenAllgemeinesLogik.VerbesserungProduktion (KoordinatenExtern => KoordinatenExtern,
                 --                                                  SpeziesExtern     => SpeziesExtern)
                 + KartenAllgemeinesLogik.FlussProduktion (KoordinatenExtern => KoordinatenExtern,
                                                           SpeziesExtern     => SpeziesExtern))
           / Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern));
      end if;
      
   end FeldProduktion;
     
     
     
   function FeldGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        Gesamtwert < ProduktionKonstanten.LeerProduktion
      then
         return ProduktionKonstanten.LeerProduktion;
         
      else
         return (KartenAllgemeinesLogik.GrundGeld (KoordinatenExtern => KoordinatenExtern,
                                                   SpeziesExtern     => SpeziesExtern)
                 -- + KartenAllgemeinesLogik.RessourceGeld (KoordinatenExtern => KoordinatenExtern,
                 --                                         SpeziesExtern     => SpeziesExtern)
                 + KartenAllgemeinesLogik.WegGeld (KoordinatenExtern => KoordinatenExtern,
                                                   SpeziesExtern     => SpeziesExtern)
                 --  + KartenAllgemeinesLogik.VerbesserungGeld (KoordinatenExtern => KoordinatenExtern,
                 --                                             SpeziesExtern     => SpeziesExtern)
                 + KartenAllgemeinesLogik.FlussGeld (KoordinatenExtern => KoordinatenExtern,
                                                     SpeziesExtern     => SpeziesExtern))
           / Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern));
      end if;
      
   end FeldGeld;
     
     
     
   function FeldWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        Gesamtwert < ProduktionKonstanten.LeerProduktion
      then
         return ProduktionKonstanten.LeerProduktion;
         
      else
         return KartenAllgemeinesLogik.GrundWissen (KoordinatenExtern => KoordinatenExtern,
                                                    SpeziesExtern     => SpeziesExtern)
           --  + KartenAllgemeinesLogik.RessourceWissen (KoordinatenExtern => KoordinatenExtern,
           --                                           SpeziesExtern     => SpeziesExtern)
           + KartenAllgemeinesLogik.WegWissen (KoordinatenExtern => KoordinatenExtern,
                                               SpeziesExtern     => SpeziesExtern)
           -- + KartenAllgemeinesLogik.VerbesserungWissen (KoordinatenExtern => KoordinatenExtern,
           --                                              SpeziesExtern     => SpeziesExtern)
           + KartenAllgemeinesLogik.FlussWissen (KoordinatenExtern => KoordinatenExtern,
                                                 SpeziesExtern     => SpeziesExtern);
      end if;
      
   end FeldWissen;
     
     
     
   function FeldVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is
      use type KampfDatentypen.KampfwerteGroß;
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        Gesamtwert < ProduktionKonstanten.LeerProduktion
      then
         return KampfKonstanten.LeerKampfwert;
         
      else
         return (KartenAllgemeinesLogik.GrundVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                           SpeziesExtern     => SpeziesExtern)
                 --  + KartenAllgemeinesLogik.RessourceVerteidigung (KoordinatenExtern => KoordinatenExtern,
                 --                                                 SpeziesExtern     => SpeziesExtern)
                 + KartenAllgemeinesLogik.WegVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                           SpeziesExtern     => SpeziesExtern)
                 -- + KartenAllgemeinesLogik.VerbesserungVerteidigung (KoordinatenExtern => KoordinatenExtern,
                 --                                                    SpeziesExtern     => SpeziesExtern)
                 + KartenAllgemeinesLogik.FlussVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                             SpeziesExtern     => SpeziesExtern))
           / KampfDatentypen.KampfwerteAllgemein (Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern)));
      end if;
      
   end FeldVerteidigung;
     
     
     
   function FeldAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is
      use type KampfDatentypen.KampfwerteGroß;
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        Gesamtwert < ProduktionKonstanten.LeerProduktion
      then
         return KampfKonstanten.LeerKampfwert;
         
      else
         return (KartenAllgemeinesLogik.GrundAngriff (KoordinatenExtern => KoordinatenExtern,
                                                      SpeziesExtern     => SpeziesExtern)
                 --  + KartenAllgemeinesLogik.RessourceAngriff (KoordinatenExtern => KoordinatenExtern,
                 --                                            SpeziesExtern     => SpeziesExtern)
                 + KartenAllgemeinesLogik.WegAngriff (KoordinatenExtern => KoordinatenExtern,
                                                      SpeziesExtern     => SpeziesExtern)
                 -- + KartenAllgemeinesLogik.VerbesserungAngriff (KoordinatenExtern => KoordinatenExtern,
                 --                                               SpeziesExtern     => SpeziesExtern)
                 + KartenAllgemeinesLogik.FlussAngriff (KoordinatenExtern => KoordinatenExtern,
                                                        SpeziesExtern     => SpeziesExtern))
           / KampfDatentypen.KampfwerteAllgemein (Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern)));
      end if;
      
   end FeldAngriff;

end KartenfelderwerteLogik;
