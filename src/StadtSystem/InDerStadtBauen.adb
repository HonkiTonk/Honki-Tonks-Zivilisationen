pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with GebaeudeDatenbank, EinheitenDatenbank, Anzeige, Eingabe;

package body InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
      
      BauSchleife:
      loop
      
         WasGebautWerdenSoll := BauobjektAuswählen (StadtRasseNummerExtern => StadtRasseNummerExtern);

         case
           WasGebautWerdenSoll
         is
            when 0 =>
               return;

            when 1_001 .. 99_999 => -- Gebäude - 1_000, Einheiten - 10_000
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := WasGebautWerdenSoll;
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
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
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate = 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit := 10_000;

      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt = 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit := 0;
            
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt < 10_000
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit
           := (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
               GlobaleDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - GlobaleKonstanten.GebäudeAufschlag)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate);
               
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit
           := (EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse,
               GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt - GlobaleKonstanten.EinheitAufschlag)).PreisRessourcen
               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen)
             / GlobaleDatentypen.KostenLager (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleProduktionrate);
      end if;
               
   end BauzeitEinzeln;



   procedure BauzeitAlle
   is begin
         
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop

            if
              GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = 0
            then
               exit StadtSchleife;
                     
            elsif
              GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummer).ID = 0
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
           To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (Beschreibungen_Gebäude_Kurz),
                                Positive (GebäudeSchleifenwert) + RassenAufschlagGebäude (StadtRasseNummerExtern.Rasse))) = "|"
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
                 := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert) + RassenAufschlagGebäude (StadtRasseNummerExtern.Rasse));
               Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.GebäudeAufschlag + Positive (GebäudeSchleifenwert);
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert) + RassenAufschlagGebäude (StadtRasseNummerExtern.Rasse));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.GebäudeAufschlag + Positive (GebäudeSchleifenwert);
            Ende := Ende + 1;
         end if;
         
      end loop GebäudeSchleife;

      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleDatentypen.EinheitenID loop
         
         if
           To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (Beschreibungen_Einheiten_Kurz),
                                Positive (EinheitSchleifenwert) + RassenAufschlagEinheiten (StadtRasseNummerExtern.Rasse))) = "|"
         then
            exit EinheitenSchleife;

         elsif
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AmWasser = False
           and
             EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Passierbarkeit (2) = True
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
                 := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (Beschreibungen_Einheiten_Kurz), Positive (EinheitSchleifenwert) + RassenAufschlagEinheiten (StadtRasseNummerExtern.Rasse));
               Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
               Ende := Ende + 1;
            end if;
            
         else
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (Beschreibungen_Einheiten_Kurz), Positive (EinheitSchleifenwert) + RassenAufschlagEinheiten (StadtRasseNummerExtern.Rasse));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := GlobaleKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
            Ende := Ende + 1;
         end if;
         
      end loop EinheitenSchleife;

      if
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende > 1
      then
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (Feste_Abfragen), 3);

      elsif
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende = 1
      then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (Feste_Abfragen), 3);
      end if;

      AktuelleAuswahl := 1;

      AuswahlSchleife:
      loop

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fragen,
                                               TextZeileExtern => 13);

         Anzeige.AllgemeineAnzeige (AktuelleAuswahlExtern => AktuelleAuswahl);
         
         if
           AktuelleAuswahl = Ende
         then
            null;
                  
         elsif
           Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer > GlobaleKonstanten.EinheitAufschlag
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                          TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Einheiten_Lang,
                                          ÜberschriftZeileExtern => 0,
                                          ErsteZeileExtern       => Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer - GlobaleKonstanten.EinheitAufschlag,
                                          LetzteZeileExtern      => Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer - GlobaleKonstanten.EinheitAufschlag,
                                          AbstandAnfangExtern    => GlobaleDatentypen.Neue_Zeile,
                                          AbstandEndeExtern      => GlobaleDatentypen.Keiner);
            
         else
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                          TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Gebäude_Lang,
                                          ÜberschriftZeileExtern => 0,
                                          ErsteZeileExtern       => Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer - GlobaleKonstanten.GebäudeAufschlag,
                                          LetzteZeileExtern      => Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer - GlobaleKonstanten.GebäudeAufschlag,
                                          AbstandAnfangExtern    => GlobaleDatentypen.Neue_Zeile,
                                          AbstandEndeExtern      => GlobaleDatentypen.Keiner);
         end if;
         
         Taste := Eingabe.TastenEingabe;
         
         case
           Taste
         is               
            when 'w' | '8' => 
               if
                 AktuelleAuswahl = Anzeige.AllgemeineAnzeigeText'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anzeige.AllgemeineAnzeigeText'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>
               return Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer;

            when 'q' =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end BauobjektAuswählen;

end InDerStadtBauen;
