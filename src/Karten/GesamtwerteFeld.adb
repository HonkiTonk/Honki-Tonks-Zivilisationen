pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
use EinheitStadtDatentypen;

with KartenAllgemein;

package body GesamtwerteFeld is

   function FeldNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundNahrung (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceNahrung (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.WegNahrung (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungNahrung (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussNahrung (PositionExtern => KoordinatenExtern,
                                        RasseExtern    => RasseExtern)
        > EinheitStadtDatentypen.ProduktionFeld'Last
      then
         return EinheitStadtDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundNahrung (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceNahrung (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.WegNahrung (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungNahrung (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussNahrung (PositionExtern => KoordinatenExtern,
                                        RasseExtern    => RasseExtern)
        < EinheitStadtDatentypen.ProduktionFeld'First
      then
         return EinheitStadtDatentypen.ProduktionFeld'First;
         
      else
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
      end if;
      
   end FeldNahrung;
     
     
   
   function FeldProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundProduktion (PositionExtern => KoordinatenExtern,
                                         RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceProduktion (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.WegProduktion (PositionExtern => KoordinatenExtern,
                                         RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungProduktion (PositionExtern => KoordinatenExtern,
                                                  RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussProduktion (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        > EinheitStadtDatentypen.ProduktionFeld'Last
      then
         return EinheitStadtDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundProduktion (PositionExtern => KoordinatenExtern,
                                         RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceProduktion (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.WegProduktion (PositionExtern => KoordinatenExtern,
                                         RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungProduktion (PositionExtern => KoordinatenExtern,
                                                  RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussProduktion (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        < EinheitStadtDatentypen.ProduktionFeld'First
      then
         return EinheitStadtDatentypen.ProduktionFeld'First;
         
      else
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
      end if;
      
   end FeldProduktion;
     
     
     
   function FeldGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundGeld (PositionExtern => KoordinatenExtern,
                                   RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceGeld (PositionExtern => KoordinatenExtern,
                                         RasseExtern    => RasseExtern)
        + KartenAllgemein.WegGeld (PositionExtern => KoordinatenExtern,
                                   RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungGeld (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussGeld (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern)
        > EinheitStadtDatentypen.ProduktionFeld'Last
      then
         return EinheitStadtDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundGeld (PositionExtern => KoordinatenExtern,
                                   RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceGeld (PositionExtern => KoordinatenExtern,
                                         RasseExtern    => RasseExtern)
        + KartenAllgemein.WegGeld (PositionExtern => KoordinatenExtern,
                                   RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungGeld (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussGeld (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern)
        < EinheitStadtDatentypen.ProduktionFeld'First
      then
         return EinheitStadtDatentypen.ProduktionFeld'First;
         
      else
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
      end if;
      
   end FeldGeld;
     
     
     
   function FeldWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundWissen (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceWissen (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.WegWissen (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungWissen (PositionExtern => KoordinatenExtern,
                                              RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussWissen (PositionExtern => KoordinatenExtern,
                                       RasseExtern    => RasseExtern)
        > EinheitStadtDatentypen.ProduktionFeld'Last
      then
         return EinheitStadtDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundWissen (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceWissen (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.WegWissen (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungWissen (PositionExtern => KoordinatenExtern,
                                              RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussWissen (PositionExtern => KoordinatenExtern,
                                       RasseExtern    => RasseExtern)
        < EinheitStadtDatentypen.ProduktionFeld'First
      then
         return EinheitStadtDatentypen.ProduktionFeld'First;
         
      else
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
      end if;
      
   end FeldWissen;
     
     
     
   function FeldVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundVerteidigung (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceVerteidigung (PositionExtern => KoordinatenExtern,
                                                 RasseExtern    => RasseExtern)
        + KartenAllgemein.WegVerteidigung (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => KoordinatenExtern,
                                                    RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussVerteidigung (PositionExtern => KoordinatenExtern,
                                             RasseExtern    => RasseExtern)
        > EinheitStadtDatentypen.ProduktionFeld'Last
      then
         return EinheitStadtDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundVerteidigung (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceVerteidigung (PositionExtern => KoordinatenExtern,
                                                 RasseExtern    => RasseExtern)
        + KartenAllgemein.WegVerteidigung (PositionExtern => KoordinatenExtern,
                                           RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => KoordinatenExtern,
                                                    RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussVerteidigung (PositionExtern => KoordinatenExtern,
                                             RasseExtern    => RasseExtern)
        < EinheitStadtDatentypen.ProduktionFeld'First
      then
         return EinheitStadtDatentypen.ProduktionFeld'First;
         
      else
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
      end if;
      
   end FeldVerteidigung;
     
     
     
   function FeldAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundAngriff (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceAngriff (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.WegAngriff (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungAngriff (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussAngriff (PositionExtern => KoordinatenExtern,
                                        RasseExtern    => RasseExtern)
        > EinheitStadtDatentypen.ProduktionFeld'Last
      then
         return EinheitStadtDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundAngriff (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.RessourceAngriff (PositionExtern => KoordinatenExtern,
                                            RasseExtern    => RasseExtern)
        + KartenAllgemein.WegAngriff (PositionExtern => KoordinatenExtern,
                                      RasseExtern    => RasseExtern)
        + KartenAllgemein.VerbesserungAngriff (PositionExtern => KoordinatenExtern,
                                               RasseExtern    => RasseExtern)
        + KartenAllgemein.FlussAngriff (PositionExtern => KoordinatenExtern,
                                        RasseExtern    => RasseExtern)
        < EinheitStadtDatentypen.ProduktionFeld'First
      then
         return EinheitStadtDatentypen.ProduktionFeld'First;
         
      else
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
      end if;
      
   end FeldAngriff;

end GesamtwerteFeld;
