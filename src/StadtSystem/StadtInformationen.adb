pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with KartenDatenbank, VerbesserungenDatenbank;

with Anzeige, VerbesserungenAllgemein, KartenAllgemein;

package body StadtInformationen is

   procedure StadtArtBesitzer
     (RasseExtern : in GlobaleDatentypen.Rassen;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID
      is
         when 0 =>
            return;
            
         when 1 =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 1,
                                              LetzteZeileExtern      => 1,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);

            else
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 3,
                                              LetzteZeileExtern      => 3,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            end if;
                  
         when 2 =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 2,
                                              LetzteZeileExtern      => 2,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                        
            else
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 4,
                                              LetzteZeileExtern      => 4,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            end if;
      end case;
      
   end StadtArtBesitzer;
   
   
   
   procedure StadtName
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name));
      
   end StadtName;
   
   
   
   procedure Einwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 5,
                                     LetzteZeileExtern      => 5,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)),
                               Width => 1);
      
   end Einwohner;
   
   
   
   procedure AktuelleNahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 6,
                                     LetzteZeileExtern      => 6,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel),
                               Width => 1);
      
   end AktuelleNahrungsmittel;
   
   
   
   procedure AktuelleNahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 7,
                                     LetzteZeileExtern      => 7,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion),
                               Width => 1);
      
   end AktuelleNahrungsproduktion;
   
   
   
   procedure AktuelleProduktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 8,
                                     LetzteZeileExtern      => 8,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate),
                               Width => 1);
      
   end AktuelleProduktionrate;
   
   
   
   procedure AktuelleGeldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 9,
                                     LetzteZeileExtern      => 9,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung),
                               Width => 1);
      
   end AktuelleGeldgewinnung;
   
   
   
   procedure AktuelleForschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 10,
                                     LetzteZeileExtern      => 10,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate),
                               Width => 1);
      
   end AktuelleForschungsrate;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 11,
                                     LetzteZeileExtern      => 11,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption),
                               Width => 1);
      
   end Korruption;
   
   
   
   procedure EinwohnerOhneArbeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 41,
                                     LetzteZeileExtern      => 41,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
                               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)),
                               Width => 1);
      
   end EinwohnerOhneArbeit;
   
   
   
   procedure AktuellesBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 12,
                                     LetzteZeileExtern      => 12,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt
      is
         -- Nichts
         when 0 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 28,
                                           LetzteZeileExtern      => 28,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);
            
            -- Gebäude
         when 1 .. 9_999 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Gebäude_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - 1_000,
                                           LetzteZeileExtern      => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - 1_000,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);

            -- Einheiten
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Einheiten_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - 10_000,
                                           LetzteZeileExtern      => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - 10_000,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);
      end case;
                                              
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 13,
                                     LetzteZeileExtern      => 13,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit),
                               Width => 1);
      New_Line;
      
   end AktuellesBauprojekt;
   
   
   
   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      Nahrungsgewinnung := 0;
      Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund).Nahrungsgewinnung;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource > 0
      then
         KartenAllgemein.Beschreibung (IDExtern => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource);
         Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource).Nahrungsgewinnung;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet > 0
      then
         VerbesserungenAllgemein.Beschreibung (IDExtern => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet);
         Nahrungsgewinnung
           := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet).Nahrungsbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße > 0
      then
         VerbesserungenAllgemein.Beschreibung (IDExtern => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße);
         Nahrungsgewinnung
           := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße).Nahrungsbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss > 0
      then
         KartenAllgemein.Beschreibung (IDExtern => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss);
         Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss).Nahrungsgewinnung;
         
      else
         null;
      end if;
      New_Line;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 20,
                                     LetzteZeileExtern      => 20,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Nahrungsgewinnung),
                               Width => 1);
      
   end EinzelnesFeldNahrungsgewinnung;
   
   
   
   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      Ressourcengewinnung := 0;
      Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund).Ressourcengewinnung;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource > 0
      then
         Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource).Ressourcengewinnung;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet > 0
      then
         Ressourcengewinnung
           := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet).Ressourcenbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße > 0
      then
         Ressourcengewinnung
           := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße).Ressourcenbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss > 0
      then
         Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss).Ressourcengewinnung;
         
      else
         null;
      end if;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 21,
                                     LetzteZeileExtern      => 21,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Ressourcengewinnung),
                               Width => 1);
      New_Line;
      
   end EinzelnesFeldRessourcengewinnung;
   
   
   
   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      Geldgewinnung := 0;      
      Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund).Geldgewinnung;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource > 0
      then
         Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource).Geldgewinnung;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet > 0
      then
         Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet).Geldbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße > 0
      then
         Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße).Geldbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss > 0
      then
         Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss).Geldgewinnung;
         
      else
         null;
      end if;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 22,
                                     LetzteZeileExtern      => 22,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Geldgewinnung),
                               Width => 1);
      
   end EinzelnesFeldGeldgewinnung;
   
   
   
   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      Wissensgewinnung := 0;
      Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund).Wissensgewinnung;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource > 0
      then
         Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource).Wissensgewinnung;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet > 0
      then
         Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet).Wissensbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße > 0
      then
         Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße).Wissensbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss > 0
      then
         Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss).Wissensgewinnung;
         
      else
         null;
      end if;
         
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 23,
                                     LetzteZeileExtern      => 23,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Wissensgewinnung),
                               Width => 1);
      New_Line;
      
   end EinzelnesFeldWissensgewinnung;
   
   
   
   procedure StadtfeldBewirtschaftet
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      CursorYAchseabstraktionExtern, CursorXAchseabstraktionExtern : in GlobaleDatentypen.Kartenfeld)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 42,
                                     LetzteZeileExtern      => 42,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      
      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (CursorYAchseabstraktionExtern, CursorXAchseabstraktionExtern)
      is
         when True =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Menü_Auswahl,
                                                  TextZeileExtern => 7);
               
         when False =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Menü_Auswahl,
                                                  TextZeileExtern => 8);
      end case;
      
   end StadtfeldBewirtschaftet;

end StadtInformationen;
