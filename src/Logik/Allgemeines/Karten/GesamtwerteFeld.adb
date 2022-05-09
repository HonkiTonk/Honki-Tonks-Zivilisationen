pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with KampfDatentypen; use KampfDatentypen;

with KartenAllgemein;

package body GesamtwerteFeld is

   function FeldNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundNahrung (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceNahrung (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
        + KartenAllgemein.WegNahrung (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungNahrung (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussNahrung (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => RasseExtern)
        > ProduktionDatentypen.ProduktionFeld'Last
      then
         return ProduktionDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundNahrung (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceNahrung (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
        + KartenAllgemein.WegNahrung (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungNahrung (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussNahrung (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => RasseExtern)
        < ProduktionDatentypen.ProduktionFeld'First
      then
         return ProduktionDatentypen.ProduktionFeld'First;
         
      else
         return KartenAllgemein.GrundNahrung (KoordinatenExtern => KoordinatenExtern,
                                              RasseExtern       => RasseExtern)
           + KartenAllgemein.RessourceNahrung (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
           + KartenAllgemein.WegNahrung (KoordinatenExtern => KoordinatenExtern,
                                         RasseExtern       => RasseExtern)
           + KartenAllgemein.VerbesserungNahrung (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
           + KartenAllgemein.FlussNahrung (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern);
      end if;
      
   end FeldNahrung;
     
     
   
   function FeldProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundProduktion (KoordinatenExtern => KoordinatenExtern,
                                         RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceProduktion (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
        + KartenAllgemein.WegProduktion (KoordinatenExtern => KoordinatenExtern,
                                         RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungProduktion (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussProduktion (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
        > ProduktionDatentypen.ProduktionFeld'Last
      then
         return ProduktionDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundProduktion (KoordinatenExtern => KoordinatenExtern,
                                         RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceProduktion (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
        + KartenAllgemein.WegProduktion (KoordinatenExtern => KoordinatenExtern,
                                         RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungProduktion (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussProduktion (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
        < ProduktionDatentypen.ProduktionFeld'First
      then
         return ProduktionDatentypen.ProduktionFeld'First;
         
      else
         return KartenAllgemein.GrundProduktion (KoordinatenExtern => KoordinatenExtern,
                                                 RasseExtern       => RasseExtern)
           + KartenAllgemein.RessourceProduktion (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
           + KartenAllgemein.WegProduktion (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
           + KartenAllgemein.VerbesserungProduktion (KoordinatenExtern => KoordinatenExtern,
                                                     RasseExtern       => RasseExtern)
           + KartenAllgemein.FlussProduktion (KoordinatenExtern => KoordinatenExtern,
                                              RasseExtern       => RasseExtern);
      end if;
      
   end FeldProduktion;
     
     
     
   function FeldGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundGeld (KoordinatenExtern => KoordinatenExtern,
                                   RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceGeld (KoordinatenExtern => KoordinatenExtern,
                                         RasseExtern       => RasseExtern)
        + KartenAllgemein.WegGeld (KoordinatenExtern => KoordinatenExtern,
                                   RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungGeld (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussGeld (KoordinatenExtern => KoordinatenExtern,
                                     RasseExtern       => RasseExtern)
        > ProduktionDatentypen.ProduktionFeld'Last
      then
         return ProduktionDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundGeld (KoordinatenExtern => KoordinatenExtern,
                                   RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceGeld (KoordinatenExtern => KoordinatenExtern,
                                         RasseExtern       => RasseExtern)
        + KartenAllgemein.WegGeld (KoordinatenExtern => KoordinatenExtern,
                                   RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungGeld (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussGeld (KoordinatenExtern => KoordinatenExtern,
                                     RasseExtern       => RasseExtern)
        < ProduktionDatentypen.ProduktionFeld'First
      then
         return ProduktionDatentypen.ProduktionFeld'First;
         
      else
         return KartenAllgemein.GrundGeld (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
           + KartenAllgemein.RessourceGeld (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
           + KartenAllgemein.WegGeld (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
           + KartenAllgemein.VerbesserungGeld (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
           + KartenAllgemein.FlussGeld (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => RasseExtern);
      end if;
      
   end FeldGeld;
     
     
     
   function FeldWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
   is begin
      
      if
        KartenAllgemein.GrundWissen (KoordinatenExtern => KoordinatenExtern,
                                     RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceWissen (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
        + KartenAllgemein.WegWissen (KoordinatenExtern => KoordinatenExtern,
                                     RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungWissen (KoordinatenExtern => KoordinatenExtern,
                                              RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussWissen (KoordinatenExtern => KoordinatenExtern,
                                       RasseExtern       => RasseExtern)
        > ProduktionDatentypen.ProduktionFeld'Last
      then
         return ProduktionDatentypen.ProduktionFeld'Last;
         
      elsif
        KartenAllgemein.GrundWissen (KoordinatenExtern => KoordinatenExtern,
                                     RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceWissen (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
        + KartenAllgemein.WegWissen (KoordinatenExtern => KoordinatenExtern,
                                     RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungWissen (KoordinatenExtern => KoordinatenExtern,
                                              RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussWissen (KoordinatenExtern => KoordinatenExtern,
                                       RasseExtern       => RasseExtern)
        < ProduktionDatentypen.ProduktionFeld'First
      then
         return ProduktionDatentypen.ProduktionFeld'First;
         
      else
         return KartenAllgemein.GrundWissen (KoordinatenExtern => KoordinatenExtern,
                                             RasseExtern       => RasseExtern)
           + KartenAllgemein.RessourceWissen (KoordinatenExtern => KoordinatenExtern,
                                              RasseExtern       => RasseExtern)
           + KartenAllgemein.WegWissen (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => RasseExtern)
           + KartenAllgemein.VerbesserungWissen (KoordinatenExtern => KoordinatenExtern,
                                                 RasseExtern       => RasseExtern)
           + KartenAllgemein.FlussWissen (KoordinatenExtern => KoordinatenExtern,
                                          RasseExtern       => RasseExtern);
      end if;
      
   end FeldWissen;
     
     
     
   function FeldVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      if
        KartenAllgemein.GrundVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                 RasseExtern       => RasseExtern)
        + KartenAllgemein.WegVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                    RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                             RasseExtern       => RasseExtern)
        > KampfDatentypen.Kampfwerte'Last
      then
         return KampfDatentypen.Kampfwerte'Last;
         
      elsif
        KartenAllgemein.GrundVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                 RasseExtern       => RasseExtern)
        + KartenAllgemein.WegVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                    RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                             RasseExtern       => RasseExtern)
        < KampfDatentypen.Kampfwerte'First
      then
         return KampfDatentypen.Kampfwerte'First;
         
      else
         return KartenAllgemein.GrundVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                   RasseExtern       => RasseExtern)
           + KartenAllgemein.RessourceVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                    RasseExtern       => RasseExtern)
           + KartenAllgemein.WegVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                              RasseExtern       => RasseExtern)
           + KartenAllgemein.VerbesserungVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                       RasseExtern       => RasseExtern)
           + KartenAllgemein.FlussVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                RasseExtern       => RasseExtern);
      end if;
      
   end FeldVerteidigung;
     
     
     
   function FeldAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      if
        KartenAllgemein.GrundAngriff (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceAngriff (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
        + KartenAllgemein.WegAngriff (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungAngriff (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussAngriff (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => RasseExtern)
        > KampfDatentypen.Kampfwerte'Last
      then
         return KampfDatentypen.Kampfwerte'Last;
         
      elsif
        KartenAllgemein.GrundAngriff (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
        + KartenAllgemein.RessourceAngriff (KoordinatenExtern => KoordinatenExtern,
                                            RasseExtern       => RasseExtern)
        + KartenAllgemein.WegAngriff (KoordinatenExtern => KoordinatenExtern,
                                      RasseExtern       => RasseExtern)
        + KartenAllgemein.VerbesserungAngriff (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
        + KartenAllgemein.FlussAngriff (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => RasseExtern)
        < KampfDatentypen.Kampfwerte'First
      then
         return KampfDatentypen.Kampfwerte'First;
         
      else
         return KartenAllgemein.GrundAngriff (KoordinatenExtern => KoordinatenExtern,
                                              RasseExtern       => RasseExtern)
           + KartenAllgemein.RessourceAngriff (KoordinatenExtern => KoordinatenExtern,
                                               RasseExtern       => RasseExtern)
           + KartenAllgemein.WegAngriff (KoordinatenExtern => KoordinatenExtern,
                                         RasseExtern       => RasseExtern)
           + KartenAllgemein.VerbesserungAngriff (KoordinatenExtern => KoordinatenExtern,
                                                  RasseExtern       => RasseExtern)
           + KartenAllgemein.FlussAngriff (KoordinatenExtern => KoordinatenExtern,
                                           RasseExtern       => RasseExtern);
      end if;
      
   end FeldAngriff;

end GesamtwerteFeld;
