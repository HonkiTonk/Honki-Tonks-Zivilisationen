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
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).Nahrungsgewinnung;
      
   end GrundNahrung;
   
   
   
   function GrundRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).Ressourcengewinnung;
      
   end GrundRessourcen;
   
   
   
   function GrundGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).Geldgewinnung;
      
   end GrundGeld;
   
   
   
   function GrundWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).Wissensgewinnung;
      
   end GrundWissen;
   
   
   
   function GrundVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund).Verteidigungsbonus;
      
   end GrundVerteidigung;
   
   
   
   function FlussNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).Nahrungsgewinnung;
      
   end FlussNahrung;
   
   
   
   function FlussRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).Ressourcengewinnung;
      
   end FlussRessourcen;
   
   
   
   function FlussGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).Geldgewinnung;
      
   end FlussGeld;
   
   
   
   function FlussWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).Wissensgewinnung;
      
   end FlussWissen;
   
   
   
   function FlussVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss).Verteidigungsbonus;
      
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
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).Nahrungsgewinnung;
      
   end RessourceNahrung;
   
   
   
   function RessourceRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).Ressourcengewinnung;
      
   end RessourceRessourcen;
   
   
   
   function RessourceGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).Geldgewinnung;
      
   end RessourceGeld;
   
   
   
   function RessourceWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).Wissensgewinnung;
      
   end RessourceWissen;
   
   
   
   function RessourceVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenDatenbank.KartenListe (Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource).Verteidigungsbonus;
      
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
