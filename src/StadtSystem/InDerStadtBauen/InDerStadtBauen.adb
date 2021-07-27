pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten, GlobaleTexte;

with GebaeudeDatenbank, EinheitenDatenbank, DatenbankRecords;
     
with Anzeige, Eingabe;

package body InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := 0;
      
      BauSchleife:
      loop
      
         WasGebautWerdenSoll := BauobjektAuswählen (StadtRasseNummerExtern => StadtRasseNummerExtern);

         case
           WasGebautWerdenSoll
         is
            when 0 =>
               return;

               -- Gebäude - 1_000, Einheiten - 10_000
            when 1_001 .. 99_999 =>
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := WasGebautWerdenSoll;
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := 0;
               BauzeitEinzeln (StadtRasseNummerExtern => StadtRasseNummerExtern);
               return;
               
            when others =>
               null;
         end case;
         
      end loop BauSchleife;
      
   end Bauen;



   procedure BauzeitEinzeln
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate = 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit := 10_000;

      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt = 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit := 0;
            
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt < 10_000
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit
           := (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - GlobaleKonstanten.GebäudeAufschlag)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate);
               
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit
           := (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse,
               GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - GlobaleKonstanten.EinheitAufschlag)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate);
      end if;
               
   end BauzeitEinzeln;



   procedure BauzeitAlle
   is begin
         
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop

            if
              GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
            then
               exit StadtSchleife;
                     
            elsif
              GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummer).ID = GlobaleDatentypen.Leer
            then
               null;
                        
            else
               BauzeitEinzeln (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummer));
            end if;
      
         end loop StadtSchleife;
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

         elsif
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GebäudeSchleifenwert) = True
         then
            null;

         elsif
           GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen /= 0
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
            
         else
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.GebäudeAufschlag + Positive (GebäudeSchleifenwert);
            Ende := Ende + 1;
         end if;
         
      end loop GebäudeSchleife;

      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleDatentypen.EinheitenID'Range loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                Positive (EinheitSchleifenwert))) = "|"
         then
            exit EinheitenSchleife;

         elsif
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AmWasser = False
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (GlobaleDatentypen.Wasser) = True
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (GlobaleDatentypen.Boden) = False
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (GlobaleDatentypen.Luft) = False
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (GlobaleDatentypen.Weltraum) = False
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (GlobaleDatentypen.Unteridrisch) = False
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (GlobaleDatentypen.Lava) = False
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (GlobaleDatentypen.Planeteninneres) = False
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (GlobaleDatentypen.Unterwasser) = False
         then
            null;

         elsif
           EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Anforderungen /= 0
         then
            if
              GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Anforderungen) = False
            then
               null;
               
            else
               Anzeige.AllgemeineAnzeigeText (Ende).Text
                 := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                                   Positive (EinheitSchleifenwert));
               Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz), Positive (EinheitSchleifenwert));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
            Ende := Ende + 1;
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
      Ada.Integer_Text_IO.Put (Item  => Positive (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                               - GlobaleKonstanten.EinheitAufschlag)).PreisRessourcen),
                               Width => 1);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 24,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                               - GlobaleKonstanten.EinheitAufschlag)).Angriff),
                               Width => 1);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 25,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                               - GlobaleKonstanten.EinheitAufschlag)).Verteidigung),
                               Width => 1);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 14,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                               - GlobaleKonstanten.EinheitAufschlag)).MaximaleLebenspunkte),
                               Width => 1);
            
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 15,
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                               - GlobaleKonstanten.EinheitAufschlag)).MaximaleBewegungspunkte),
                               Width => 1);
      
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
      for PermanenteKostenSchleifenwert in DatenbankRecords.PermanenteKostenArray'Range loop
         
         if
           GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                            - GlobaleKonstanten.GebäudeAufschlag)).PermanenteKosten (PermanenteKostenSchleifenwert) > 0
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          ErsteZeileExtern       => 50,
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Positive (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer
                                     - GlobaleKonstanten.GebäudeAufschlag)).PermanenteKosten (PermanenteKostenSchleifenwert)),
                                     Width => 1);
         
         else
            null;
         end if;
         
      end loop PermanenteKostenSchleife;
      
   end AnzeigeGebäude;

end InDerStadtBauen;
