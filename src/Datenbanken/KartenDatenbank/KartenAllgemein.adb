pragma SPARK_Mode (On);

with GlobaleTexte;

with KartenDatenbank, VerbesserungenDatenbank;

with Anzeige, Karten;

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
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).FeldWerte (RasseExtern, GlobaleDatentypen.Nahrung);
      
   end GrundNahrung;
   
   
   
   function GrundProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).FeldWerte (RasseExtern, GlobaleDatentypen.Produktion);
      
   end GrundProduktion;
   
   
   
   function GrundGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).FeldWerte (RasseExtern, GlobaleDatentypen.Geld);
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).FeldWerte (RasseExtern, GlobaleDatentypen.Wissen);
      
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).FeldWerte (RasseExtern, GlobaleDatentypen.Verteidigung);
      
   end GrundVerteidigung;
   
   
   
   function FlussNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).FeldWerte (RasseExtern, GlobaleDatentypen.Nahrung);
      
   end FlussNahrung;
   
   
   
   function FlussProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).FeldWerte (RasseExtern, GlobaleDatentypen.Produktion);
      
   end FlussProduktion;
   
   
   
   function FlussGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).FeldWerte (RasseExtern, GlobaleDatentypen.Geld);
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).FeldWerte (RasseExtern, GlobaleDatentypen.Wissen);
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).FeldWerte (RasseExtern, GlobaleDatentypen.Verteidigung);
      
   end FlussVerteidigung;
   
   
   
   function StraßeNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungStraße).Nahrungsbonus;
      
   end StraßeNahrung;
   
   
   
   function StraßeRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungStraße).Ressourcenbonus;
      
   end StraßeRessourcen;
   
   
   
   function StraßeGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungStraße).Geldbonus;
      
   end StraßeGeld;
   
   
   
   function StraßeWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungStraße).Wissensbonus;
      
   end StraßeWissen;
   
   
   
   function StraßeVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungStraße).Verteidigungsbonus;
      
   end StraßeVerteidigung;
   
   
   
   function VerbesserungNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet).Nahrungsbonus;
      
   end VerbesserungNahrung;
   
   
   
   function VerbesserungRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet).Ressourcenbonus;
      
   end VerbesserungRessourcen;
   
   
   
   function VerbesserungGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet).Geldbonus;
      
   end VerbesserungGeld;
   
   
   
   function VerbesserungWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet).Wissensbonus;
      
   end VerbesserungWissen;
   
   
   
   function VerbesserungVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet).Verteidigungsbonus;
      
   end VerbesserungVerteidigung;
   
   
   
   function RessourceNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).FeldWerte (RasseExtern, GlobaleDatentypen.Nahrung);
      
   end RessourceNahrung;
   
   
   
   function RessourceProduktion
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).FeldWerte (RasseExtern, GlobaleDatentypen.Produktion);
      
   end RessourceProduktion;
   
   
   
   function RessourceGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).FeldWerte (RasseExtern, GlobaleDatentypen.Geld);
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).FeldWerte (RasseExtern, GlobaleDatentypen.Wissen);
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).FeldWerte (RasseExtern, GlobaleDatentypen.Verteidigung);
      
   end RessourceVerteidigung;
   
   
   
   function FeldSichtbar
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Sichtbar (RasseExtern);
        
   end FeldSichtbar;
   
   
   
   function FeldHügel
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Hügel;
      
   end FeldHügel;
   
   
   
   function FeldGrund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund;
      
   end FeldGrund;
   
   
   
   function FeldRessource
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource;
      
   end FeldRessource;
   
   
   
   function FeldVerbesserung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet;
      
   end FeldVerbesserung;
   
   
   
   function FeldStraße
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungStraße;
      
   end FeldStraße;
   
   
   
   function FeldFluss
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss;
      
   end FeldFluss;
   
   
   
   function PassierbarGrund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).Passierbarkeit (PassierbarkeitExtern);
      
   end PassierbarGrund;
   
   
   
   function PassierbarVerbesserung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet).Passierbarkeit (PassierbarkeitExtern);
      
   end PassierbarVerbesserung;
   
   
   
   function PassierbarStraße
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungStraße).Passierbarkeit (PassierbarkeitExtern);
      
   end PassierbarStraße;

end KartenAllgemein;
