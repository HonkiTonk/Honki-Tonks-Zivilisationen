pragma SPARK_Mode (On);

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
   function Beschreibung
     (KartenGrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return Wide_Wide_String
   is begin

      case
        KartenGrundExtern
      is
         when KartenDatentypen.Leer_Grund =>
            -- Darf nicht als Fehler behandelt werden. Wegen nicht aufgedeckter Felder?
            BeschreibungText := SystemKonstanten.LeerUnboundedString;
            
         when others =>
            GrundAktuell := 2 * KartenDatentypen.Karten_Grund_Enum'Pos (KartenGrundExtern) - 1;
            
            BeschreibungText := GlobaleTexte.Kartenfelder (GrundAktuell);
      end case;
   
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end Beschreibung;
   
   
   
   function GrundNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      case
        LeseKarten.Hügel (PositionExtern => PositionExtern)
      is
         when True =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung)
              + LeseKartenDatenbank.Wirtschaft (GrundExtern         => KartenDatentypen.Hügel_Mit,
                                                RasseExtern         => RasseExtern,
                                                WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung)
              / 2;
            
         when False =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      end case;
            
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      case
        LeseKarten.Hügel (PositionExtern => PositionExtern)
      is
         when True =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion)
              + LeseKartenDatenbank.Wirtschaft (GrundExtern         => KartenDatentypen.Hügel_Mit,
                                                RasseExtern         => RasseExtern,
                                                WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion)
              / 2;
            
         when False =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      end case;
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      case
        LeseKarten.Hügel (PositionExtern => PositionExtern)
      is
         when True =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld)
              + LeseKartenDatenbank.Wirtschaft (GrundExtern         => KartenDatentypen.Hügel_Mit,
                                                RasseExtern         => RasseExtern,
                                                WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld)
              / 2;
            
         when False =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      end case;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      case
        LeseKarten.Hügel (PositionExtern => PositionExtern)
      is
         when True =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung)
              + LeseKartenDatenbank.Wirtschaft (GrundExtern         => KartenDatentypen.Hügel_Mit,
                                                RasseExtern         => RasseExtern,
                                                WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung)
              / 2;
            
         when False =>
            return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                   RasseExtern         => RasseExtern,
                                                   WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      end case;
            
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      case
        LeseKarten.Hügel (PositionExtern => PositionExtern)
      is
         when True =>
            return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Grund (PositionExtern => PositionExtern),
                                              RasseExtern    => RasseExtern,
                                              KampfArtExtern => KartenKonstanten.KampfVerteidigung)
              + LeseKartenDatenbank.Kampf (GrundExtern    => KartenDatentypen.Hügel_Mit,
                                           RasseExtern    => RasseExtern,
                                           KampfArtExtern => KartenKonstanten.KampfVerteidigung)
              / 2;
         
         when False =>
            return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Grund (PositionExtern => PositionExtern),
                                              RasseExtern    => RasseExtern,
                                              KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      end case;
      
   end GrundVerteidigung;
   
   

   function GrundAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      case
        LeseKarten.Hügel (PositionExtern => PositionExtern)
      is
         when True =>
            return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Grund (PositionExtern => PositionExtern),
                                              RasseExtern    => RasseExtern,
                                              KampfArtExtern => KartenKonstanten.KampfAngriff)
              + LeseKartenDatenbank.Kampf (GrundExtern    => KartenDatentypen.Hügel_Mit,
                                           RasseExtern    => RasseExtern,
                                           KampfArtExtern => KartenKonstanten.KampfAngriff)
              / 2;
         
         when False =>
            return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Grund (PositionExtern => PositionExtern),
                                              RasseExtern    => RasseExtern,
                                              KampfArtExtern => KartenKonstanten.KampfAngriff);
      end case;
      
   end GrundAngriff;
   
   
   
   function GrundBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseKartenDatenbank.Bewertung (GrundExtern => LeseKarten.Grund (PositionExtern => PositionExtern),
                                            RasseExtern => RasseExtern);
      
   end GrundBewertung;
   
   
   
   function FlussNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      
   end FlussNahrung;
   
   
   
   function FlussProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      
   end FlussProduktion;
   
   
   
   function FlussGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                        RasseExtern    => RasseExtern,
                                        KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      
   end FlussVerteidigung;
   
   

   function FlussAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                        RasseExtern    => RasseExtern,
                                        KampfArtExtern => KartenKonstanten.KampfAngriff);
      
   end FlussAngriff;
   
   
   
   function FlussBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseKartenDatenbank.Bewertung (GrundExtern => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern => RasseExtern);
      
   end FlussBewertung;
   
   
   
   function WegNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftNahrung);
      
   end WegNahrung;
   
   
   
   function WegProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftProduktion);
      
   end WegProduktion;
   
   
   
   function WegGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftGeld);
      
   end WegGeld;
   
   
   
   function WegWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftForschung);
      
   end WegWissen;
   
   
   
   function WegVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseVerbesserungenDatenbank.Kampf (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                RasseExtern        => RasseExtern,
                                                WelcherWertExtern  => KartenKonstanten.KampfVerteidigung);
      
   end WegVerteidigung;
   
   
   
   function WegAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseVerbesserungenDatenbank.Kampf (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                RasseExtern        => RasseExtern,
                                                WelcherWertExtern  => KartenKonstanten.KampfAngriff);
      
   end WegAngriff;
   
   
   
   function WegBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Bewertung (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                    RasseExtern        => RasseExtern);
      
   end WegBewertung;
   
   
   
   function VerbesserungNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftNahrung);
      
   end VerbesserungNahrung;
   
   
   
   function VerbesserungProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftProduktion);
      
   end VerbesserungProduktion;
   
   
   
   function VerbesserungGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftGeld);
      
   end VerbesserungGeld;
   
   
   
   function VerbesserungWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Wirtschaft (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                     RasseExtern        => RasseExtern,
                                                     WelcherWertExtern  => KartenKonstanten.WirtschaftForschung);
      
   end VerbesserungWissen;
   
   
   
   function VerbesserungVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseVerbesserungenDatenbank.Kampf (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                RasseExtern        => RasseExtern,
                                                WelcherWertExtern  => KartenKonstanten.KampfVerteidigung);
      
   end VerbesserungVerteidigung;
   
   
   
   function VerbesserungAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseVerbesserungenDatenbank.Kampf (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                RasseExtern        => RasseExtern,
                                                WelcherWertExtern  => KartenKonstanten.KampfAngriff);
      
   end VerbesserungAngriff;
   
   
   
   function VerbesserungBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseVerbesserungenDatenbank.Bewertung (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                    RasseExtern        => RasseExtern);
      
   end VerbesserungBewertung;
   
   
   
   function RessourceNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftNahrung);
      
   end RessourceNahrung;
   
   
   
   function RessourceProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftProduktion);
      
   end RessourceProduktion;
   
   
   
   function RessourceGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftGeld);
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.Wirtschaft (GrundExtern         => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                             RasseExtern         => RasseExtern,
                                             WirtschaftArtExtern => KartenKonstanten.WirtschaftForschung);
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                        RasseExtern    => RasseExtern,
                                        KampfArtExtern => KartenKonstanten.KampfVerteidigung);
      
   end RessourceVerteidigung;
   
   
   
   function RessourceAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return LeseKartenDatenbank.Kampf (GrundExtern    => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                        RasseExtern    => RasseExtern,
                                        KampfArtExtern => KartenKonstanten.KampfAngriff);
      
   end RessourceAngriff;
   
   
   
   function RessourceBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return LeseKartenDatenbank.Bewertung (GrundExtern => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern => RasseExtern);
      
   end RessourceBewertung;
   
   
   
   function PassierbarGrund
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseKartenDatenbank.Passierbarkeit (GrundExtern          => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                 WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarGrund;
   
   
   
   function PassierbarVerbesserung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                         WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarVerbesserung;
   
   
   
   function PassierbarWeg
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in EinheitStadtDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                         WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarWeg;

end KartenAllgemein;
