pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleTexte, GlobaleKonstanten;

with SchreibeWichtiges;
with LeseForschungsDatenbank;

with Anzeige, Eingabe, StadtWerteFestlegen, StadtUmgebungsbereichFestlegen;

with KIForschung;

package body ForschungAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.ForschungIDMitNullWert)
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
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => Positive (IDExtern),
                                           LetzteZeileExtern      => Positive (IDExtern),
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
      end case;
      
   end Beschreibung;



   -- Hier noch mehr Optionen einbauen, z. B. Informationen über bereits erforschte Technologien
   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
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
               SchreibeWichtiges.Forschungsmenge (RasseExtern             => RasseExtern,
                                                  ForschungZugewinnExtern => 0,
                                                  RechnenSetzenExtern     => False);
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt := WasErforschtWerdenSoll;
               SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
               return;
         end case;
         
      end loop ForschungSchleife;
      
   end Forschung;



   function AuswahlForschungNeu
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin
      
      Anzeige.AllgemeineAnzeigeText := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Ende := 1;

      ForschungSchleife:
      for ForschungenSchleifenwert in GlobaleDatentypen.ForschungID loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Forschung_Kurz),
                                Positive (ForschungenSchleifenwert))) = "|"
         then
            exit ForschungSchleife;
            
         else
            null;
         end if;
         
         case
           ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                         ForschungIDExtern => ForschungenSchleifenwert)
         is
            when True =>
               Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Forschung_Kurz),
                                                                                           Positive (ForschungenSchleifenwert));
               Anzeige.AllgemeineAnzeigeText (Ende).Nummer := Positive (ForschungenSchleifenwert);
               Ende := Ende + 1;
                  
            when False =>
               null;
         end case;
                  
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
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in GlobaleDatentypen.ForschungID)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                    TextDateiExtern        => GlobaleTexte.Beschreibung_Forschung_Ermöglicht,
                                    ÜberschriftZeileExtern => 43,
                                    ErsteZeileExtern       => Positive (ForschungNummerExtern),
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Leer);
      
      TechnologienSchleife:
      for TechnologieSchleifenwert in GlobaleDatentypen.ForschungID'Range loop         
         ErmöglichtSchleife:
         for NeueForschungSchleifenwert in GlobaleDatentypen.AnforderungForschungArray'Range loop
         
            if
              LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                            IDExtern                => TechnologieSchleifenwert,
                                                            WelcheAnforderungExtern => NeueForschungSchleifenwert)
              = GlobaleKonstanten.LeerForschungAnforderung
            then
               exit ErmöglichtSchleife;
            
            elsif
              LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                            IDExtern                => TechnologieSchleifenwert,
                                                            WelcheAnforderungExtern => NeueForschungSchleifenwert)
              = ForschungNummerExtern
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => Positive (TechnologieSchleifenwert),
                                              LetzteZeileExtern      => Positive (TechnologieSchleifenwert),
                                              AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                                              AbstandEndeExtern      => GlobaleTexte.Leer);
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
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in GlobaleDatentypen.ForschungID)
   is begin
      
      ErsterDurchlauf := True;
          
      BenötigtSchleife:
      for NeueForschungSchleifenwert in GlobaleDatentypen.AnforderungForschungArray'Range loop
         
         if
           LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                         IDExtern                => ForschungNummerExtern,
                                                         WelcheAnforderungExtern => NeueForschungSchleifenwert)
           = GlobaleKonstanten.LeerForschungAnforderung
         then
            null;
               
         else
            case
              ErsterDurchlauf
            is
               when True =>
                  Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                                 TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                                 ÜberschriftZeileExtern => 44,
                                                 ErsteZeileExtern       => Positive (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                                   IDExtern                => ForschungNummerExtern,
                                                                                                                                   WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                                                 LetzteZeileExtern      => Positive (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                                   IDExtern                => ForschungNummerExtern,
                                                                                                                                   WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                                                 AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                 AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                                                 AbstandEndeExtern      => GlobaleTexte.Leer);
                  ErsterDurchlauf := False;
                  
               when False =>
                  Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                 TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                                 ÜberschriftZeileExtern => 0,
                                                 ErsteZeileExtern       => Positive (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                                   IDExtern                => ForschungNummerExtern,
                                                                                                                                   WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                                                 LetzteZeileExtern      => Positive (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                                   IDExtern                => ForschungNummerExtern,
                                                                                                                                   WelcheAnforderungExtern => NeueForschungSchleifenwert)),
                                                 AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                 AbstandMitteExtern     => GlobaleTexte.Großer_Abstand,
                                                 AbstandEndeExtern      => GlobaleTexte.Leer);
            end case;
         end if;
         
      end loop BenötigtSchleife;
      
      New_Line;
      
   end Benötigt;
   
   
   
   procedure ForschungsBaum
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleAuswahl := 1;
      
      ForschungsbaumSchleife:
      loop
         
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                        TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Kurz,
                                        ÜberschriftZeileExtern => 45,
                                        ErsteZeileExtern       => Positive (AktuelleAuswahl),
                                        LetzteZeileExtern      => Positive (AktuelleAuswahl),
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);         
         New_Line;
         
         Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                       TextDateiExtern        => GlobaleTexte.Beschreibungen_Forschung_Lang,
                                       ÜberschriftZeileExtern => 0,
                                       ErsteZeileExtern       => Positive (AktuelleAuswahl),
                                       AbstandAnfangExtern    => GlobaleTexte.Leer,
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
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
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
                 >= LeseForschungsDatenbank.PreisForschung (RasseExtern => RasseSchleifenwert,
                                                            IDExtern    => GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt)
               then
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Erforscht (GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt) := True;
                  if
                    GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseSchleifenwert, GlobaleDatentypen.Anfangswert)
                    or
                      GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseSchleifenwert, GlobaleDatentypen.Endwert)
                  then
                     StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseSchleifenwert);

                  else
                     null;
                  end if;
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt := AuswahlForschungNeu (RasseExtern => RasseSchleifenwert);
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsmenge := 0;
                  SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseSchleifenwert);
            
               else
                  SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseSchleifenwert);
               end if;
               
            when GlobaleDatentypen.Spieler_KI =>
               if
                 GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt = 0
               then
                  KIForschung.Forschung (RasseExtern => RasseSchleifenwert);
         
               elsif
                 GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsmenge
                 >= LeseForschungsDatenbank.PreisForschung (RasseExtern => RasseSchleifenwert,
                                                            IDExtern    => GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt)
               then
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Erforscht (GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt) := True;
                  if
                    GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseSchleifenwert, GlobaleDatentypen.Anfangswert)
                    or
                      GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseSchleifenwert, GlobaleDatentypen.Endwert)
                  then
                     StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseSchleifenwert);

                  else
                     null;
                  end if;
                  GlobaleVariablen.Wichtiges (RasseSchleifenwert).Forschungsprojekt := 0;
                  KIForschung.Forschung (RasseExtern => RasseSchleifenwert);
                  StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseSchleifenwert);
            
               else
                  null;
               end if;
         end case;
               
      end loop RasseSchleife;
      
   end ForschungFortschritt;
   
   
   
   function ForschungAnforderungErfüllt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in GlobaleDatentypen.ForschungID)
      return Boolean
   is begin
   
      case
        GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (ForschungIDExtern)
      is
         when True =>
            return False;
         
         when False =>
            null;
      end case;
      
      AnforderungSchleife:
      for AnforderungSchleifenwert in AnforderungForschungArray'Range loop
            
         if
           LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                         IDExtern                => ForschungIDExtern,
                                                         WelcheAnforderungExtern => AnforderungSchleifenwert)
           = GlobaleKonstanten.LeerForschungAnforderung
         then
            null;
                  
         elsif
           GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                             IDExtern                => ForschungIDExtern,
                                                                                                             WelcheAnforderungExtern => AnforderungSchleifenwert))
           = True
         then                  
            null;
                  
         else
            return False;
         end if;
               
      end loop AnforderungSchleife;
      
      return True;
      
   end ForschungAnforderungErfüllt;

end ForschungAllgemein;
