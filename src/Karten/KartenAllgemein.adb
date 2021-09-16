pragma SPARK_Mode (On);

with GlobaleTexte;

with LeseKarten, LeseKartenDatenbank, LeseVerbesserungenDatenbank;

with Anzeige;

package body KartenAllgemein is

   procedure Beschreibung
     (KartenGrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin

      case
        KartenGrundExtern
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => GlobaleDatentypen.Karten_Grund_Enum'Pos (KartenGrundExtern),
                                           LetzteZeileExtern      => GlobaleDatentypen.Karten_Grund_Enum'Pos (KartenGrundExtern),
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      end case;
      
   end Beschreibung;
   
   
   
   function GrundNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Nahrung)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => GlobaleDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Nahrung)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Nahrung);
      end if;
      
      
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Produktion)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => GlobaleDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Produktion)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Produktion);
      end if;
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Geld)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => GlobaleDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Geld)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Geld);
      end if;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Wissen)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => GlobaleDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Wissen)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Wissen);
      end if;
            
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Verteidigung)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => GlobaleDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Verteidigung)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Verteidigung);
      end if;
      
   end GrundVerteidigung;
   
   

   function GrundAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Angriff)
           + LeseKartenDatenbank.FeldWerte (GrundExtern       => GlobaleDatentypen.Hügel_Mit,
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Angriff)
           / 2;
         
      else
         return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                               RasseExtern       => RasseExtern,
                                               WelcherWertExtern => GlobaleDatentypen.Angriff);
      end if;
      
   end GrundAngriff;
   
   
   
   function GrundBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Grund (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Wertigkeit);
      
   end GrundBewertung;
   
   
   
   function FlussNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Nahrung);
      
   end FlussNahrung;
   
   
   
   function FlussProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Produktion);
      
   end FlussProduktion;
   
   
   
   function FlussGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Geld);
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Wissen);
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Verteidigung);
      
   end FlussVerteidigung;
   
   

   function FlussAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Angriff);
      
   end FlussAngriff;
   
   
   
   function FlussBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Fluss (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Wertigkeit);
      
   end FlussBewertung;
   
   
   
   function WegNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Nahrung);
      
   end WegNahrung;
   
   
   
   function WegProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Produktion);
      
   end WegProduktion;
   
   
   
   function WegGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Geld);
      
   end WegGeld;
   
   
   
   function WegWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Wissen);
      
   end WegWissen;
   
   
   
   function WegVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Verteidigung);
      
   end WegVerteidigung;
   
   
   
   function WegAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Angriff);
      
   end WegAngriff;
   
   
   
   function WegBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Wertigkeit);
      
   end WegBewertung;
   
   
   
   function VerbesserungNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Nahrung);
      
   end VerbesserungNahrung;
   
   
   
   function VerbesserungProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Produktion);
      
   end VerbesserungProduktion;
   
   
   
   function VerbesserungGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Geld);
      
   end VerbesserungGeld;
   
   
   
   function VerbesserungWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Wissen);
      
   end VerbesserungWissen;
   
   
   
   function VerbesserungVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Verteidigung);
      
   end VerbesserungVerteidigung;
   
   
   
   function VerbesserungAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Angriff);
      
   end VerbesserungAngriff;
   
   
   
   function VerbesserungBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                            RasseExtern        => RasseExtern,
                                                            WelcherWertExtern  => GlobaleDatentypen.Wertigkeit);
      
   end VerbesserungBewertung;
   
   
   
   function RessourceNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Nahrung);
      
   end RessourceNahrung;
   
   
   
   function RessourceProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Produktion);
      
   end RessourceProduktion;
   
   
   
   function RessourceGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Geld);
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Wissen);
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Verteidigung);
      
   end RessourceVerteidigung;
   
   
   
   function RessourceAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Angriff);
      
   end RessourceAngriff;
   
   
   
   function RessourceBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return LeseKartenDatenbank.FeldWerte (GrundExtern       => LeseKarten.Ressource (PositionExtern => PositionExtern),
                                            RasseExtern       => RasseExtern,
                                            WelcherWertExtern => GlobaleDatentypen.Wertigkeit);
      
   end RessourceBewertung;
   
   
   
   function PassierbarGrund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseKartenDatenbank.Passierbarkeit (GrundExtern          => LeseKarten.Grund (PositionExtern => PositionExtern),
                                                 WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarGrund;
   
   
   
   function PassierbarVerbesserung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern),
                                                         WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarVerbesserung;
   
   
   
   function PassierbarWeg
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return LeseVerbesserungenDatenbank.Passierbarkeit (VerbesserungExtern   => LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern),
                                                         WelcheUmgebungExtern => PassierbarkeitExtern);
      
   end PassierbarWeg;

end KartenAllgemein;
