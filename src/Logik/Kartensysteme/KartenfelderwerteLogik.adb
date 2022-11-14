with KartenAllgemeinesLogik;

package body KartenfelderwerteLogik is

   function FeldNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return KartenAllgemeinesLogik.GrundNahrung (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.RessourceNahrung (KoordinatenExtern => KoordinatenExtern,
                                                   RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.WegNahrung (KoordinatenExtern => KoordinatenExtern,
                                             RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.VerbesserungNahrung (KoordinatenExtern => KoordinatenExtern,
                                                      RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.FlussNahrung (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern);
      
   end FeldNahrung;
     
     
   
   function FeldProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return KartenAllgemeinesLogik.GrundProduktion (KoordinatenExtern => KoordinatenExtern,
                                                     RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.RessourceProduktion (KoordinatenExtern => KoordinatenExtern,
                                                      RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.WegProduktion (KoordinatenExtern => KoordinatenExtern,
                                                RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.VerbesserungProduktion (KoordinatenExtern => KoordinatenExtern,
                                                         RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.FlussProduktion (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern);
      
   end FeldProduktion;
     
     
     
   function FeldGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return KartenAllgemeinesLogik.GrundGeld (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.RessourceGeld (KoordinatenExtern => KoordinatenExtern,
                                                RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.WegGeld (KoordinatenExtern => KoordinatenExtern,
                                          RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.VerbesserungGeld (KoordinatenExtern => KoordinatenExtern,
                                                   RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.FlussGeld (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern);
      
   end FeldGeld;
     
     
     
   function FeldWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return KartenAllgemeinesLogik.GrundWissen (KoordinatenExtern => KoordinatenExtern,
                                                 RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.RessourceWissen (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.WegWissen (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.VerbesserungWissen (KoordinatenExtern => KoordinatenExtern,
                                                     RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.FlussWissen (KoordinatenExtern => KoordinatenExtern,
                                              RasseExtern       => RasseExtern);
      
   end FeldWissen;
     
     
     
   function FeldVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      return KartenAllgemeinesLogik.GrundVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                       RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.RessourceVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                        RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.WegVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.VerbesserungVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                           RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.FlussVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                    RasseExtern       => RasseExtern);
      
   end FeldVerteidigung;
     
     
     
   function FeldAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      return KartenAllgemeinesLogik.GrundAngriff (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.RessourceAngriff (KoordinatenExtern => KoordinatenExtern,
                                                   RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.WegAngriff (KoordinatenExtern => KoordinatenExtern,
                                             RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.VerbesserungAngriff (KoordinatenExtern => KoordinatenExtern,
                                                      RasseExtern       => RasseExtern)
        + KartenAllgemeinesLogik.FlussAngriff (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern);
      
   end FeldAngriff;

end KartenfelderwerteLogik;
