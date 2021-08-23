pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleTexte, GlobaleKonstanten;

with Anzeige, GesamtwerteFeld, KampfwerteStadtErmitteln, LeseStadtGebaut;

package body StadtInformationen is

   procedure StadtArtBesitzer
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
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
      
      Put (Item => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern)));
      
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
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                    EinwohnerArbeiterExtern => True)),
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
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)),
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
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)),
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
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
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
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern)),
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
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                               Width => 1);
      
   end AktuelleForschungsrate;
   
   
   
   procedure AktuelleVerteidigung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 25,
                                     LetzteZeileExtern      => 25,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                               Width => 1);
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 62,
                                     LetzteZeileExtern      => 62,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                               Width => 1);
      
   end AktuellerAngriff;
   
   
   
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
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)),
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
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                    EinwohnerArbeiterExtern => True) - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                                          EinwohnerArbeiterExtern => False)),
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
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when GlobaleKonstanten.LeerBauprojekt =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 28,
                                           LetzteZeileExtern      => 28,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            
         when GlobaleKonstanten.BauprojekteGebäudeAnfang .. GlobaleKonstanten.BauprojekteGebäudeEnde =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Gebäude_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.GebäudeAufschlag,
                                           LetzteZeileExtern      => LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.GebäudeAufschlag,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);

         when GlobaleKonstanten.BauprojekteEinheitenAnfang .. GlobaleKonstanten.BauprojekteEinheitenEnde =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.EinheitAufschlag,
                                           LetzteZeileExtern      => LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.EinheitAufschlag,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            
         when others =>
            null;
      end case;
                                              
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 13,
                                     LetzteZeileExtern      => 13,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                               Width => 1);
      New_Line;
      
   end AktuellesBauprojekt;
   
   
   
   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      New_Line;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 20,
                                     LetzteZeileExtern      => 20,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                                              RasseExtern       => RasseExtern)),
                               Width => 1);
      
   end EinzelnesFeldNahrungsgewinnung;
   
   
   
   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
                     
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 21,
                                     LetzteZeileExtern      => 21,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                                 RasseExtern       => RasseExtern)),
                               Width => 1);
      New_Line;
      
   end EinzelnesFeldRessourcengewinnung;
   
   
   
   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
       
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 22,
                                     LetzteZeileExtern      => 22,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                                           RasseExtern       => RasseExtern)),
                               Width => 1);
      
   end EinzelnesFeldGeldgewinnung;
   
   
   
   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
               
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 23,
                                     LetzteZeileExtern      => 23,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                                             RasseExtern       => RasseExtern)),
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
        LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 YPositionExtern        => CursorYAchseabstraktionExtern,
                                                 XPositionExtern        => CursorXAchseabstraktionExtern)
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
