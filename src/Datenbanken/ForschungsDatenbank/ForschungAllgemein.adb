pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleTexte;

with ForschungsDatenbank;

with Anzeige, Eingabe, KIForschung;

package body ForschungAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.ForschungIDMitNullWert;
      RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      case
        IDExtern
      is
         when 0 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 28,
                                           LetzteZeileExtern      => 28,
                                           AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                           AbstandMitteExtern     => GlobaleTexte.Keiner,
                                           AbstandEndeExtern      => GlobaleTexte.Keiner);
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => Positive (IDExtern) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                           LetzteZeileExtern      => Positive (IDExtern) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                           AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                           AbstandMitteExtern     => GlobaleTexte.Keiner,
                                           AbstandEndeExtern      => GlobaleTexte.Keiner);
      end case;
      
   end Beschreibung;



   -- Hier noch mehr Optionen einbauen, z. B. Informationen über bereits erforschte Technologien
   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      ForschungSchleife:
      loop
         
         WasErforschtWerdenSoll := AuswahlForschungNeu (RasseExtern => RasseExtern);

         case
           WasErforschtWerdenSoll
         is
            when 0 =>
               return;
               
            when GlobaleDatentypen.ForschungID'Range =>
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := 0;
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt := WasErforschtWerdenSoll;
               ForschungZeit (RasseExtern => RasseExtern);
               return;
         end case;
         
      end loop ForschungSchleife;
      
   end Forschung;



   procedure ForschungZeit
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      if
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt = 0
        or
          GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate = 0
      then
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := 10_000;

      else
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit
           := (ForschungsDatenbank.ForschungListe (RasseExtern, GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt).PreisForschung
               - GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge) / GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;
         return;
      end if;
      
   end ForschungZeit;



   function AuswahlForschungNeu
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin
      
      Anzeige.AllgemeineAnzeigeText := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Ende := 1;

      ForschungSchleife:
      for ForschungenSchleifenwert in GlobaleDatentypen.ForschungID loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Forschung_Kurz),
                                Positive (ForschungenSchleifenwert) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern))) = "|"
         then
            exit ForschungSchleife;

         elsif
           GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (ForschungenSchleifenwert) = True
         then
            null;

         else
            AnforderungenErfüllt := True;
            AnforderungSchleife:
            for Anforderung in AnforderungForschungArray'Range loop
            
               if
                 ForschungsDatenbank.ForschungListe (RasseExtern, ForschungenSchleifenwert).AnforderungForschung (Anforderung) = 0
               then
                  null;
                  
               elsif GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (ForschungsDatenbank.ForschungListe (RasseExtern, ForschungenSchleifenwert).AnforderungForschung (Anforderung)) = True then                  
                  null;
                  
               else
                  AnforderungenErfüllt := False;
                  exit AnforderungSchleife;
               end if;
               
            end loop AnforderungSchleife;

            case
              AnforderungenErfüllt
            is
               when True =>
                  Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Forschung_Kurz),
                                                                                              Positive (ForschungenSchleifenwert) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern));
                  Anzeige.AllgemeineAnzeigeText (Ende).Nummer := Positive (ForschungenSchleifenwert);
                  Ende := Ende + 1;
                  
               when False =>
                  null;
            end case;
         end if;
                  
      end loop ForschungSchleife;

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
                                               TextZeileExtern => 16);

         Anzeige.AllgemeineAnzeige (AktuelleAuswahlExtern => AktuelleAuswahl);
         
         if
           AktuelleAuswahl = Ende
         then
            null;
                  
         else
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Lang,
                                          ÜberschriftZeileExtern => 0,
                                          ErsteZeileExtern       => Positive (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer),
                                          LetzteZeileExtern      => Positive (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer),
                                          AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                          AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);

            Ermöglicht (RasseExtern           => RasseExtern,
                         ForschungNummerExtern => GlobaleDatentypen.ForschungID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer));
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
               return GlobaleDatentypen.ForschungIDMitNullWert (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer);

            when GlobaleDatentypen.Menü_Zurück =>
               return 0;
                     
            when others =>
               null;                    
         end case;
         
      end loop AuswahlSchleife;

   end AuswahlForschungNeu;
   
   
   
   procedure Ermöglicht
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ForschungNummerExtern : in GlobaleDatentypen.ForschungID)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                    TextDateiExtern        => GlobaleTexte.Beschreibung_Forschung_Ermöglicht,
                                    ÜberschriftZeileExtern => 43,
                                    ErsteZeileExtern       => Positive (ForschungNummerExtern) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                    LetzteZeileExtern      => Positive (ForschungNummerExtern) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      
      TechnologienSchleife:
      for TechnologieSchleifenwert in GlobaleDatentypen.ForschungID'Range loop         
         ErmöglichtSchleife:
         for NeueForschungSchleifenwert in GlobaleDatentypen.AnforderungForschungArray'Range loop
         
            if
              ForschungsDatenbank.ForschungListe (RasseExtern, TechnologieSchleifenwert).AnforderungForschung (NeueForschungSchleifenwert) = 0
            then
               exit ErmöglichtSchleife;
            
            elsif
              ForschungsDatenbank.ForschungListe (RasseExtern, TechnologieSchleifenwert).AnforderungForschung (NeueForschungSchleifenwert) = ForschungNummerExtern
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => Positive (TechnologieSchleifenwert) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                              LetzteZeileExtern      => Positive (TechnologieSchleifenwert) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                              AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                                              AbstandEndeExtern      => GlobaleTexte.Keiner);
               exit ErmöglichtSchleife;
               
            else              
               null;
            end if;
         
         end loop ErmöglichtSchleife;
      end loop TechnologienSchleife;
      
      New_Line;
      
   end Ermöglicht;
   
   
   
   -- Funktioniert noch nicht ganz richtig, weil durch die Schleife die Überschrift immer wieder ausgegeben wird!
   procedure Benötigt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ForschungNummerExtern : in GlobaleDatentypen.ForschungID)
   is begin
          
      BenötigtSchleife:
      for NeueForschungSchleifenwert in GlobaleDatentypen.AnforderungForschungArray'Range loop
         
         if
           ForschungsDatenbank.ForschungListe (RasseExtern, ForschungNummerExtern).AnforderungForschung (NeueForschungSchleifenwert) = 0
         then
            exit BenötigtSchleife;
               
         else              
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                           ÜberschriftZeileExtern => 44,
                                           ErsteZeileExtern       => Positive (ForschungsDatenbank.ForschungListe (RasseExtern, ForschungNummerExtern).AnforderungForschung (NeueForschungSchleifenwert))
                                           + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                           LetzteZeileExtern      => Positive (ForschungsDatenbank.ForschungListe (RasseExtern, ForschungNummerExtern).AnforderungForschung (NeueForschungSchleifenwert))
                                           + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                           AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                                           AbstandEndeExtern      => GlobaleTexte.Keiner);
         end if;
         
      end loop BenötigtSchleife;
      
      New_Line;
      
   end Benötigt;
   
   
   
   procedure ForschungsBaum
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      AktuelleAuswahl := 1;
      
      ForschungsbaumSchleife:
      loop
         
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                        TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                        ÜberschriftZeileExtern => 45,
                                        ErsteZeileExtern       => Positive (AktuelleAuswahl) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                        LetzteZeileExtern      => Positive (AktuelleAuswahl) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);         
         New_Line;
         
         Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                       TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Lang,
                                       ÜberschriftZeileExtern => 0,
                                       ErsteZeileExtern       => Positive (AktuelleAuswahl) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                       LetzteZeileExtern      => Positive (AktuelleAuswahl) + ForschungsDatenbank.RassenAufschlagForschung (RasseExtern),
                                       AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                       AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);         
         New_Line;
      
         Benötigt (RasseExtern           => RasseExtern,
                    ForschungNummerExtern => AktuelleAuswahl);
         New_Line;      
         Ermöglicht (RasseExtern           => RasseExtern,
                      ForschungNummerExtern => AktuelleAuswahl);
         
         case
           Eingabe.Tastenwert
         is
            when GlobaleDatentypen.Rechts => 
               if
                 AktuelleAuswahl = GlobaleDatentypen.ForschungID'Last
               then
                  AktuelleAuswahl := GlobaleDatentypen.ForschungID'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;

            when GlobaleDatentypen.Links =>
               if
                 AktuelleAuswahl = GlobaleDatentypen.ForschungID'First
               then
                  AktuelleAuswahl := GlobaleDatentypen.ForschungID'Last;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;               
                              
            when GlobaleDatentypen.Menü_Zurück =>    
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return;
                     
            when others =>
               null;                    
         end case;
         
      end loop ForschungsbaumSchleife;
      
   end ForschungsBaum;



   procedure ForschungFortschritt
   is begin
      
      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when GlobaleDatentypen.Spieler_Mensch =>
               if
                 GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt = 0
               then
                  null;
         
               elsif
                 GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsmenge
                 >= ForschungsDatenbank.ForschungListe (RasseSchleifenwert, GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt).PreisForschung
               then
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Erforscht (GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt) := True;
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt := AuswahlForschungNeu (RasseExtern => RasseSchleifenwert);
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsmenge := 0;
                  ForschungZeit (RasseExtern => RasseSchleifenwert);
            
               else
                  ForschungZeit (RasseExtern => RasseSchleifenwert);
               end if;
               
            when GlobaleDatentypen.Spieler_KI =>
               if
                 GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt = 0
               then
                  KIForschung.Forschung (RasseExtern => RasseSchleifenwert);
         
               elsif
                 GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsmenge
                 >= ForschungsDatenbank.ForschungListe (RasseSchleifenwert, GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt).PreisForschung
               then
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Erforscht (GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt) := True;
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt := 0;
                  KIForschung.Forschung (RasseExtern => RasseSchleifenwert);
            
               else
                  null;
               end if;
         end case;
               
      end loop RasseSchleife;
      
   end ForschungFortschritt;

end ForschungAllgemein;
