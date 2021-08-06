pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with KartenAllgemein;

package body ProduktionFeld is

   function FeldNahrung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundNahrung (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceNahrung (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.StraßeNahrung (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.VerbesserungNahrung (PositionExtern => KoordinatenExtern)
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
        + KartenAllgemein.StraßeRessourcen (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.VerbesserungRessourcen (PositionExtern => KoordinatenExtern)
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
        + KartenAllgemein.StraßeGeld (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.VerbesserungGeld (PositionExtern => KoordinatenExtern)
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
        + KartenAllgemein.StraßeWissen (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.VerbesserungWissen (PositionExtern => KoordinatenExtern)
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
        + KartenAllgemein.StraßeVerteidigung (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.FlussVerteidigung (PositionExtern => KoordinatenExtern,
                                             RasseExtern    => RasseExtern);
      
   end FeldVerteidigung;

end ProduktionFeld;
