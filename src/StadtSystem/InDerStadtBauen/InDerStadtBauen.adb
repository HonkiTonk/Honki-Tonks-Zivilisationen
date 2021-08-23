pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten, GlobaleTexte;

with GebaeudeDatenbank;
     
with Anzeige, Eingabe, Auswahl, KartePositionPruefen, BewegungPassierbarkeitPruefen, GebaeudeRichtigeUmgebung, SchreibeStadtGebaut, LeseEinheitenDatenbank, LeseStadtGebaut, LeseGebaeudeDatenbank;

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



   procedure BauzeitEinzeln
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) = GlobaleKonstanten.LeerStadt.Produktionrate
      then
         SchreibeStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauzeitExtern          => GlobaleKonstanten.MaximaleBauzeit,
                                      ÄndernSetzenExtern    => False);

      elsif
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) = GlobaleKonstanten.LeerBauprojekt
      then
         SchreibeStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauzeitExtern          => GlobaleKonstanten.LeerStadt.Bauzeit,
                                      ÄndernSetzenExtern    => False);
            
      elsif
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) in GlobaleKonstanten.BauprojekteGebäudeAnfang .. GlobaleKonstanten.BauprojekteGebäudeEnde
      then
         SchreibeStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauzeitExtern          =>
                                        (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                IDExtern    => GlobaleDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
                                                                                  - GlobaleKonstanten.GebäudeAufschlag))
                                         - LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern))
                                      / GlobaleDatentypen.KostenLager (LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                      ÄndernSetzenExtern    => False);
         
         
      elsif
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) in GlobaleKonstanten.BauprojekteEinheitenAnfang .. GlobaleKonstanten.BauprojekteEinheitenEnde
      then
         SchreibeStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauzeitExtern          => 
                                        (LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                 IDExtern    => GlobaleDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
                                                                                   - GlobaleKonstanten.EinheitAufschlag))
                                         - LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern))
                                      / GlobaleDatentypen.KostenLager (LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                      ÄndernSetzenExtern     => False);
         
      else
         null;
      end if;
      
   end BauzeitEinzeln;



   procedure BauzeitAlle
   is begin
         
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop

                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert))
                  is
                     when GlobaleDatentypen.Leer =>
                        null;
                        
                     when others =>
                        BauzeitEinzeln (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert));
                  end case;
      
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end BauzeitAlle;



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin

      Ende := 1;
      Anzeige.AllgemeineAnzeigeText := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));

      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleDatentypen.GebäudeID'Range loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz),
                                Positive (GebäudeSchleifenwert))) = "|"
         then
            exit GebäudeSchleife;
            
         else
            null;
         end if;
         
         PassendeUmgebungVorhanden := GebaeudeRichtigeUmgebung.BenötigteUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                            GebäudeIDExtern       => GebäudeSchleifenwert);
         
         if
           LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              WelchesGebäudeExtern  => GebäudeSchleifenwert) = True
         then
            null;

         elsif
           GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen /= 0
           and
             PassendeUmgebungVorhanden
         then
            if
              GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen) = False
            then 
               null;

            else
               Anzeige.AllgemeineAnzeigeText (Ende).Text
                 := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert));
               Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.GebäudeAufschlag + Positive (GebäudeSchleifenwert);
               Ende := Ende + 1;
            end if;
            
         elsif
           PassendeUmgebungVorhanden
         then
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.GebäudeAufschlag + Positive (GebäudeSchleifenwert);
            Ende := Ende + 1;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;

      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleDatentypen.EinheitenID'Range loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                Positive (EinheitSchleifenwert))) = "|"
         then
            exit EinheitenSchleife;
            
         else
            null;
         end if;
         
         UmgebungPassierbar := False;
         
         -- Bei Gebäuden über den gesammten Bereich loopen, bei Einheiten nur um das direkte Umfeld.
         YAchseEinheitenSchleife:
         for YAchseEinheitenSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseEinheitenSchleife:
            for XAchseEinheitenSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                           ÄnderungExtern    => (0, YAchseEinheitenSchleifenwert, XAchseEinheitenSchleifenwert));
               
               if
                 KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  null;
                  
               elsif
                 YAchseEinheitenSchleifenwert = 0
                 and
                   XAchseEinheitenSchleifenwert = 0
               then
                  null;
                  
               elsif
                 BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                        IDExtern           => EinheitSchleifenwert,
                                                                        NeuePositionExtern => KartenWert) = True
               then
                  UmgebungPassierbar := True;
                  exit YAchseEinheitenSchleife;
                  
               else
                  null;
               end if;
               
            end loop XAchseEinheitenSchleife;
         end loop YAchseEinheitenSchleife;
         
         if
           LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                 IDExtern    => EinheitSchleifenwert) /= 0
           and
             UmgebungPassierbar
         then
            if
              GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                         IDExtern    => EinheitSchleifenwert)) = False
            then
               null;
               
            else
               Anzeige.AllgemeineAnzeigeText (Ende).Text
                 := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                                   Positive (EinheitSchleifenwert));
               Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
               Ende := Ende + 1;
            end if;
            
         elsif
           UmgebungPassierbar
         then
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz), Positive (EinheitSchleifenwert));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
            Ende := Ende + 1;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;

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
      
   end BauobjektAuswählen;
   
   
   
   procedure AnzeigeEinheiten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Lang,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer - GlobaleKonstanten.EinheitAufschlag,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Leer);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 48,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                          IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                            - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
                               
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 24,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                 IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                   - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 25,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                      IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                        - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 14,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                               IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                                 - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 15,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                  IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                                    - GlobaleKonstanten.EinheitAufschlag))),
                               Width => 1);

      New_Line;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in GlobaleDatentypen.PermanenteKostenArray'Range loop
         
         if
           LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                    IDExtern           => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                      - GlobaleKonstanten.EinheitAufschlag),
                                                    WelcheKostenExtern => PermanenteKostenSchleifenwert) > GlobaleKonstanten.NullPermanenteKosten
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinse Pluswert eins ist.
                                          ErsteZeileExtern       => 53 + GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Pos (PermanenteKostenSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Leer);
            Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                 IDExtern           => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                                                                                   - GlobaleKonstanten.EinheitAufschlag),
                                                                                                 WelcheKostenExtern => PermanenteKostenSchleifenwert)),
                                     Width => 1);
            New_Line;
         
         else
            null;
         end if;
         
      end loop PermanenteKostenSchleife;
      
   end AnzeigeEinheiten;
   
   
   
   procedure AnzeigeGebäude
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Beschreibungen_Gebäude_Lang,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer - GlobaleKonstanten.GebäudeAufschlag,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Leer);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 48,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                               - GlobaleKonstanten.GebäudeAufschlag)).PreisRessourcen),
                               Width => 1);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 49,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                               - GlobaleKonstanten.GebäudeAufschlag)).NahrungBonus),
                               Width => 1);
      Put (Item => "    ");
      Ada.Integer_Text_IO.Put (Item  => Natural (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                               - GlobaleKonstanten.GebäudeAufschlag)).ProduktionBonus),
                               Width => 1);

      New_Line;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in GlobaleDatentypen.PermanenteKostenArray'Range loop
         
         if
           GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                            - GlobaleKonstanten.GebäudeAufschlag)).PermanenteKosten (PermanenteKostenSchleifenwert) > 0
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinste Pluswert eins ist.
                                          ErsteZeileExtern       => 53 + GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Pos (PermanenteKostenSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Leer);
            Ada.Integer_Text_IO.Put (Item  => Positive (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                     - GlobaleKonstanten.GebäudeAufschlag)).PermanenteKosten (PermanenteKostenSchleifenwert)),
                                     Width => 1);
            New_Line;
         
         else
            null;
         end if;
         
      end loop PermanenteKostenSchleife;
      
   end AnzeigeGebäude;

end InDerStadtBauen;
