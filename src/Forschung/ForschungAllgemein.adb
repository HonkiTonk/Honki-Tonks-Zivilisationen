pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with SystemKonstanten;
with ForschungKonstanten;

with SchreibeWichtiges;
with LeseForschungsDatenbank;
with LeseWichtiges;

with Anzeige;
with Eingabe;
with StadtWerteFestlegen;
with StadtUmgebungsbereichFestlegen;

with KIForschung;

package body ForschungAllgemein is

   procedure Beschreibung
     (IDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert)
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
         
      WasErforschtWerdenSoll := AuswahlForschungNeu (RasseExtern => RasseExtern);

      case
        WasErforschtWerdenSoll
      is
         when EinheitStadtDatentypen.ForschungIDMitNullWert'First =>
            null;
               
         when others =>
            SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                                 ForschungIDExtern => WasErforschtWerdenSoll);
      end case;
      
   end Forschung;



   function AuswahlForschungNeu
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin
      
      Anzeige.AllgemeineAnzeigeText := (others => (SystemKonstanten.LeerUnboundedString, 0));
      Ende := 1;

      ForschungSchleife:
      for ForschungenSchleifenwert in EinheitStadtDatentypen.ForschungID loop
         
         if
           GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Forschung_Kurz), Positive (ForschungenSchleifenwert)) = SystemKonstanten.LeerUnboundedString
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
               Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Forschung_Kurz),
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
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Feste_Abfragen), 3);

      elsif
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende = 1
      then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Feste_Abfragen), 3);
      end if;

      AktuelleAuswahl := 1;

      return ForschungAuswahl (RasseExtern => RasseExtern);

   end AuswahlForschungNeu;
   
   
   
   function ForschungAuswahl
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin
      
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
                         ForschungNummerExtern => EinheitStadtDatentypen.ForschungID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer));
         end if;
         
         case
           Eingabe.Tastenwert
         is
            when SystemDatentypen.Oben =>
               if
                 AktuelleAuswahl = Anzeige.AllgemeineAnzeigeText'First
               then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Unten =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anzeige.AllgemeineAnzeigeText'First;
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
               
            when SystemDatentypen.Auswählen =>
               return EinheitStadtDatentypen.ForschungIDMitNullWert (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer);

            when SystemDatentypen.Menü_Zurück =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end ForschungAuswahl;
   
   
   
   procedure Ermöglicht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                    TextDateiExtern        => GlobaleTexte.Beschreibung_Forschung_Ermöglicht,
                                    ÜberschriftZeileExtern => 43,
                                    ErsteZeileExtern       => Positive (ForschungNummerExtern),
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Leer);
      
      TechnologienSchleife:
      for TechnologieSchleifenwert in EinheitStadtDatentypen.ForschungID'Range loop
         ErmöglichtSchleife:
         for NeueForschungSchleifenwert in EinheitStadtDatentypen.AnforderungForschungArray'Range loop
         
            if
              LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                            IDExtern                => TechnologieSchleifenwert,
                                                            WelcheAnforderungExtern => NeueForschungSchleifenwert)
              = ForschungKonstanten.LeerForschungAnforderung
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
   
   
   
   procedure Benötigt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
   is begin
      
      ErsterDurchlauf := True;
          
      BenötigtSchleife:
      for NeueForschungSchleifenwert in EinheitStadtDatentypen.AnforderungForschungArray'Range loop
         
         if
           LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                         IDExtern                => ForschungNummerExtern,
                                                         WelcheAnforderungExtern => NeueForschungSchleifenwert)
           = ForschungKonstanten.LeerForschungAnforderung
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
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
            when SystemDatentypen.Rechts =>
               if
                 AktuelleAuswahl = EinheitStadtDatentypen.ForschungID'Last
               then
                  AktuelleAuswahl := EinheitStadtDatentypen.ForschungID'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;

            when SystemDatentypen.Links =>
               if
                 AktuelleAuswahl = EinheitStadtDatentypen.ForschungID'First
               then
                  AktuelleAuswahl := EinheitStadtDatentypen.ForschungID'Last;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;
                              
            when SystemDatentypen.Menü_Zurück =>
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
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when SonstigeDatentypen.Spieler_Mensch =>
               FortschrittMensch (RasseExtern => RasseSchleifenwert);
               
            when SonstigeDatentypen.Spieler_KI =>
               FortschrittKI (RasseExtern => RasseSchleifenwert);
         end case;
               
      end loop RasseSchleife;
      
   end ForschungFortschritt;
   
   
   
   procedure FortschrittMensch
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      if
        AktuellesForschungsprojekt = EinheitStadtDatentypen.ForschungIDMitNullWert'First
      then
         null;
         
      elsif
        LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern)
        >= LeseForschungsDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                   IDExtern    => AktuellesForschungsprojekt)
      then
         SchreibeWichtiges.Erforscht (RasseExtern => RasseExtern);
         if
           AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Anfangswert)
           or
             AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Endwert)
         then
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseExtern);

         else
            null;
         end if;
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => AuswahlForschungNeu (RasseExtern => RasseExtern));
            
      else
         SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      end if;
      
   end FortschrittMensch;
   
   
   
   procedure FortschrittKI
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      if
        AktuellesForschungsprojekt = EinheitStadtDatentypen.ForschungIDMitNullWert'First
      then
         KIForschung.Forschung (RasseExtern => RasseExtern);
         
      elsif
        LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern)
        >= LeseForschungsDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                   IDExtern    => AktuellesForschungsprojekt)
      then
         SchreibeWichtiges.Erforscht (RasseExtern => RasseExtern);
         if
           AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Anfangswert)
           or
             AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Endwert)
         then
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseExtern);

         else
            null;
         end if;
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => 0);
         KIForschung.Forschung (RasseExtern => RasseExtern);
         StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseExtern);
            
      else
         null;
      end if;
      
   end FortschrittKI;
   
   
   
   function ForschungAnforderungErfüllt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungID)
      return Boolean
   is begin
   
      case
        LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                 WelcheTechnologieExtern => ForschungIDExtern)
      is
         when True =>
            return False;
         
         when False =>
            null;
      end case;
      
      AnforderungSchleife:
      for AnforderungSchleifenwert in EinheitStadtDatentypen.AnforderungForschungArray'Range loop
            
         if
           LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                         IDExtern                => ForschungIDExtern,
                                                         WelcheAnforderungExtern => AnforderungSchleifenwert)
           = ForschungKonstanten.LeerForschungAnforderung
         then
            null;
                  
         elsif
           LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                    WelcheTechnologieExtern => LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
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
