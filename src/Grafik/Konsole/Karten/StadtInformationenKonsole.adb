pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Integer_Wide_Wide_Text_IO;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
-- with GlobaleTexte;
with StadtKonstanten;
with KartenVerbesserungDatentypen;

with LeseStadtGebaut;

-- with TextAnzeigeKonsole;
with GesamtwerteFeld;
with KampfwerteStadtErmitteln;
with DebugPlatzhalter;
with Fehler;

package body StadtInformationenKonsole is
   
   procedure Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet.
      StadtArtBesitzer (RasseExtern            => RasseExtern,
                        StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtName (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Einwohner (StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          DebugPlatzhalter.FeindlicheInformationenSehen
      then
         AktuelleNahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleNahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
         New_Line;
                        
         AktuelleProduktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleGeldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleForschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern);
         New_Line;
         
         AktuelleVerteidigung (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuellerAngriff (StadtRasseNummerExtern => StadtRasseNummerExtern);
         New_Line;

         Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern);
         EinwohnerOhneArbeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
         New_Line;
               
         AktuellesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);

      else
         null;
      end if;
      New_Line;
      
   end Stadt;
   
   

   procedure StadtArtBesitzer
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "StadtInformationenKonsole.StadtArtBesitzer - Stadt sollte existieren tut sie aber nicht.");
            
         when KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 1;

            else
               Stadtart := 3;
            end if;
                  
         when KartenVerbesserungDatentypen.Eigene_Stadt_Enum =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 2;
                        
            else
               Stadtart := 4;
            end if;
      end case;
      
      -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => Stadtart,
      --                                          LetzteZeileExtern      => Stadtart,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
   end StadtArtBesitzer;
   
   
   
   procedure StadtName
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Put (Item => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern)));
      
   end StadtName;
   
   
   
   procedure Einwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
       --                                         ErsteZeileExtern       => 5,
      --                                          LetzteZeileExtern      => 5,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
       --                                         AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                              EinwohnerArbeiterExtern => True)),
                                         Width => 1);
      
   end Einwohner;
   
   
   
   procedure AktuelleNahrungsmittel
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 6,
     --                                           LetzteZeileExtern      => 6,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
     --                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      
   end AktuelleNahrungsmittel;
   
   
   
   procedure AktuelleNahrungsproduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
    --  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
    --                                            ErsteZeileExtern       => 7,
    --                                            LetzteZeileExtern      => 7,
    --                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
    --                                            AbstandMitteExtern     => GlobaleTexte.Leer,
    --                                            AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      
   end AktuelleNahrungsproduktion;
   
   
   
   procedure AktuelleProduktionrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 8,
     --                                           LetzteZeileExtern      => 8,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      
   end AktuelleProduktionrate;
   
   
   
   procedure AktuelleGeldgewinnung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
    --  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 9,
      --                                          LetzteZeileExtern      => 9,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      
   end AktuelleGeldgewinnung;
   
   
   
   procedure AktuelleForschungsrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 10,
      --                                          LetzteZeileExtern      => 10,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      
   end AktuelleForschungsrate;
   
   
   
   procedure AktuelleVerteidigung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                          ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 25,
     --                                           LetzteZeileExtern      => 25,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
    --  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 62,
     --                                           LetzteZeileExtern      => 62,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      
   end AktuellerAngriff;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
    --  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
    --                                            TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 11,
      --                                          LetzteZeileExtern      => 11,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
       --                                         AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      
   end Korruption;
   
   
   
   procedure EinwohnerOhneArbeit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 41,
      --                                          LetzteZeileExtern      => 41,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                              EinwohnerArbeiterExtern => True) - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                                                    EinwohnerArbeiterExtern => False)),
                                         Width => 1);
      
   end EinwohnerOhneArbeit;
   
   
   
   procedure AktuellesBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 12,
     --                                           LetzteZeileExtern      => 12,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      if
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer = StadtKonstanten.LeerBauprojekt.Nummer
      then
       --  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
        --                                           TextDateiExtern        => GlobaleTexte.Zeug,
        --                                           ÜberschriftZeileExtern => 0,
        --                                           ErsteZeileExtern       => 28,
        --                                           LetzteZeileExtern      => 28,
        --                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
        --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                           AbstandEndeExtern      => GlobaleTexte.Leer);
       null;
            
      elsif
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).GebäudeEinheit = True
      then
       --  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
        --                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Gebäude_Kurz,
        --                                           ÜberschriftZeileExtern => 0,
        --                                           ErsteZeileExtern       => Positive (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer),
        --                                           LetzteZeileExtern      => Positive (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer),
        --                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
        --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
         --                                          AbstandEndeExtern      => GlobaleTexte.Leer);
         null;

      else
        -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
        --                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
        --                                           ÜberschriftZeileExtern => 0,
        --                                           ErsteZeileExtern       => Positive (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer),
        --                                           LetzteZeileExtern      => Positive (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer),
        --                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
        --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
        --                                           AbstandEndeExtern      => GlobaleTexte.Leer);
         null;
      end if;
                                              
    --  TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 13,
     --                                           LetzteZeileExtern      => 13,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                         Width => 1);
      New_Line;
      
   end AktuellesBauprojekt;
   
   
   
   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      New_Line;
         
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 20,
     --                                           LetzteZeileExtern      => 20,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                                                        RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end EinzelnesFeldNahrungsgewinnung;
   
   
   
   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
                     
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 21,
      --                                          LetzteZeileExtern      => 21,
       --                                         AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
       --                                         AbstandMitteExtern     => GlobaleTexte.Leer,
        --                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                                           RasseExtern       => RasseExtern)),
                                         Width => 1);
      New_Line;
      
   end EinzelnesFeldRessourcengewinnung;
   
   
   
   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
       
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 22,
       --                                         LetzteZeileExtern      => 22,
       --                                         AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
       --                                         AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                                                     RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end EinzelnesFeldGeldgewinnung;
   
   
   
   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
               
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 23,
     --                                           LetzteZeileExtern      => 23,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                                                       RasseExtern       => RasseExtern)),
                                         Width => 1);
      New_Line;
      
   end EinzelnesFeldWissensgewinnung;
   
   
   
   procedure StadtfeldBewirtschaftet
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      CursorYAchseabstraktionExtern : in KartenDatentypen.Kartenfeld;
      CursorXAchseabstraktionExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
     -- TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 42,
      --                                          LetzteZeileExtern      => 42,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      case
        LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 YKoordinateExtern      => CursorYAchseabstraktionExtern,
                                                 XKoordinateExtern      => CursorXAchseabstraktionExtern)
      is
         when True =>
        --    TextAnzeigeKonsole.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Menü_Auswahl,
        --                                                    TextZeileExtern => 7);
            null;
               
         when False =>
         --   TextAnzeigeKonsole.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Menü_Auswahl,
         --                                                    TextZeileExtern => 8);
            null;
      end case;
      
   end StadtfeldBewirtschaftet;

end StadtInformationenKonsole;