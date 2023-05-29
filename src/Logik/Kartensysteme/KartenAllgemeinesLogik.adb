with KartenKonstanten;
with KartengrundDatentypen;
with GrafikKonstanten;
with ProduktionKonstanten;

with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

-- Ist das hier überhaupt nötig? Es leitet ja das Zeug immer nur an die LeseDatenbanken weiter, die könnte ich auch direkt aufrufen. äöü
package body KartenAllgemeinesLogik is
   
   function GrundProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      Basiswirtschaft := LeseKartenDatenbanken.WirtschaftBasisgrund (GrundExtern         => Gesamtgrund.Basisgrund,
                                                                     SpeziesExtern       => SpeziesExtern,
                                                                     WirtschaftArtExtern => ProduktionKonstanten.WirtschaftMaterial);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiswirtschaft;
         
         when others =>
            Zusatzwirtschaft := LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => Gesamtgrund.Zusatzgrund,
                                                                             SpeziesExtern       => SpeziesExtern,
                                                                             WirtschaftArtExtern => ProduktionKonstanten.WirtschaftMaterial);
            
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
                                                                     WirtschaftArtExtern => ProduktionKonstanten.WirtschaftGeld);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiswirtschaft;
         
         when others =>
            Zusatzwirtschaft := LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => Gesamtgrund.Zusatzgrund,
                                                                             SpeziesExtern       => SpeziesExtern,
                                                                             WirtschaftArtExtern => ProduktionKonstanten.WirtschaftGeld);
            
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
                                                                     WirtschaftArtExtern => ProduktionKonstanten.WirtschaftForschung);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return Basiswirtschaft;
         
         when others =>
            Zusatzwirtschaft := LeseKartenDatenbanken.WirtschaftZusatzgrund (GrundExtern         => Gesamtgrund.Zusatzgrund,
                                                                             SpeziesExtern       => SpeziesExtern,
                                                                             WirtschaftArtExtern => ProduktionKonstanten.WirtschaftForschung);
            
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
