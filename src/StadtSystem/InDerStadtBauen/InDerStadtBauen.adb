pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten, GlobaleTexte;

with SchreibeStadtGebaut;
with LeseEinheitenDatenbank, LeseStadtGebaut, LeseGebaeudeDatenbank;
     
with Anzeige, Eingabe, Auswahl, GebaeudeAllgemein, EinheitenModifizieren, EinheitenBeschreibungen;

package body InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when GlobaleKonstanten.LeerBauprojekt =>
            null;
            
         when others =>
            if
              Auswahl.AuswahlJaNein (FrageZeileExtern => 14) = GlobaleKonstanten.JaKonstante
            then
               null;
               
            else
               return;
            end if;
      end case;
      
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => GlobaleKonstanten.LeerStadt.Ressourcen,
                                      ÄndernSetzenExtern    => False);
      SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauprojektExtern       => BauobjektAuswählen (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
   end Bauen;



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin

      Ende := 1;
      Anzeige.AllgemeineAnzeigeText := (others => (To_Unbounded_Wide_Wide_String (Source => GlobaleKonstanten.LeerText), 0));

      MöglicheGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      MöglicheEinheitenErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende > 1
      then
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Feste_Abfragen), 3);

      elsif
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende = 1
      then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Feste_Abfragen), 3);
      end if;

      return AuswahlBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end BauobjektAuswählen;
   
   
   
   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleDatentypen.GebäudeID'Range loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz),
                                Positive (GebäudeSchleifenwert)))
           = GlobaleKonstanten.LeerText
         then
            exit GebäudeSchleife;
            
         else
            null;
         end if;
         
         if
           GebaeudeAllgemein.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            IDExtern               => GebäudeSchleifenwert)
           = True
         then
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.GebäudeAufschlag + Positive (GebäudeSchleifenwert);
            Ende := Ende + 1;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleDatentypen.EinheitenID'Range loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                Positive (EinheitSchleifenwert)))
           = GlobaleKonstanten.LeerText
         then
            exit EinheitenSchleife;
            
         else
            null;
         end if;
         
         if
           EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => EinheitSchleifenwert)
           = True
         then
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                                Positive (EinheitSchleifenwert));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
            Ende := Ende + 1;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end MöglicheEinheitenErmitteln;
   
   
   
   function AuswahlBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      AktuelleAuswahl := 1;

      AuswahlSchleife:
      loop

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
                                               TextZeileExtern => 13);

         Anzeige.AllgemeineAnzeige (AktuelleAuswahlExtern => AktuelleAuswahl);
         
         if
           AktuelleAuswahl = Ende
         then
            null;
                  
         elsif
           Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer > GlobaleKonstanten.EinheitAufschlag
         then
            AnzeigeEinheiten (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         else
            AnzeigeGebäude (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end if;
         
         case
           Eingabe.Tastenwert
         is
            when GlobaleDatentypen.Hoch =>
               if
                 AktuelleAuswahl = Anzeige.AllgemeineAnzeigeText'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when GlobaleDatentypen.Runter =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anzeige.AllgemeineAnzeigeText'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when GlobaleDatentypen.Auswählen =>
               return Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer;

            when GlobaleDatentypen.Menü_Zurück =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end AuswahlBauprojekt;
   
   
   
   procedure AnzeigeEinheiten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenBeschreibungen.BeschreibungLang (IDExtern => GlobaleDatentypen.EinheitenIDMitNullWert (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer - GlobaleKonstanten.EinheitAufschlag));
      
      New_Line;
      Preis (RasseExtern => StadtRasseNummerExtern.Rasse);
      New_Line;
      
      Angriff (RasseExtern => StadtRasseNummerExtern.Rasse);
      Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse);
      MaximaleLebenspunkte (RasseExtern => StadtRasseNummerExtern.Rasse);
      MaximaleBewegungspunkte (RasseExtern => StadtRasseNummerExtern.Rasse);
      New_Line;
      
      PermanenteKostenEinheiten (RasseExtern => StadtRasseNummerExtern.Rasse);
      
   end AnzeigeEinheiten;
   
   
   
   procedure Preis
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 48,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => RasseExtern,
                                                                                          IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                            - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end Preis;
   
   
   
   procedure Angriff
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 24,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Angriff (RasseExtern => RasseExtern,
                                                                                 IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                   - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end Angriff;
   
   
   
   procedure Verteidigung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 25,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Verteidigung (RasseExtern => RasseExtern,
                                                                                      IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                        - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end Verteidigung;
   
   
   
   procedure MaximaleLebenspunkte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 14,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => RasseExtern,
                                                                                               IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                                 - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end MaximaleLebenspunkte;
   
   
   
   procedure MaximaleBewegungspunkte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 15,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => RasseExtern,
                                                                                                  IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                                    - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end MaximaleBewegungspunkte;
   
   
   
   procedure PermanenteKostenEinheiten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      PermanenteGebäudeWerte := False;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in GlobaleRecords.PermanenteKostenArray'Range loop
         
         if
           LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                    IDExtern           => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                      - GlobaleKonstanten.EinheitAufschlag),
                                                    WelcheKostenExtern => PermanenteKostenSchleifenwert)
           > GlobaleKonstanten.NullPermanenteKosten
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinste Pluswert Eins ist.
                                          ErsteZeileExtern       => 53 + GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Pos (PermanenteKostenSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                 IDExtern           => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                                   - GlobaleKonstanten.EinheitAufschlag),
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
      
   end PermanenteKostenEinheiten;
   
   
   
   procedure AnzeigeGebäude
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GebaeudeAllgemein.BeschreibungLang (IDExtern => GlobaleDatentypen.GebäudeIDMitNullwert (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer - GlobaleKonstanten.GebäudeAufschlag));
      New_Line;
      PreisGebäude (RasseExtern => StadtRasseNummerExtern.Rasse);
      New_Line;
      PermanenteGebäudeWerte := False;
      
      PermanenteBonisSchleife:
      for PermanenterBonusSchleifenwert in GlobaleDatentypen.Bonus_Werte_Enum'Range loop

         if
           LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
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
                                                                                               IDExtern           => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
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
                                                                                         IDExtern    => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                           - GlobaleKonstanten.GebäudeAufschlag))),
                               Width => 1);
      
   end PreisGebäude;
   
   
   
   procedure PermanenteKostenGebäude
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      PermanenteGebäudeWerte := False;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in GlobaleRecords.PermanenteKostenArray'Range loop
         
         if
           LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                   IDExtern           => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                     - GlobaleKonstanten.GebäudeAufschlag),
                                                   WelcheKostenExtern => PermanenteKostenSchleifenwert)
           > 0
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinste Pluswert eins ist.
                                          ErsteZeileExtern       => 53 + GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Pos (PermanenteKostenSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Positive (LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                IDExtern           => GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
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

end InDerStadtBauen;
