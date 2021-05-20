pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with Anzeige;

package body StadtInformationen is

   procedure StadtArtBesitzer
     (RasseExtern : in GlobaleDatentypen.Rassen;
      RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).ID
      is
         when 1 =>
            if
              RasseExtern = RasseUndPlatznummerExtern.Rasse
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
                  
         when others =>
            if
              RasseExtern = RasseUndPlatznummerExtern.Rasse
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
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).Name));
      
   end StadtName;
   
   
   
   procedure Einwohner
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 5,
                                     LetzteZeileExtern      => 5,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).Einwohner),
                               Width => 1);
      
   end Einwohner;
   
   
   
   procedure AktuelleNahrungsmittel
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 6,
                                     LetzteZeileExtern      => 6,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuelleNahrungsmittel),
                               Width => 1);
      
   end AktuelleNahrungsmittel;
   
   
   
   procedure AktuelleNahrungsproduktion
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 7,
                                     LetzteZeileExtern      => 7,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuelleNahrungsproduktion),
                               Width => 1);
      
   end AktuelleNahrungsproduktion;
   
   
   
   procedure AktuelleProduktionrate
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 8,
                                     LetzteZeileExtern      => 8,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuelleProduktionrate),
                               Width => 1);
      
   end AktuelleProduktionrate;
   
   
   
   procedure AktuelleGeldgewinnung
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 9,
                                     LetzteZeileExtern      => 9,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuelleGeldgewinnung),
                               Width => 1);
      
   end AktuelleGeldgewinnung;
   
   
   
   procedure AktuelleForschungsrate
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 10,
                                     LetzteZeileExtern      => 10,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuelleForschungsrate),
                               Width => 1);
      
   end AktuelleForschungsrate;
   
   
   
   procedure Korruption
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 11,
                                     LetzteZeileExtern      => 11,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).Korruption),
                               Width => 1);
      
   end Korruption;
   
   
   
   procedure EinwohnerOhneArbeit
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 41,
                                     LetzteZeileExtern      => 41,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).Einwohner
                               - GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).ArbeitendeEinwohner),
                               Width => 1);
      
   end EinwohnerOhneArbeit;
   
   
   
   procedure AktuellesBauprojekt
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
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
        GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuellesBauprojekt
      is
         when 0 => -- Nichts                     
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 28,
                                           LetzteZeileExtern      => 28,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);
            
         when 1 .. 9_999 => -- Gebäude
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Gebäude_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuellesBauprojekt - 1_000,
                                           LetzteZeileExtern      => GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuellesBauprojekt - 1_000,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);

         when others => -- Einheiten
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Einheiten_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuellesBauprojekt - 10_000,
                                           LetzteZeileExtern      => GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).AktuellesBauprojekt - 10_000,
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
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummerExtern.Rasse, RasseUndPlatznummerExtern.Platznummer).VerbleibendeBauzeit),
                               Width => 1);
      New_Line;
      
   end AktuellesBauprojekt;

end StadtInformationen;
