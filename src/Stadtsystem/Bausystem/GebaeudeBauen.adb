pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleKonstanten, GlobaleTexte;

with LeseGebaeudeDatenbank, LeseStadtGebaut;

with Anzeige, GebaeudeAllgemein;

package body GebaeudeBauen is

   procedure AnzeigeGebäude
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GebaeudeAllgemein.BeschreibungLang (IDExtern => GlobaleDatentypen.GebäudeIDMitNullwert (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer - GlobaleKonstanten.GebäudeAufschlag));
      New_Line;
      PreisGebäude (RasseExtern => StadtRasseNummerExtern.Rasse);
      BauzeitGebäude (StadtRasseNummerExtern => StadtRasseNummerExtern);
      New_Line;
      PermanenteGebäudeWerte := False;
      
      PermanenteBonisSchleife:
      for PermanenterBonusSchleifenwert in GlobaleDatentypen.Bonus_Werte_Enum'Range loop

         if
           LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                     - GlobaleKonstanten.GebäudeAufschlag),
                                                   WelcherBonusExtern => PermanenterBonusSchleifenwert)
           > 0
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinste Pluswert Eins ist.
                                          ErsteZeileExtern       => 62 + GlobaleDatentypen.Bonus_Werte_Enum'Pos (PermanenterBonusSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Natural (LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                               IDExtern           => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                                 - GlobaleKonstanten.GebäudeAufschlag),
                                                                                               WelcherBonusExtern => PermanenterBonusSchleifenwert)),
                                     Width => 1);
            
            case
              PermanenteGebäudeWerte
            is
               when False =>
                  null;
                  
               when True =>
                  New_Line;
            end case;
            PermanenteGebäudeWerte := not PermanenteGebäudeWerte;
         
         else
            null;
         end if;
         
      end loop PermanenteBonisSchleife;

      New_Line;
      PermanenteKostenGebäude (RasseExtern => StadtRasseNummerExtern.Rasse);
      
   end AnzeigeGebäude;
   
   
   
   procedure PreisGebäude
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 48,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => RasseExtern,
                                                                                         IDExtern    => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                           - GlobaleKonstanten.GebäudeAufschlag))),
                               Width => 1);
      
   end PreisGebäude;
   
   
   
   procedure BauzeitGebäude
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 13,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
      then
         Ada.Integer_Text_IO.Put (Item  => Positive (GlobaleDatentypen.KostenLager'Last),
                                  Width => 1);
         
      else
         Ada.Integer_Text_IO.Put (Item  => Natural (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                           IDExtern    => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                             - GlobaleKonstanten.GebäudeAufschlag))
                                  / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                  Width => 1);
      end if;
      
   end BauzeitGebäude;
      
   
   
   procedure PermanenteKostenGebäude
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      PermanenteGebäudeWerte := False;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in EinheitStadtRecords.PermanenteKostenArray'Range loop
         
         if
           LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                   IDExtern           => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                     - GlobaleKonstanten.GebäudeAufschlag),
                                                   WelcheKostenExtern => PermanenteKostenSchleifenwert)
           > 0
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinste Pluswert Eins ist.
                                          ErsteZeileExtern       => 53 + GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Pos (PermanenteKostenSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Positive (LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                IDExtern           => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                                  - GlobaleKonstanten.GebäudeAufschlag),
                                                                                                WelcheKostenExtern => PermanenteKostenSchleifenwert)),
                                     Width => 1);
            case
              PermanenteGebäudeWerte
            is
               when False =>
                  null;
                  
               when True =>
                  New_Line;
            end case;
            PermanenteGebäudeWerte := not PermanenteGebäudeWerte;
         
         else
            null;
         end if;
         
      end loop PermanenteKostenSchleife;
      
   end PermanenteKostenGebäude;

end GebaeudeBauen;
