pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ProduktionDatentypen; use ProduktionDatentypen;
with KampfDatentypen; use KampfDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with GlobaleTexte;
with KartenKonstanten;

with LeseKarten;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

-- Später die Beschreibungen noch um RasseExtern erweitern damit jede Rasse ihren eigenen Text haben kann? äöü
package body KartenAllgemein is
   
   function BeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
            
      GrundAktuell := 2 * KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Pos (KartenGrundExtern) - 1;
   
      return To_Wide_Wide_String (Source => GlobaleTexte.Kartenfelder (GrundAktuell));
      
   end BeschreibungBasisgrund;
   


   function BeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      ZusatzAktuell := 2 * KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Pos (KartenGrundExtern) - 1;
   
      return To_Wide_Wide_String (Source => GlobaleTexte.Kartenfelder (ZusatzAktuell));
      
   end BeschreibungZusatzgrund;
   
   
   
   function BeschreibungFluss
     (KartenFlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
            
      FlussAktuell := 2 * KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Pos (KartenFlussExtern) - 1;
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Kartenflüsse (FlussAktuell));
      
   end BeschreibungFluss;
   
   
   
   function BeschreibungRessource
     (KartenRessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      RessourceAktuell := 2 * KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Pos (KartenRessourceExtern) - 1;
   
      return To_Wide_Wide_String (Source => GlobaleTexte.Kartenressourcen (RessourceAktuell));
      
   end BeschreibungRessource;
   
   
   
   -- Später mal ein besseres Berechnungssystem einbauen. äöü
   function GrundNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Basisgrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      Zusatzgrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Basisgrund = Zusatzgrund
      then
         return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => Basisgrund,
                                                       RasseExtern         => RasseExtern,
                                                       WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
         
      else
         return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => Zusatzgrund,
                                                       RasseExtern         => RasseExtern,
                                                       WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      end if;
            
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Basisgrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      Zusatzgrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Basisgrund = Zusatzgrund
      then
         return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => Basisgrund,
                                                       RasseExtern         => RasseExtern,
                                                       WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
         
      else
         return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => Zusatzgrund,
                                                       RasseExtern         => RasseExtern,
                                                       WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      end if;
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Basisgrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      Zusatzgrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Basisgrund = Zusatzgrund
      then
         return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => Basisgrund,
                                                       RasseExtern         => RasseExtern,
                                                       WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
         
      else
         return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => Zusatzgrund,
                                                       RasseExtern         => RasseExtern,
                                                       WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      end if;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      Basisgrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      Zusatzgrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Basisgrund = Zusatzgrund
      then
         return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => Basisgrund,
                                                       RasseExtern         => RasseExtern,
                                                       WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
         
      else
         return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => Zusatzgrund,
                                                       RasseExtern         => RasseExtern,
                                                       WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      end if;
      
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      Basisgrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      Zusatzgrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Basisgrund = Zusatzgrund
      then
         return LeseKartenDatenbanken.KampfGrund (GrundExtern         => Basisgrund,
                                                  RasseExtern         => RasseExtern,
                                                  KampfArtExtern => KartenKonstanten.KampfVerteidigung);
         
      else
         return LeseKartenDatenbanken.KampfGrund (GrundExtern         => Zusatzgrund,
                                                  RasseExtern         => RasseExtern,
                                                  KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      end if;
      
   end GrundVerteidigung;
   
   

   function GrundAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      Basisgrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      Zusatzgrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Basisgrund = Zusatzgrund
      then
         return LeseKartenDatenbanken.KampfGrund (GrundExtern         => Basisgrund,
                                                  RasseExtern         => RasseExtern,
                                                  KampfArtExtern => KartenKonstanten.KampfAngriff);
         
      else
         return LeseKartenDatenbanken.KampfGrund (GrundExtern         => Zusatzgrund,
                                                  RasseExtern         => RasseExtern,
                                                  KampfArtExtern => KartenKonstanten.KampfAngriff);
      end if;
      
   end GrundAngriff;
   
   
   
   function GrundBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      Basisgrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      Zusatzgrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Basisgrund = Zusatzgrund
      then
         return LeseKartenDatenbanken.BewertungGrund (GrundExtern => Basisgrund,
                                                      RasseExtern => RasseExtern);
         
      else
         return LeseKartenDatenbanken.BewertungGrund (GrundExtern => Zusatzgrund,
                                                      RasseExtern => RasseExtern);
      end if;
      
   end GrundBewertung;
   
   
   
   function FlussNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => KartenFluss,
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      end case;
      
   end FlussNahrung;
   
   
   
   function FlussProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => KartenFluss,
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end FlussProduktion;
   
   
   
   function FlussGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => KartenFluss,
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftFluss (FlussExtern         => KartenFluss,
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.KampfFluss (FlussExtern    => KartenFluss,
                                                     RasseExtern    => RasseExtern,
                                                     KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end FlussVerteidigung;
   
   

   function FlussAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.KampfFluss (FlussExtern    => KartenFluss,
                                                     RasseExtern    => RasseExtern,
                                                     KampfArtExtern => KartenKonstanten.KampfAngriff);
      end case;
      
   end FlussAngriff;
   
   
   
   function FlussBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      KartenFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.BewertungFluss (FlussExtern => KartenFluss,
                                                         RasseExtern => RasseExtern);
      end case;
      
   end FlussBewertung;
   
   
   
   function WegNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern => KartenWeg,
                                                              RasseExtern        => RasseExtern,
                                                              WelcherWertExtern  => KartenKonstanten.WirtschaftNahrung);
      end case;
      
   end WegNahrung;
   
   
   
   function WegProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern => KartenWeg,
                                                              RasseExtern        => RasseExtern,
                                                              WelcherWertExtern  => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end WegProduktion;
   
   
   
   function WegGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern => KartenWeg,
                                                              RasseExtern        => RasseExtern,
                                                              WelcherWertExtern  => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end WegGeld;
   
   
   
   function WegWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftWeg (WegExtern => KartenWeg,
                                                              RasseExtern        => RasseExtern,
                                                              WelcherWertExtern  => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end WegWissen;
   
   
   
   function WegVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.KampfWeg (WegExtern => KartenWeg,
                                                         RasseExtern        => RasseExtern,
                                                         WelcherWertExtern  => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end WegVerteidigung;
   
   
   
   function WegAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.KampfWeg (WegExtern => KartenWeg,
                                                         RasseExtern        => RasseExtern,
                                                         WelcherWertExtern  => KartenKonstanten.KampfAngriff);
      end case;
      
   end WegAngriff;
   
   
   
   function WegBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.BewertungWeg (WegExtern => KartenWeg,
                                                             RasseExtern        => RasseExtern);
      end case;
      
   end WegBewertung;
   
   
   
   function VerbesserungNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                       RasseExtern        => RasseExtern,
                                                                       WelcherWertExtern  => KartenKonstanten.WirtschaftNahrung);
      end case;
      
   end VerbesserungNahrung;
   
   
   
   function VerbesserungProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                       RasseExtern        => RasseExtern,
                                                                       WelcherWertExtern  => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end VerbesserungProduktion;
   
   
   
   function VerbesserungGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                       RasseExtern        => RasseExtern,
                                                                       WelcherWertExtern  => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end VerbesserungGeld;
   
   
   
   function VerbesserungWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.WirtschaftVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                       RasseExtern        => RasseExtern,
                                                                       WelcherWertExtern  => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end VerbesserungWissen;
   
   
   
   function VerbesserungVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                  RasseExtern        => RasseExtern,
                                                                  WelcherWertExtern  => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end VerbesserungVerteidigung;
   
   
   
   function VerbesserungAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                  RasseExtern        => RasseExtern,
                                                                  WelcherWertExtern  => KartenKonstanten.KampfAngriff);
      end case;
      
   end VerbesserungAngriff;
   
   
   
   function VerbesserungBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return 0;
            
         when others =>
            return LeseVerbesserungenDatenbank.BewertungVerbesserung (VerbesserungExtern => KartenVerbesserung,
                                                                      RasseExtern        => RasseExtern);
      end case;
      
   end VerbesserungBewertung;
   
   
   
   function RessourceNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern         => KartenRessource,
                                                               RasseExtern         => RasseExtern,
                                                               WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      end case;
      
   end RessourceNahrung;
   
   
   
   function RessourceProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern         => KartenRessource,
                                                               RasseExtern         => RasseExtern,
                                                               WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end RessourceProduktion;
   
   
   
   function RessourceGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern         => KartenRessource,
                                                               RasseExtern         => RasseExtern,
                                                               WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftRessourcen (RessourceExtern         => KartenRessource,
                                                               RasseExtern         => RasseExtern,
                                                               WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.KampfRessource (RessourceExtern    => KartenRessource,
                                                         RasseExtern    => RasseExtern,
                                                         KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end RessourceVerteidigung;
   
   
   
   function RessourceAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.KampfRessource (RessourceExtern    => KartenRessource,
                                                         RasseExtern    => RasseExtern,
                                                         KampfArtExtern => KartenKonstanten.KampfAngriff);
      end case;
      
   end RessourceAngriff;
   
   
   
   function RessourceBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return 0;
            
         when others =>
            return LeseKartenDatenbanken.BewertungRessource (RessourceExtern => KartenRessource,
                                                             RasseExtern => RasseExtern);
      end case;
      
   end RessourceBewertung;
   
   
   
   function PassierbarGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PassierbarkeitExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      -- Was mach ich denn dann hier? äöü
      -- Den aktuellen Grund zurückgeben und entsprechend auf dessen Basis zusätzliche Passierbarkeitseinschränkungen einbauen? äöü
      -- Ist das im aktuellen System überhaupt möglich? Müsste da dann noch eine Unterscheidung zwischen Einheitentypen geben, z. B. Panzer, Infanterie, usw.. äöü
      
      return LeseKartenDatenbanken.Passierbarkeit (GrundExtern          => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                   WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarGrund;
   
   
   
   function PassierbarVerbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PassierbarkeitExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
            
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return True;
            
         when others =>
            return LeseVerbesserungenDatenbank.PassierbarkeitVerbesserung (VerbesserungExtern   => KartenVerbesserung,
                                                                           WelcheUmgebungExtern => PassierbarkeitExtern);
      end case;
      
   end PassierbarVerbesserung;
   
   
   
   function PassierbarWeg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PassierbarkeitExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return True;
            
         when others =>
            return LeseVerbesserungenDatenbank.PassierbarkeitWeg (WegExtern            => KartenWeg,
                                                                  WelcheUmgebungExtern => PassierbarkeitExtern);
      end case;
      
   end PassierbarWeg;

end KartenAllgemein;
