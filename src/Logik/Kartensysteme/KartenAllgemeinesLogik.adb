with KartenKonstanten;
with KampfKonstanten;
with KartengrundDatentypen;
with GrafikKonstanten;
with ProduktionKonstanten;

with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

package body KartenAllgemeinesLogik is
   
   -- Später mal ein besseres Berechnungssystem einbauen. äöü
   function GrundNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      Basiswirtschaft := LeseKartenDatenbanken.WirtschaftBasisgrund (GrundExtern         => Gesamtgrund.Basisgrund,
                                                                     SpeziesExtern       => SpeziesExtern,
                                                                     WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiswirtschaft;
            
         when others =>
            Zusatzwirtschaft := LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => Gesamtgrund.Zusatzgrund,
                                                                             SpeziesExtern       => SpeziesExtern,
                                                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
            
            return ProduktionDatentypen.Einzelproduktion (Float (Basiswirtschaft) / GrafikKonstanten.Halbierung + Float (Zusatzwirtschaft) / GrafikKonstanten.Halbierung);
      end case;
            
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      Basiswirtschaft := LeseKartenDatenbanken.WirtschaftBasisgrund (GrundExtern         => Gesamtgrund.Basisgrund,
                                                                     SpeziesExtern       => SpeziesExtern,
                                                                     WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiswirtschaft;
         
         when others =>
            Zusatzwirtschaft := LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => Gesamtgrund.Zusatzgrund,
                                                                             SpeziesExtern       => SpeziesExtern,
                                                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
            
            return ProduktionDatentypen.Einzelproduktion (Float (Basiswirtschaft) / GrafikKonstanten.Halbierung + Float (Zusatzwirtschaft) / GrafikKonstanten.Halbierung);
      end case;
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      Basiswirtschaft := LeseKartenDatenbanken.WirtschaftBasisgrund (GrundExtern         => Gesamtgrund.Basisgrund,
                                                                     SpeziesExtern       => SpeziesExtern,
                                                                     WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiswirtschaft;
         
         when others =>
            Zusatzwirtschaft := LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => Gesamtgrund.Zusatzgrund,
                                                                             SpeziesExtern       => SpeziesExtern,
                                                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
            
            return ProduktionDatentypen.Einzelproduktion (Float (Basiswirtschaft) / GrafikKonstanten.Halbierung + Float (Zusatzwirtschaft) / GrafikKonstanten.Halbierung);
      end case;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      Basiswirtschaft := LeseKartenDatenbanken.WirtschaftBasisgrund (GrundExtern         => Gesamtgrund.Basisgrund,
                                                                     SpeziesExtern       => SpeziesExtern,
                                                                     WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiswirtschaft;
         
         when others =>
            Zusatzwirtschaft := LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => Gesamtgrund.Zusatzgrund,
                                                                             SpeziesExtern       => SpeziesExtern,
                                                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
            
            return ProduktionDatentypen.Einzelproduktion (Float (Basiswirtschaft) / GrafikKonstanten.Halbierung + Float (Zusatzwirtschaft) / GrafikKonstanten.Halbierung);
      end case;
      
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      Basiskampf := LeseKartenDatenbanken.KampfBasisgrund (GrundExtern    => Gesamtgrund.Basisgrund,
                                                           SpeziesExtern  => SpeziesExtern,
                                                           KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiskampf;
         
         when others =>
            Zusatzkampf := LeseKartenDatenbanken.KampfZusatzgrund (GrundExtern    => Gesamtgrund.Zusatzgrund,
                                                                   SpeziesExtern  => SpeziesExtern,
                                                                   KampfArtExtern => KartenKonstanten.KampfVerteidigung);
            
            return KampfDatentypen.KampfwerteKarte (Float (Basiskampf) / GrafikKonstanten.Halbierung + Float (Zusatzkampf) / GrafikKonstanten.Halbierung);
      end case;
      
   end GrundVerteidigung;
   
   

   function GrundAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      Basiskampf := LeseKartenDatenbanken.KampfBasisgrund (GrundExtern    => Gesamtgrund.Basisgrund,
                                                           SpeziesExtern  => SpeziesExtern,
                                                           KampfArtExtern => KartenKonstanten.KampfAngriff);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiskampf;
         
         when others =>
            Zusatzkampf := LeseKartenDatenbanken.KampfZusatzgrund (GrundExtern    => Gesamtgrund.Zusatzgrund,
                                                                   SpeziesExtern  => SpeziesExtern,
                                                                   KampfArtExtern => KartenKonstanten.KampfAngriff);
            
            return KampfDatentypen.KampfwerteKarte (Float (Basiskampf) / GrafikKonstanten.Halbierung + Float (Zusatzkampf) / GrafikKonstanten.Halbierung);
      end case;
      
   end GrundAngriff;
   
   
   
   function FlussNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => KartenFluss,
                                                          SpeziesExtern       => SpeziesExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      end case;
      
   end FlussNahrung;
   
   
   
   function FlussProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => KartenFluss,
                                                          SpeziesExtern       => SpeziesExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end FlussProduktion;
   
   
   
   function FlussGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            -- Hat schon einmal einen Absturz durch range check failed verursacht, eventuell müssen hier überall weitere Tests rein. äöü
            return LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => KartenFluss,
                                                          SpeziesExtern       => SpeziesExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => KartenFluss,
                                                          SpeziesExtern       => SpeziesExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseKartenDatenbanken.KampfFluss (FlussExtern    => KartenFluss,
                                                     SpeziesExtern  => SpeziesExtern,
                                                     KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end FlussVerteidigung;
   
   

   function FlussAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseKartenDatenbanken.KampfFluss (FlussExtern    => KartenFluss,
                                                     SpeziesExtern  => SpeziesExtern,
                                                     KampfArtExtern => KartenKonstanten.KampfAngriff);
      end case;
      
   end FlussAngriff;
   
   
   
   function FlussBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return KartenKonstanten.LeerBewertung;
            
         when others =>
            return LeseKartenDatenbanken.BewertungFluss (FlussExtern   => KartenFluss,
                                                         SpeziesExtern => SpeziesExtern);
      end case;
      
   end FlussBewertung;
   
   
   
   function WegNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern         => KartenWeg,
                                                              SpeziesExtern     => SpeziesExtern,
                                                              WelcherWertExtern => KartenKonstanten.WirtschaftNahrung);
      end case;
      
   end WegNahrung;
   
   
   
   function WegProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern         => KartenWeg,
                                                              SpeziesExtern     => SpeziesExtern,
                                                              WelcherWertExtern => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end WegProduktion;
   
   
   
   function WegGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern         => KartenWeg,
                                                              SpeziesExtern     => SpeziesExtern,
                                                              WelcherWertExtern => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end WegGeld;
   
   
   
   function WegWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern         => KartenWeg,
                                                              SpeziesExtern     => SpeziesExtern,
                                                              WelcherWertExtern => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end WegWissen;
   
   
   
   function WegVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      KartenWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseVerbesserungenDatenbank.KampfWeg (WegExtern         => KartenWeg,
                                                         SpeziesExtern     => SpeziesExtern,
                                                         WelcherWertExtern => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end WegVerteidigung;
   
   
   
   function WegAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      KartenWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseVerbesserungenDatenbank.KampfWeg (WegExtern         => KartenWeg,
                                                         SpeziesExtern     => SpeziesExtern,
                                                         WelcherWertExtern => KartenKonstanten.KampfAngriff);
      end case;
      
   end WegAngriff;
   
   
   
   function VerbesserungNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                       SpeziesExtern      => SpeziesExtern,
                                                                       WelcherWertExtern  => KartenKonstanten.WirtschaftNahrung);
      end case;
      
   end VerbesserungNahrung;
   
   
   
   function VerbesserungProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                       SpeziesExtern      => SpeziesExtern,
                                                                       WelcherWertExtern  => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end VerbesserungProduktion;
   
   
   
   function VerbesserungGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                       SpeziesExtern      => SpeziesExtern,
                                                                       WelcherWertExtern  => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end VerbesserungGeld;
   
   
   
   function VerbesserungWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                       SpeziesExtern      => SpeziesExtern,
                                                                       WelcherWertExtern  => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end VerbesserungWissen;
   
   
   
   function VerbesserungVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      KartenVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                  SpeziesExtern      => SpeziesExtern,
                                                                  WelcherWertExtern  => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end VerbesserungVerteidigung;
   
   
   
   function VerbesserungAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      KartenVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                  SpeziesExtern      => SpeziesExtern,
                                                                  WelcherWertExtern  => KartenKonstanten.KampfAngriff);
      end case;
      
   end VerbesserungAngriff;
   
   
   
   function RessourceNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => KartenRessource,
                                                               SpeziesExtern       => SpeziesExtern,
                                                               WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      end case;
      
   end RessourceNahrung;
   
   
   
   function RessourceProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => KartenRessource,
                                                               SpeziesExtern       => SpeziesExtern,
                                                               WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end RessourceProduktion;
   
   
   
   function RessourceGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => KartenRessource,
                                                               SpeziesExtern       => SpeziesExtern,
                                                               WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern     => KartenRessource,
                                                               SpeziesExtern       => SpeziesExtern,
                                                               WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseKartenDatenbanken.KampfRessource (RessourceExtern => KartenRessource,
                                                         SpeziesExtern   => SpeziesExtern,
                                                         KampfArtExtern  => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end RessourceVerteidigung;
   
   
   
   function RessourceAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteKarte
   is begin
      
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return LeseKartenDatenbanken.KampfRessource (RessourceExtern => KartenRessource,
                                                         SpeziesExtern   => SpeziesExtern,
                                                         KampfArtExtern  => KartenKonstanten.KampfAngriff);
      end case;
      
   end RessourceAngriff;
   
   
   
   function RessourceBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return KartenKonstanten.LeerBewertung;
            
         when others =>
            return LeseKartenDatenbanken.BewertungRessource (RessourceExtern => KartenRessource,
                                                             SpeziesExtern   => SpeziesExtern);
      end case;
      
   end RessourceBewertung;
   
   
   
   function PassierbarGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PassierbarkeitExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseKartenDatenbanken.PassierbarkeitBasisgrund (GrundExtern          => LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern),
                                                             WelcheUmgebungExtern => PassierbarkeitExtern);
            
   end PassierbarGrund;
   
   
   
   function PassierbarWeg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PassierbarkeitExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      KartenWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return True;
            
         when others =>
            return LeseVerbesserungenDatenbank.PassierbarkeitWeg (WegExtern            => KartenWeg,
                                                                  WelcheUmgebungExtern => PassierbarkeitExtern);
      end case;
      
   end PassierbarWeg;

end KartenAllgemeinesLogik;
