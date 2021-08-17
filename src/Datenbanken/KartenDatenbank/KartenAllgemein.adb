pragma SPARK_Mode (On);

with GlobaleTexte;

with KartenDatenbank, VerbesserungenDatenbank;

with Anzeige, LeseKarten;

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
        LeseKarten.Grund (PositionExtern => PositionExtern) /= GlobaleDatentypen.Hügel
        and
          LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Nahrung)
           + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (RasseExtern, GlobaleDatentypen.Nahrung) / 2;
         
      else
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Nahrung);
      end if;
      
      
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => PositionExtern) /= GlobaleDatentypen.Hügel
        and
          LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Produktion)
           + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (RasseExtern, GlobaleDatentypen.Produktion) / 2;
         
      else
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Produktion);
      end if;
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => PositionExtern) /= GlobaleDatentypen.Hügel
        and
          LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Geld)
           + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (RasseExtern, GlobaleDatentypen.Geld) / 2;
         
      else
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Geld);
      end if;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => PositionExtern) /= GlobaleDatentypen.Hügel
        and
          LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Wissen)
           + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (RasseExtern, GlobaleDatentypen.Wissen) / 2;
         
      else
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Wissen);
      end if;
            
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => PositionExtern) /= GlobaleDatentypen.Hügel
        and
          LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Verteidigung)
           + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (RasseExtern, GlobaleDatentypen.Verteidigung) / 2;
         
      else
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Verteidigung);
      end if;
      
   end GrundVerteidigung;
   
   

   function GrundAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => PositionExtern) /= GlobaleDatentypen.Hügel
        and
          LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Angriff)
           + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (RasseExtern, GlobaleDatentypen.Angriff) / 2;
         
      else
         return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Angriff);
      end if;
      
   end GrundAngriff;
   
   
   
   function GrundBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Wertigkeit);
      
   end GrundBewertung;
   
   
   
   function FlussNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Fluss (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Nahrung);
      
   end FlussNahrung;
   
   
   
   function FlussProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Fluss (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Produktion);
      
   end FlussProduktion;
   
   
   
   function FlussGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Fluss (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Geld);
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Fluss (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Wissen);
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Fluss (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Verteidigung);
      
   end FlussVerteidigung;
   
   

   function FlussAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Fluss (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Angriff);
      
   end FlussAngriff;
   
   
   
   function FlussBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Fluss (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Wertigkeit);
      
   end FlussBewertung;
   
   
   
   function WegNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Nahrung);
      
   end WegNahrung;
   
   
   
   function WegProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Produktion);
      
   end WegProduktion;
   
   
   
   function WegGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Geld);
      
   end WegGeld;
   
   
   
   function WegWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Wissen);
      
   end WegWissen;
   
   
   
   function WegVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Verteidigung);
      
   end WegVerteidigung;
   
   
   
   function WegAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Angriff);
      
   end WegAngriff;
   
   
   
   function WegBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Wertigkeit);
      
   end WegBewertung;
   
   
   
   function VerbesserungNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Nahrung);
      
   end VerbesserungNahrung;
   
   
   
   function VerbesserungProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Produktion);
      
   end VerbesserungProduktion;
   
   
   
   function VerbesserungGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Geld);
      
   end VerbesserungGeld;
   
   
   
   function VerbesserungWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Wissen);
      
   end VerbesserungWissen;
   
   
   
   function VerbesserungVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Verteidigung);
      
   end VerbesserungVerteidigung;
   
   
   
   function VerbesserungAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Angriff);
      
   end VerbesserungAngriff;
   
   
   
   function VerbesserungBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern)).VerbesserungWerte (RasseExtern, GlobaleDatentypen.Wertigkeit);
      
   end VerbesserungBewertung;
   
   
   
   function RessourceNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Ressource (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Nahrung);
      
   end RessourceNahrung;
   
   
   
   function RessourceProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Ressource (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Produktion);
      
   end RessourceProduktion;
   
   
   
   function RessourceGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Ressource (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Geld);
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Ressource (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Wissen);
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Ressource (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Verteidigung);
      
   end RessourceVerteidigung;
   
   
   
   function RessourceAngriff
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Ressource (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Angriff);
      
   end RessourceAngriff;
   
   
   
   function RessourceBewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Ressource (PositionExtern => PositionExtern)).FeldWerte (RasseExtern, GlobaleDatentypen.Wertigkeit);
      
   end RessourceBewertung;
   
   
   
   function PassierbarGrund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.KartenListe (LeseKarten.Grund (PositionExtern => PositionExtern)).Passierbarkeit (PassierbarkeitExtern);
      
   end PassierbarGrund;
   
   
   
   function PassierbarVerbesserung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungGebiet (PositionExtern => PositionExtern)).Passierbarkeit (PassierbarkeitExtern);
      
   end PassierbarVerbesserung;
   
   
   
   function PassierbarWeg
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (LeseKarten.VerbesserungWeg (PositionExtern => PositionExtern)).Passierbarkeit (PassierbarkeitExtern);
      
   end PassierbarWeg;

end KartenAllgemein;
