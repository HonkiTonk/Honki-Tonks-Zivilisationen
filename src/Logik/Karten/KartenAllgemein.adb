pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;
with GlobaleTexte;
with KartenKonstanten;

with LeseKarten;
with LeseKartenDatenbank;
with LeseVerbesserungenDatenbank;

package body KartenAllgemein is

   -- Später die Beschreibungen noch um RasseExtern erweitern damit jede Rasse ihren eigenen Text haben kann?
   function BeschreibungGrund
     (KartenGrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin

      ------------------------ Der auskommentierte Bereich hier kann später weg, aktuell aber noch hier damit ich weiß was hier mal stand.
      -- case
      -- KartenGrundExtern
      -- is
      --   when KartenGrundDatentypen.Leer_Grund_Enum =>
      -- Darf nicht als Fehler behandelt werden. Wegen nicht aufgedeckter Felder?
      --      BeschreibungText := SystemKonstanten.LeerUnboundedString;
            
      --   when others =>
      GrundAktuell := 2 * KartenGrundDatentypen.Karten_Grund_Enum'Pos (KartenGrundExtern) - 1;
            
      BeschreibungText := GlobaleTexte.Kartenfelder (GrundAktuell);
      -- end case;
   
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungGrund;
   
   
   
   function BeschreibungFluss
     (KartenFlussExtern : in KartenGrundDatentypen.Karten_Fluss_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      FlussAktuell := 2 * KartenGrundDatentypen.Karten_Fluss_Enum'Pos (KartenFlussExtern) - 1;
            
      BeschreibungText := GlobaleTexte.Kartenfelder (FlussAktuell);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungFluss;
   
   
   
   function BeschreibungRessource
     (KartenRessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      RessourceAktuell := 2 * KartenGrundDatentypen.Karten_Ressourcen_Enum'Pos (KartenRessourceExtern) - 1;
            
      BeschreibungText := GlobaleTexte.Kartenfelder (RessourceAktuell);
   
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungRessource;
   
   
   
   function GrundNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      case
        LeseKarten.Hügel (KoordinatenExtern => KoordinatenExtern)
      is
         when True =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung)
              + LeseKartenDatenbank.Wirtschaft (GrundExtern         => KartenGrundDatentypen.Hügel_Mit_Enum,
                                                RasseExtern         => RasseExtern,
                                                WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung)
              / 2;
            
         when False =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      end case;
            
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      case
        LeseKarten.Hügel (KoordinatenExtern => KoordinatenExtern)
      is
         when True =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion)
              + LeseKartenDatenbank.Wirtschaft (GrundExtern         => KartenGrundDatentypen.Hügel_Mit_Enum,
                                                RasseExtern         => RasseExtern,
                                                WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion)
              / 2;
            
         when False =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      case
        LeseKarten.Hügel (KoordinatenExtern => KoordinatenExtern)
      is
         when True =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld)
              + LeseKartenDatenbank.Wirtschaft (GrundExtern         => KartenGrundDatentypen.Hügel_Mit_Enum,
                                                RasseExtern         => RasseExtern,
                                                WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld)
              / 2;
            
         when False =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      case
        LeseKarten.Hügel (KoordinatenExtern => KoordinatenExtern)
      is
         when True =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung)
              + LeseKartenDatenbank.Wirtschaft (GrundExtern         => KartenGrundDatentypen.Hügel_Mit_Enum,
                                                RasseExtern         => RasseExtern,
                                                WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung)
              / 2;
            
         when False =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      end case;
            
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      case
        LeseKarten.Hügel (KoordinatenExtern => KoordinatenExtern)
      is
         when True =>
            return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                              RasseExtern    => RasseExtern,
                                              KampfArtExtern => KartenKonstanten.KampfVerteidigung)
              + LeseKartenDatenbank.Kampf (GrundExtern    => KartenGrundDatentypen.Hügel_Mit_Enum,
                                           RasseExtern    => RasseExtern,
                                           KampfArtExtern => KartenKonstanten.KampfVerteidigung)
              / 2;
         
         when False =>
            return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                              RasseExtern    => RasseExtern,
                                              KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end GrundVerteidigung;
   
   

   function GrundAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      case
        LeseKarten.Hügel (KoordinatenExtern => KoordinatenExtern)
      is
         when True =>
            return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                              RasseExtern    => RasseExtern,
                                              KampfArtExtern => KartenKonstanten.KampfAngriff)
              + LeseKartenDatenbank.Kampf (GrundExtern    => KartenGrundDatentypen.Hügel_Mit_Enum,
                                           RasseExtern    => RasseExtern,
                                           KampfArtExtern => KartenKonstanten.KampfAngriff)
              / 2;
         
         when False =>
            return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                              RasseExtern    => RasseExtern,
                                              KampfArtExtern => KartenKonstanten.KampfAngriff);
      end case;
      
   end GrundAngriff;
   
   
   
   function GrundBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseKartenDatenbank.Bewertung (GrundExtern => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                            RasseExtern => RasseExtern);
      
   end GrundBewertung;
   
   
   
   function FlussNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      
   end FlussNahrung;
   
   
   
   function FlussProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      
   end FlussProduktion;
   
   
   
   function FlussGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                        RasseExtern    => RasseExtern,
                                        KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      
   end FlussVerteidigung;
   
   

   function FlussAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                        RasseExtern    => RasseExtern,
                                        KampfArtExtern => KartenKonstanten.KampfAngriff);
      
   end FlussAngriff;
   
   
   
   function FlussBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseKartenDatenbank.Bewertung (GrundExtern => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                            RasseExtern => RasseExtern);
      
   end FlussBewertung;
   
   
   
   function WegNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftNahrung);
      
   end WegNahrung;
   
   
   
   function WegProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftProduktion);
      
   end WegProduktion;
   
   
   
   function WegGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftGeld);
      
   end WegGeld;
   
   
   
   function WegWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftForschung);
      
   end WegWissen;
   
   
   
   function WegVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseVerbesserungenDatenbank.Kampf (VerbesserungExtern => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                                RasseExtern        => RasseExtern,
                                                WelcherWertExtern  => KartenKonstanten.KampfVerteidigung);
      
   end WegVerteidigung;
   
   
   
   function WegAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseVerbesserungenDatenbank.Kampf (VerbesserungExtern => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                                RasseExtern        => RasseExtern,
                                                WelcherWertExtern  => KartenKonstanten.KampfAngriff);
      
   end WegAngriff;
   
   
   
   function WegBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Bewertung (VerbesserungExtern => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                                    RasseExtern        => RasseExtern);
      
   end WegBewertung;
   
   
   
   function VerbesserungNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftNahrung);
      
   end VerbesserungNahrung;
   
   
   
   function VerbesserungProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftProduktion);
      
   end VerbesserungProduktion;
   
   
   
   function VerbesserungGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftGeld);
      
   end VerbesserungGeld;
   
   
   
   function VerbesserungWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftForschung);
      
   end VerbesserungWissen;
   
   
   
   function VerbesserungVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseVerbesserungenDatenbank.Kampf (VerbesserungExtern => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                                RasseExtern        => RasseExtern,
                                                WelcherWertExtern  => KartenKonstanten.KampfVerteidigung);
      
   end VerbesserungVerteidigung;
   
   
   
   function VerbesserungAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseVerbesserungenDatenbank.Kampf (VerbesserungExtern => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                                RasseExtern        => RasseExtern,
                                                WelcherWertExtern  => KartenKonstanten.KampfAngriff);
      
   end VerbesserungAngriff;
   
   
   
   function VerbesserungBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Bewertung (VerbesserungExtern => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                                    RasseExtern        => RasseExtern);
      
   end VerbesserungBewertung;
   
   
   
   function RessourceNahrung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      
   end RessourceNahrung;
   
   
   
   function RessourceProduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      
   end RessourceProduktion;
   
   
   
   function RessourceGeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                        RasseExtern    => RasseExtern,
                                        KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      
   end RessourceVerteidigung;
   
   
   
   function RessourceAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                        RasseExtern    => RasseExtern,
                                        KampfArtExtern => KartenKonstanten.KampfAngriff);
      
   end RessourceAngriff;
   
   
   
   function RessourceBewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseKartenDatenbank.Bewertung (GrundExtern => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                            RasseExtern => RasseExtern);
      
   end RessourceBewertung;
   
   
   
   function PassierbarGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseKartenDatenbank.Passierbarkeit (GrundExtern          => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                                 WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarGrund;
   
   
   
   function PassierbarVerbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                                         WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarVerbesserung;
   
   
   
   function PassierbarWeg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                                         WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarWeg;

end KartenAllgemein;
