pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleTexte;

with Anzeige, VerbesserungenAllgemein, KartenAllgemein;

package body StadtInformationen is

   procedure StadtArtBesitzer
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID
      is
         when GlobaleDatentypen.Leer =>
            return;
            
         when GlobaleDatentypen.Eigene_Hauptstadt =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 1,
                                              LetzteZeileExtern      => 1,
                                              AbstandAnfangExtern    => GlobaleTexte.Leer,
                                              AbstandMitteExtern     => GlobaleTexte.Leer,
                                              AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);

            else
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 3,
                                              LetzteZeileExtern      => 3,
                                              AbstandAnfangExtern    => GlobaleTexte.Leer,
                                              AbstandMitteExtern     => GlobaleTexte.Leer,
                                              AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            end if;
                  
         when GlobaleDatentypen.Eigene_Stadt =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 2,
                                              LetzteZeileExtern      => 2,
                                              AbstandAnfangExtern    => GlobaleTexte.Leer,
                                              AbstandMitteExtern     => GlobaleTexte.Leer,
                                              AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
                        
            else
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 4,
                                              LetzteZeileExtern      => 4,
                                              AbstandAnfangExtern    => GlobaleTexte.Leer,
                                              AbstandMitteExtern     => GlobaleTexte.Leer,
                                              AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            end if;
      end case;
      
   end StadtArtBesitzer;
   
   
   
   procedure StadtName
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name));
      
   end StadtName;
   
   
   
   procedure Einwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 5,
                                     LetzteZeileExtern      => 5,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)),
                               Width => 1);
      
   end Einwohner;
   
   
   
   procedure AktuelleNahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 6,
                                     LetzteZeileExtern      => 6,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel),
                               Width => 1);
      
   end AktuelleNahrungsmittel;
   
   
   
   procedure AktuelleNahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 7,
                                     LetzteZeileExtern      => 7,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion),
                               Width => 1);
      
   end AktuelleNahrungsproduktion;
   
   
   
   procedure AktuelleProduktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 8,
                                     LetzteZeileExtern      => 8,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate),
                               Width => 1);
      
   end AktuelleProduktionrate;
   
   
   
   procedure AktuelleGeldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 9,
                                     LetzteZeileExtern      => 9,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung),
                               Width => 1);
      
   end AktuelleGeldgewinnung;
   
   
   
   procedure AktuelleForschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 10,
                                     LetzteZeileExtern      => 10,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate),
                               Width => 1);
      
   end AktuelleForschungsrate;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 11,
                                     LetzteZeileExtern      => 11,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption),
                               Width => 1);
      
   end Korruption;
   
   
   
   procedure EinwohnerOhneArbeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 41,
                                     LetzteZeileExtern      => 41,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
                               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)),
                               Width => 1);
      
   end EinwohnerOhneArbeit;
   
   
   
   procedure AktuellesBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 12,
                                     LetzteZeileExtern      => 12,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt
      is
         -- Nichts
         when 0 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 28,
                                           LetzteZeileExtern      => 28,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            
            -- Gebäude
         when 1 .. 9_999 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Gebäude_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - 1_000,
                                           LetzteZeileExtern      => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - 1_000,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);

            -- Einheiten
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - 10_000,
                                           LetzteZeileExtern      => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - 10_000,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
      end case;
                                              
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 13,
                                     LetzteZeileExtern      => 13,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit),
                               Width => 1);
      New_Line;
      
   end AktuellesBauprojekt;
   
   
   
   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Nahrungsgewinnung := 0;
      Nahrungsgewinnung := Nahrungsgewinnung + KartenAllgemein.GrundNahrung (PositionExtern => KoordinatenExtern,
                                                                             RasseExtern    => RasseExtern);
      
      if
        KartenAllgemein.FeldRessource (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => KartenAllgemein.FeldRessource (PositionExtern => KoordinatenExtern));
         Nahrungsgewinnung := Nahrungsgewinnung + KartenAllgemein.RessourceNahrung (PositionExtern => KoordinatenExtern,
                                                                                    RasseExtern    => RasseExtern);
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldVerbesserung (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Gebilde_Enum
      then
         VerbesserungenAllgemein.Beschreibung (KartenVerbesserungExtern => KartenAllgemein.FeldVerbesserung (PositionExtern => KoordinatenExtern));
         Nahrungsgewinnung := Nahrungsgewinnung + KartenAllgemein.VerbesserungNahrung (PositionExtern => KoordinatenExtern,
                                                                                       RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldWeg (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Weg_Enum
      then
         VerbesserungenAllgemein.Beschreibung (KartenVerbesserungExtern => KartenAllgemein.FeldWeg (PositionExtern => KoordinatenExtern));
         Nahrungsgewinnung := Nahrungsgewinnung + KartenAllgemein.WegNahrung (PositionExtern => KoordinatenExtern,
                                                                              RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldFluss (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => KartenAllgemein.FeldFluss (PositionExtern => KoordinatenExtern));
         Nahrungsgewinnung := Nahrungsgewinnung + KartenAllgemein.FlussNahrung (PositionExtern => KoordinatenExtern,
                                                                                RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      New_Line;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 20,
                                     LetzteZeileExtern      => 20,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Nahrungsgewinnung),
                               Width => 1);
      
   end EinzelnesFeldNahrungsgewinnung;
   
   
   
   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Ressourcengewinnung := 0;
      Ressourcengewinnung := Ressourcengewinnung + KartenAllgemein.GrundProduktion (PositionExtern => KoordinatenExtern,
                                                                                    RasseExtern    => RasseExtern);
      
      if
        KartenAllgemein.FeldRessource (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range
      then
         Ressourcengewinnung := Ressourcengewinnung + KartenAllgemein.RessourceProduktion (PositionExtern => KoordinatenExtern,
                                                                                           RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldVerbesserung (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Gebilde_Enum
      then
         Ressourcengewinnung := Ressourcengewinnung + KartenAllgemein.VerbesserungProduktion (PositionExtern => KoordinatenExtern,
                                                                                              RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldWeg (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Weg_Enum
      then
         Ressourcengewinnung := Ressourcengewinnung + KartenAllgemein.WegProduktion (PositionExtern => KoordinatenExtern,
                                                                                     RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldFluss (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range
      then
         Ressourcengewinnung := Ressourcengewinnung + KartenAllgemein.FlussProduktion (PositionExtern => KoordinatenExtern,
                                                                                       RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 21,
                                     LetzteZeileExtern      => 21,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Ressourcengewinnung),
                               Width => 1);
      New_Line;
      
   end EinzelnesFeldRessourcengewinnung;
   
   
   
   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Geldgewinnung := 0;      
      Geldgewinnung := Geldgewinnung + KartenAllgemein.GrundGeld (PositionExtern => KoordinatenExtern,
                                                                  RasseExtern    => RasseExtern);
      
      if
        KartenAllgemein.FeldRessource (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range
      then
         Geldgewinnung := Geldgewinnung + KartenAllgemein.RessourceGeld (PositionExtern => KoordinatenExtern,
                                                                         RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldVerbesserung (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Gebilde_Enum
      then
         Geldgewinnung := Geldgewinnung + KartenAllgemein.VerbesserungGeld (PositionExtern => KoordinatenExtern,
                                                                            RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldWeg (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Weg_Enum
      then
         Geldgewinnung := Geldgewinnung + KartenAllgemein.WegGeld (PositionExtern => KoordinatenExtern,
                                                                   RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldFluss (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range
      then
         Geldgewinnung := Geldgewinnung + KartenAllgemein.FlussGeld (PositionExtern => KoordinatenExtern,
                                                                     RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 22,
                                     LetzteZeileExtern      => 22,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Geldgewinnung),
                               Width => 1);
      
   end EinzelnesFeldGeldgewinnung;
   
   
   
   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Wissensgewinnung := 0;
      Wissensgewinnung := Wissensgewinnung + KartenAllgemein.GrundWissen (PositionExtern => KoordinatenExtern,
                                                                          RasseExtern    => RasseExtern);
      
      if
        KartenAllgemein.FeldRessource (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range
      then
         Wissensgewinnung := Wissensgewinnung + KartenAllgemein.RessourceWissen (PositionExtern => KoordinatenExtern,
                                                                                 RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldVerbesserung (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Gebilde_Enum
      then
         Wissensgewinnung := Wissensgewinnung + KartenAllgemein.VerbesserungWissen (PositionExtern => KoordinatenExtern,
                                                                                    RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldWeg (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Weg_Enum
      then
         Wissensgewinnung := Wissensgewinnung + KartenAllgemein.WegWissen (PositionExtern => KoordinatenExtern,
                                                                           RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
      
      if
        KartenAllgemein.FeldFluss (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range
      then
         Wissensgewinnung := Wissensgewinnung + KartenAllgemein.FlussWissen (PositionExtern => KoordinatenExtern,
                                                                             RasseExtern    => RasseExtern);
         
      else
         null;
      end if;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 23,
                                     LetzteZeileExtern      => 23,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Wissensgewinnung),
                               Width => 1);
      New_Line;
      
   end EinzelnesFeldWissensgewinnung;
   
   
   
   procedure StadtfeldBewirtschaftet
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      CursorYAchseabstraktionExtern, CursorXAchseabstraktionExtern : in GlobaleDatentypen.Kartenfeld)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 42,
                                     LetzteZeileExtern      => 42,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (CursorYAchseabstraktionExtern, CursorXAchseabstraktionExtern)
      is
         when True =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Menü_Auswahl,
                                                  TextZeileExtern => 7);
               
         when False =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Menü_Auswahl,
                                                  TextZeileExtern => 8);
      end case;
      
   end StadtfeldBewirtschaftet;

end StadtInformationen;
