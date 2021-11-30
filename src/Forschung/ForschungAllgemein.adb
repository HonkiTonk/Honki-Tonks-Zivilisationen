pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with Sf; use Sf;

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
with InteraktionTasks;
with GrafikEinstellungen;
with GrafikTextAllgemein;

with KIForschung;

package body ForschungAllgemein is

   -- In Funktion umschreiben die den String zurückgibt? Würde die Sache in der SFML (generell?) leichter machen?
   -- RasseExtern einbauen um die Technologien aller Rassen einbauen zu können.
   -- Auch bei allein anderen Beschreibungen dann so einbauen.
   procedure Beschreibung
     (IDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      if
        GlobaleVariablen.AnzeigeArt = SystemDatentypen.Konsole
      then
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
         
      else
         case
           IDExtern
         is
            when 0 =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccessExtern,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (28)));
               
            when others =>
               AktuelleForschung := 2 * Positive (IDExtern) - 1;
               
               Sf.Graphics.Text.setUnicodeString (text => TextAccessExtern,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (AktuelleForschung)));
         end case;
      end if;
      
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
      
      ForschungText := (others => (SystemKonstanten.LeerUnboundedString, 0));
      Ende := 1;

      ForschungSchleife:
      for ForschungenSchleifenwert in EinheitStadtDatentypen.ForschungID loop
         
         WelcherForschungstext := 2 * Positive (ForschungenSchleifenwert) - 1;
         
         case
           ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                         ForschungIDExtern => ForschungenSchleifenwert)
         is
            when True =>
               -- Später durch eine bessere Leerwertprüfung ersetzen.
               if
                 ForschungenSchleifenwert > 74
               then
                  null;
                  
               else
                  ForschungText (Ende).Text := GlobaleTexte.Forschungen (WelcherForschungstext);
                  ForschungText (Ende).Nummer := Positive (ForschungenSchleifenwert);
                  -- Put_Line (WelcherForschungstext'Wide_Wide_Image);
                  -- Put_Line (To_Wide_Wide_String (Source => ForschungText (Ende).Text));
                  Ende := Ende + 1;
               end if;
                  
            when False =>
               null;
         end case;
                  
      end loop ForschungSchleife;

      ForschungText (Ende).Text := GlobaleTexte.Forschungen (GlobaleTexte.Forschungen'Last - 1);
      AktuelleAuswahl := 1;
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return ForschungAuswahl (RasseExtern => RasseExtern);
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            return ForschungAuswahlSFML;
      end case;

   end AuswahlForschungNeu;
   
   
   
   function ForschungAuswahlSFML
     return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin
      
      GrafikTextAllgemein.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                                FontExtern         => GrafikEinstellungen.Schriftart,
                                                SchriftgrößeExtern => GrafikEinstellungen.FensterEinstellungen.Schriftgröße,
                                                FarbeExtern        => GrafikEinstellungen.Schriftfarben.FarbeStandardText);
      Zeilenabstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      
      InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Forschung;
      
      AuswahlSchleife:
      loop
         
         MausAuswahl;
         
         case
           Eingabe.Tastenwert
         is               
            when SystemDatentypen.Auswählen =>
               if
                 AktuelleAuswahl <= 0
               then
                  null;
                  
               else
                  InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
                  exit AuswahlSchleife;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      return EinheitStadtDatentypen.ForschungIDMitNullWert (ForschungText (AktuelleAuswahl).Nummer);
      
   end ForschungAuswahlSFML;
   
   
   
   procedure MausAuswahl
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungen.MausPosition;
      TextPositionMaus := StartPositionText;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (12)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => 2 * GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 10.00 * Zeilenabstand;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      MausZeigerSchleife:
      for ForschungSchleifenwert in ForschungTextArray'First .. Ende loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => To_Wide_Wide_String (Source => ForschungText (ForschungSchleifenwert).Text));
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
           .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height)
           and
             MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x) .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextAccess).width)
         then
            AktuelleAuswahl := ForschungSchleifenwert;
            return;
         
         else
            TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * Zeilenabstand;
         end if;
                  
      end loop MausZeigerSchleife;
      
      AktuelleAuswahl := -1;
      
   end MausAuswahl;
   
   
   
   function ForschungAuswahl
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin
            
      AuswahlSchleife:
      loop

         -- Muss auch hier raus.
         Ermöglicht (RasseExtern           => RasseExtern,
                      ForschungNummerExtern => EinheitStadtDatentypen.ForschungID (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer));
         
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
               return EinheitStadtDatentypen.ForschungIDMitNullWert (ForschungText (AktuelleAuswahl).Nummer);

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
            when SystemDatentypen.Leer =>
               null;
               
            when SystemDatentypen.Spieler_Mensch =>
               FortschrittMensch (RasseExtern => RasseSchleifenwert);
               
            when SystemDatentypen.Spieler_KI =>
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
         
         InteraktionTasks.AktuelleRasse := RasseExtern;
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => AuswahlForschungNeu (RasseExtern => RasseExtern));
         InteraktionTasks.AktuelleRasse := SystemDatentypen.Keine_Rasse;
            
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
