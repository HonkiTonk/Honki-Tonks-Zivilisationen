pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Integer_Wide_Wide_Text_IO;

with EinheitenDatentypen; use EinheitenDatentypen;
with GlobaleTexte;
with StadtKonstanten;
with KartenDatentypen;

with LeseGebaeudeDatenbank;
with LeseStadtGebaut;

with Anzeige;
with GebaeudeAllgemein;

package body GebaeudeBauenTerminal is

   procedure AnzeigeGebäude
     (StadtRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Put_Line (Item => GebaeudebeschreibungenSFML.BeschreibungLang (IDExtern => StadtDatentypen.GebäudeIDMitNullwert (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer - StadtKonstanten.GebäudeAufschlag)));
      New_Line;
      PreisGebäude (RasseExtern => StadtRasseNummerExtern.Rasse);
      BauzeitGebäude (StadtRasseNummerExtern => StadtRasseNummerExtern);
      New_Line;
      PermanenteGebäudeWerte := False;
      
      PermanenteBonisSchleife:
      for PermanenterBonusSchleifenwert in KartenDatentypen.Bonus_Werte_Enum'Range loop

         if
           LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => StadtDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                     - StadtKonstanten.GebäudeAufschlag),
                                                   WelcherBonusExtern => PermanenterBonusSchleifenwert)
           > 0
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinste Pluswert Eins ist.
                                          ErsteZeileExtern       => 62 + KartenDatentypen.Bonus_Werte_Enum'Pos (PermanenterBonusSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Natural (LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                               IDExtern           => StadtDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                                 - StadtKonstanten.GebäudeAufschlag),
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 48,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Positive (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => RasseExtern,
                                                                                         IDExtern    => StadtDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                           - StadtKonstanten.GebäudeAufschlag))),
                               Width => 1);
      
   end PreisGebäude;
   
   
   
   procedure BauzeitGebäude
     (StadtRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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
         Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Positive (ProduktionDatentypen.Produktion'Last),
                                  Width => 1);
         
      else
         Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Natural (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                           IDExtern    => StadtDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                             - StadtKonstanten.GebäudeAufschlag))
                                  / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                  Width => 1);
      end if;
      
   end BauzeitGebäude;
      
   
   
   procedure PermanenteKostenGebäude
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      PermanenteGebäudeWerte := False;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in StadtRecords.PermanenteKostenArray'Range loop
         
         if
           LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                   IDExtern           => StadtDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                     - StadtKonstanten.GebäudeAufschlag),
                                                   WelcheKostenExtern => PermanenteKostenSchleifenwert)
           > 0
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinste Pluswert Eins ist.
                                          ErsteZeileExtern       => 53 + ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum'Pos (PermanenteKostenSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Positive (LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                IDExtern           => StadtDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                                  - StadtKonstanten.GebäudeAufschlag),
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

end GebaeudeBauenTerminal;
