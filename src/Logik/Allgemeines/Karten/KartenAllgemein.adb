pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ProduktionDatentypen; use ProduktionDatentypen;
with KampfDatentypen; use KampfDatentypen;
with GlobaleTexte;
with KartenKonstanten;

with LeseKarten;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

package body KartenAllgemein is

   ------------------------ Später die Beschreibungen noch um RasseExtern erweitern damit jede Rasse ihren eigenen Text haben kann?
   function BeschreibungGrund
     (KartenGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      -- Die Zwischenrechnungen mal drin lassen, für den Fall dass ich die Beschreibungen rassenspezifisch machen will. Könnte dann eine komplexere Rechnung werden.
      GrundAktuell := 2 * KartengrundDatentypen.Kartengrund_Enum'Pos (KartenGrundExtern) - 1;
   
      return To_Wide_Wide_String (Source => GlobaleTexte.Kartenfelder (GrundAktuell));
      
   end BeschreibungGrund;
   
   
   
   ---------------------------- Hügel, das hier anpassen und mit dem oben koppeln. Außerdem alle Sachen weiter unten noch korrekt anpassen.
   function BeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      -- Die Zwischenrechnungen mal drin lassen, für den Fall dass ich die Beschreibungen rassenspezifisch machen will. Könnte dann eine komplexere Rechnung werden.
      GrundAktuell := 2 * KartengrundDatentypen.Kartengrund_Enum'Pos (KartenGrundExtern) - 1;
   
      return To_Wide_Wide_String (Source => GlobaleTexte.Kartenfelder (GrundAktuell));
      
   end BeschreibungBasisgrund;
   
   
   
   function BeschreibungFluss
     (KartenFlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
            
      FlussAktuell := 2 * KartengrundDatentypen.Kartenfluss_Enum'Pos (KartenFlussExtern) - 1;
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Kartenflüsse (FlussAktuell));
      
   end BeschreibungFluss;
   
   
   
   function BeschreibungRessource
     (KartenRessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      RessourceAktuell := 2 * KartengrundDatentypen.Karten_Ressourcen_Enum'Pos (KartenRessourceExtern) - 1;
   
      return To_Wide_Wide_String (Source => GlobaleTexte.Kartenressourcen (RessourceAktuell));
      
   end BeschreibungRessource;
   
   
   
   function GrundNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        BasisGrund
      is
         when KartengrundDatentypen.Hügel_Enum | KartengrundDatentypen.Gebirge_Enum =>
            return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
             -- + LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => KartengrundDatentypen.Hügel_Mit_Enum,
             --                                          RasseExtern         => RasseExtern,
             --                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung)
             -- / 2;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      end case;
            
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        BasisGrund
      is
         when KartengrundDatentypen.Hügel_Enum | KartengrundDatentypen.Gebirge_Enum =>
            return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
             -- + LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => KartengrundDatentypen.Hügel_Mit_Enum,
             --                                          RasseExtern         => RasseExtern,
             --                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion)
             -- / 2;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        BasisGrund
      is
         when KartengrundDatentypen.Hügel_Enum | KartengrundDatentypen.Gebirge_Enum =>
            return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
             -- + LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => KartengrundDatentypen.Hügel_Mit_Enum,
             --                                          RasseExtern         => RasseExtern,
             --                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld)
             -- / 2;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        BasisGrund
      is
         when KartengrundDatentypen.Hügel_Enum | KartengrundDatentypen.Gebirge_Enum =>
            return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
             -- + LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => KartengrundDatentypen.Hügel_Mit_Enum,
             --                                          RasseExtern         => RasseExtern,
             --                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung)
             -- / 2;
            
         when others =>
            return LeseKartenDatenbanken.WirtschaftGrund (GrundExtern         => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                          RasseExtern         => RasseExtern,
                                                          WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      end case;
      
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        BasisGrund
      is
         when KartengrundDatentypen.Hügel_Enum | KartengrundDatentypen.Gebirge_Enum =>
            return LeseKartenDatenbanken.KampfGrund (GrundExtern    => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern    => RasseExtern,
                                                     KampfArtExtern => KartenKonstanten.KampfVerteidigung);
             -- + LeseKartenDatenbanken.KampfGrund (GrundExtern    => KartengrundDatentypen.Hügel_Mit_Enum,
             --                                     RasseExtern    => RasseExtern,
             --                                     KampfArtExtern => KartenKonstanten.KampfVerteidigung)
             -- / 2;
         
         when others =>
            return LeseKartenDatenbanken.KampfGrund (GrundExtern    => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern    => RasseExtern,
                                                     KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end GrundVerteidigung;
   
   

   function GrundAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        BasisGrund
      is
         when KartengrundDatentypen.Hügel_Enum | KartengrundDatentypen.Gebirge_Enum =>
            return LeseKartenDatenbanken.KampfGrund (GrundExtern    => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern    => RasseExtern,
                                                     KampfArtExtern => KartenKonstanten.KampfAngriff);
             -- + LeseKartenDatenbanken.KampfGrund (GrundExtern    => KartengrundDatentypen.Hügel_Mit_Enum,
             --                                     RasseExtern    => RasseExtern,
             --                                     KampfArtExtern => KartenKonstanten.KampfAngriff)
             -- / 2;
         
         when others =>
            return LeseKartenDatenbanken.KampfGrund (GrundExtern    => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern    => RasseExtern,
                                                     KampfArtExtern => KartenKonstanten.KampfAngriff);
      end case;
      
   end GrundAngriff;
   
   
   
   function GrundBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseKartenDatenbanken.BewertungGrund (GrundExtern => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern => RasseExtern);
      
   end GrundBewertung;
   
   
   
   function FlussNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
   is begin
      
      -----------------------
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.ProduktionElement
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseKartenDatenbanken.Passierbarkeit (GrundExtern          => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                                   WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarGrund;
   
   
   
   function PassierbarVerbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
