with KartenAllgemeinesLogik;
with KartenfeldereffekteLogik;

-- Das hier wird von Logik und Grafik aufgerufen, zum Berechnen der Stadtproduktion bei Rundenende und zur Anzeige der aktuellen Produktionswerte eines Feldes.
-- Sollte aber keine Probleme machen, da man nicht gleichzeitig in der Stadt und im Rundenende sein kann.
package body KartenfelderwerteLogik is

   function FeldNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return (KartenAllgemeinesLogik.GrundNahrung (KoordinatenExtern => KoordinatenExtern,
                                                   SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.RessourceNahrung (KoordinatenExtern => KoordinatenExtern,
                                                         SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.WegNahrung (KoordinatenExtern => KoordinatenExtern,
                                                   SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.VerbesserungNahrung (KoordinatenExtern => KoordinatenExtern,
                                                            SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.FlussNahrung (KoordinatenExtern => KoordinatenExtern,
                                                     SpeziesExtern     => SpeziesExtern))
        / Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern));
      
   end FeldNahrung;
     
   
   
   function FeldProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return (KartenAllgemeinesLogik.GrundProduktion (KoordinatenExtern => KoordinatenExtern,
                                                      SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.RessourceProduktion (KoordinatenExtern => KoordinatenExtern,
                                                            SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.WegProduktion (KoordinatenExtern => KoordinatenExtern,
                                                      SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.VerbesserungProduktion (KoordinatenExtern => KoordinatenExtern,
                                                               SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.FlussProduktion (KoordinatenExtern => KoordinatenExtern,
                                                        SpeziesExtern     => SpeziesExtern))
        / Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern));
      
   end FeldProduktion;
     
     
     
   function FeldGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return (KartenAllgemeinesLogik.GrundGeld (KoordinatenExtern => KoordinatenExtern,
                                                SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.RessourceGeld (KoordinatenExtern => KoordinatenExtern,
                                                      SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.WegGeld (KoordinatenExtern => KoordinatenExtern,
                                                SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.VerbesserungGeld (KoordinatenExtern => KoordinatenExtern,
                                                         SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.FlussGeld (KoordinatenExtern => KoordinatenExtern,
                                                  SpeziesExtern     => SpeziesExtern))
        / Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern));
      
   end FeldGeld;
     
     
     
   function FeldWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return KartenAllgemeinesLogik.GrundWissen (KoordinatenExtern => KoordinatenExtern,
                                                 SpeziesExtern     => SpeziesExtern)
        + KartenAllgemeinesLogik.RessourceWissen (KoordinatenExtern => KoordinatenExtern,
                                                  SpeziesExtern     => SpeziesExtern)
        + KartenAllgemeinesLogik.WegWissen (KoordinatenExtern => KoordinatenExtern,
                                            SpeziesExtern     => SpeziesExtern)
        + KartenAllgemeinesLogik.VerbesserungWissen (KoordinatenExtern => KoordinatenExtern,
                                                     SpeziesExtern     => SpeziesExtern)
        + KartenAllgemeinesLogik.FlussWissen (KoordinatenExtern => KoordinatenExtern,
                                              SpeziesExtern     => SpeziesExtern);
      
   end FeldWissen;
     
     
     
   function FeldVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      return (KartenAllgemeinesLogik.GrundVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                        SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.RessourceVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                              SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.WegVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                        SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.VerbesserungVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                                 SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.FlussVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                          SpeziesExtern     => SpeziesExtern))
        / KampfDatentypen.KampfwerteAllgemein (Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern)));
      
   end FeldVerteidigung;
     
     
     
   function FeldAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      return (KartenAllgemeinesLogik.GrundAngriff (KoordinatenExtern => KoordinatenExtern,
                                                   SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.RessourceAngriff (KoordinatenExtern => KoordinatenExtern,
                                                         SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.WegAngriff (KoordinatenExtern => KoordinatenExtern,
                                                   SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.VerbesserungAngriff (KoordinatenExtern => KoordinatenExtern,
                                                            SpeziesExtern     => SpeziesExtern)
              + KartenAllgemeinesLogik.FlussAngriff (KoordinatenExtern => KoordinatenExtern,
                                                     SpeziesExtern     => SpeziesExtern))
        / KampfDatentypen.KampfwerteAllgemein (Feldeffektteiler (KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => KoordinatenExtern)));
      
   end FeldAngriff;

end KartenfelderwerteLogik;
