with ProduktionKonstanten;
with KampfKonstanten;

with KartenAllgemeinesLogik;
with KartenfeldereffekteLogik;

-- Das hier wird von Logik und Grafik aufgerufen, zum Berechnen der Stadtproduktion bei Rundenende und zur Anzeige der aktuellen Produktionswerte eines Feldes.
-- Sollte aber keine Probleme machen, da man nicht gleichzeitig in der Stadt und im Rundenende sein kann.
-- Aber könnte das nicht auch bei einer Umbelegung gleichzeitig aufgerufen werden? äöü
-- Eventuell doch negative Produktion zulassen? Nach dem Motto es kostet je auch was etwas zu bewirtschaften was nichts erbringt. äöü
package body KartenfelderwerteLogik is
      
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
                -- + KartenAllgemeinesLogik.WegProduktion (KoordinatenExtern => KoordinatenExtern,
                 --                                        SpeziesExtern     => SpeziesExtern)
                 -- + KartenAllgemeinesLogik.VerbesserungProduktion (KoordinatenExtern => KoordinatenExtern,
                 --                                                  SpeziesExtern     => SpeziesExtern)
                -- + KartenAllgemeinesLogik.FlussProduktion (KoordinatenExtern => KoordinatenExtern,
               --                                            SpeziesExtern     => SpeziesExtern))
           / Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern)));
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
                -- + KartenAllgemeinesLogik.WegGeld (KoordinatenExtern => KoordinatenExtern,
               --                                    SpeziesExtern     => SpeziesExtern)
                 --  + KartenAllgemeinesLogik.VerbesserungGeld (KoordinatenExtern => KoordinatenExtern,
                 --                                             SpeziesExtern     => SpeziesExtern)
                -- + KartenAllgemeinesLogik.FlussGeld (KoordinatenExtern => KoordinatenExtern,
                --                                     SpeziesExtern     => SpeziesExtern))
           / Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern)));
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
                                                    SpeziesExtern     => SpeziesExtern);
           --  + KartenAllgemeinesLogik.RessourceWissen (KoordinatenExtern => KoordinatenExtern,
           --                                           SpeziesExtern     => SpeziesExtern)
          -- + KartenAllgemeinesLogik.WegWissen (KoordinatenExtern => KoordinatenExtern,
          --                                     SpeziesExtern     => SpeziesExtern)
           -- + KartenAllgemeinesLogik.VerbesserungWissen (KoordinatenExtern => KoordinatenExtern,
           --                                              SpeziesExtern     => SpeziesExtern)
         --  + KartenAllgemeinesLogik.FlussWissen (KoordinatenExtern => KoordinatenExtern,
          --                                       SpeziesExtern     => SpeziesExtern);
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
               --  + KartenAllgemeinesLogik.WegVerteidigung (KoordinatenExtern => KoordinatenExtern,
               --                                            SpeziesExtern     => SpeziesExtern)
                 -- + KartenAllgemeinesLogik.VerbesserungVerteidigung (KoordinatenExtern => KoordinatenExtern,
                 --                                                    SpeziesExtern     => SpeziesExtern)
               --  + KartenAllgemeinesLogik.FlussVerteidigung (KoordinatenExtern => KoordinatenExtern,
               --                                              SpeziesExtern     => SpeziesExtern))
           / KampfDatentypen.KampfwerteAllgemein (Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern))));
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
                -- + KartenAllgemeinesLogik.WegAngriff (KoordinatenExtern => KoordinatenExtern,
               --                                       SpeziesExtern     => SpeziesExtern)
                 -- + KartenAllgemeinesLogik.VerbesserungAngriff (KoordinatenExtern => KoordinatenExtern,
                 --                                               SpeziesExtern     => SpeziesExtern)
               --  + KartenAllgemeinesLogik.FlussAngriff (KoordinatenExtern => KoordinatenExtern,
               --                                         SpeziesExtern     => SpeziesExtern))
           / KampfDatentypen.KampfwerteAllgemein (Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern))));
      end if;
      
   end FeldAngriff;

end KartenfelderwerteLogik;
