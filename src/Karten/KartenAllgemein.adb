pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;

with LeseKarten;
with LeseKartenDatenbank;
with LeseVerbesserungenDatenbank;

with Anzeige;

package body KartenAllgemein is

   procedure Beschreibung
     (KartenGrundExtern : in KartenDatentypen.Karten_Grund_Enum)
   is begin

      case
        KartenGrundExtern
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => KartenDatentypen.Karten_Grund_Enum'Pos (KartenGrundExtern),
                                           LetzteZeileExtern      => KartenDatentypen.Karten_Grund_Enum'Pos (KartenGrundExtern),
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      end case;
      
   end Beschreibung;
   
   
   
   function GrundNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Nahrung)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => KartenDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Nahrung)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Nahrung);
      end if;
      
      
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Produktion)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => KartenDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Produktion)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Produktion);
      end if;
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Geld)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => KartenDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Geld)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Geld);
      end if;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Wissen)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => KartenDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Wissen)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Wissen);
      end if;
            
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Verteidigung)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => KartenDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Verteidigung)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Verteidigung);
      end if;
      
   end GrundVerteidigung;
   
   

   function GrundAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Angriff)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => KartenDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Angriff)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => KartenDatentypen.Angriff);
      end if;
      
   end GrundAngriff;
   
   
   
   function GrundBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Wertigkeit);
      
   end GrundBewertung;
   
   
   
   function FlussNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Nahrung);
      
   end FlussNahrung;
   
   
   
   function FlussProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Produktion);
      
   end FlussProduktion;
   
   
   
   function FlussGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Geld);
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Wissen);
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Verteidigung);
      
   end FlussVerteidigung;
   
   

   function FlussAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Angriff);
      
   end FlussAngriff;
   
   
   
   function FlussBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Wertigkeit);
      
   end FlussBewertung;
   
   
   
   function WegNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Nahrung);
      
   end WegNahrung;
   
   
   
   function WegProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Produktion);
      
   end WegProduktion;
   
   
   
   function WegGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Geld);
      
   end WegGeld;
   
   
   
   function WegWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Wissen);
      
   end WegWissen;
   
   
   
   function WegVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Verteidigung);
      
   end WegVerteidigung;
   
   
   
   function WegAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Angriff);
      
   end WegAngriff;
   
   
   
   function WegBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Wertigkeit);
      
   end WegBewertung;
   
   
   
   function VerbesserungNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Nahrung);
      
   end VerbesserungNahrung;
   
   
   
   function VerbesserungProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Produktion);
      
   end VerbesserungProduktion;
   
   
   
   function VerbesserungGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Geld);
      
   end VerbesserungGeld;
   
   
   
   function VerbesserungWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Wissen);
      
   end VerbesserungWissen;
   
   
   
   function VerbesserungVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Verteidigung);
      
   end VerbesserungVerteidigung;
   
   
   
   function VerbesserungAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Angriff);
      
   end VerbesserungAngriff;
   
   
   
   function VerbesserungBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => KartenDatentypen.Wertigkeit);
      
   end VerbesserungBewertung;
   
   
   
   function RessourceNahrung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Nahrung);
      
   end RessourceNahrung;
   
   
   
   function RessourceProduktion
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Produktion);
      
   end RessourceProduktion;
   
   
   
   function RessourceGeld
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Geld);
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Wissen);
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Verteidigung);
      
   end RessourceVerteidigung;
   
   
   
   function RessourceAngriff
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Angriff);
      
   end RessourceAngriff;
   
   
   
   function RessourceBewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => KartenDatentypen.Wertigkeit);
      
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
