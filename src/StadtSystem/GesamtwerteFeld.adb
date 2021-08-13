pragma SPARK_Mode (On);

with KartenAllgemein;

package body GesamtwerteFeld is

   function FeldNahrung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundNahrung (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceNahrung (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.WegNahrung (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungNahrung (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussNahrung (PositionExtern => KoordinatenExtern,
                                        RasseExtern    => RasseExtern);
      
   end FeldNahrung;
     
     
     
   function FeldProduktion
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundProduktion (PositionExtern => KoordinatenExtern,
                                              RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceProduktion (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.WegProduktion (PositionExtern => KoordinatenExtern,
                                         RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungProduktion (PositionExtern => KoordinatenExtern,
                                                  RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussProduktion (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern);
      
   end FeldProduktion;
     
     
     
   function FeldGeld
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundGeld (PositionExtern => KoordinatenExtern,
                                        RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceGeld (PositionExtern => KoordinatenExtern,
                                         RasseExtern    => RasseExtern)
        + KartenAllgemein.WegGeld (PositionExtern => KoordinatenExtern,
                                   RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungGeld (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussGeld (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern);
      
   end FeldGeld;
     
     
     
   function FeldWissen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundWissen (PositionExtern => KoordinatenExtern,
                                          RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceWissen (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.WegWissen (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungWissen (PositionExtern => KoordinatenExtern,
                                              RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussWissen (PositionExtern => KoordinatenExtern,
                                       RasseExtern    => RasseExtern);
      
   end FeldWissen;
     
     
     
   function FeldVerteidigung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundVerteidigung (PositionExtern => KoordinatenExtern,
                                                RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceVerteidigung (PositionExtern => KoordinatenExtern,
                                                 RasseExtern    => RasseExtern)
        + KartenAllgemein.WegVerteidigung (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => KoordinatenExtern,
                                                    RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussVerteidigung (PositionExtern => KoordinatenExtern,
                                             RasseExtern    => RasseExtern);
      
   end FeldVerteidigung;
     
     
     
   function FeldAngriff
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundAngriff (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceAngriff (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.WegAngriff (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungAngriff (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussAngriff (PositionExtern => KoordinatenExtern,
                                        RasseExtern    => RasseExtern);
      
   end FeldAngriff;

end GesamtwerteFeld;
