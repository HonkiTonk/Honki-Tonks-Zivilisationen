pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;

with GlobaleTexte;
with ForschungKonstanten;
with TextKonstanten;
with TastenbelegungDatentypen;
with GrafikTonDatentypen;

with SchreibeWichtiges;
with LeseForschungsDatenbank;
with LeseWichtiges;

with TextAnzeigeKonsole;
with Eingabe;
with StadtWerteFestlegen;
with StadtUmgebungsbereichFestlegen;
with InteraktionLogiktask;
with GrafikEinstellungenSFML;
with TextAllgemeinSFML;
with InteraktionGrafiktask;

with KIForschung;

package body ForschungAllgemein is

   function Beschreibung
     (IDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      -- RasseExtern wird später benötigt wenn es verschiedene Forschungsbäume gibt.
      if
        RasseExtern = SystemDatentypen.Menschen_Enum
      then
         null;

      else
         null;
      end if;
      
      case
        IDExtern
      is
         when ForschungKonstanten.LeerForschungAnforderung =>
            BeschreibungText := GlobaleTexte.ZeugSachen (TextKonstanten.ZeugKeines);
            
         when others =>
            AktuelleForschung := 2 * Positive (IDExtern) - 1;
               
            BeschreibungText := GlobaleTexte.Forschungen (AktuelleForschung);
      end case;

      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end Beschreibung;



   -- Hier noch mehr Optionen einbauen, z. B. Informationen über bereits erforschte Technologien
   procedure Forschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
         
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      WasErforschtWerdenSoll := AuswahlForschungNeu (RasseExtern => RasseExtern);

      if
        WasErforschtWerdenSoll = ForschungKonstanten.LeerForschungAnforderung
        or
          WasErforschtWerdenSoll = AktuellesForschungsprojekt
      then
         null;
               
      else
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => WasErforschtWerdenSoll);
      end if;
      
   end Forschung;



   function AuswahlForschungNeu
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin
      
      ForschungText := (others => (TextKonstanten.LeerUnboundedString, 0));
      Ende := 0;

      ForschungSchleife:
      for ForschungenSchleifenwert in EinheitStadtDatentypen.ForschungID loop
         
         WelcherForschungstext := 2 * Positive (ForschungenSchleifenwert) - 1;
         
         case
           ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                         ForschungIDExtern => ForschungenSchleifenwert)
         is
            when True =>
               Ende := Ende + 1;
               ForschungText (Ende).Text := GlobaleTexte.Forschungen (WelcherForschungstext);
               ForschungText (Ende).Nummer := Positive (ForschungenSchleifenwert);
                  
            when False =>
               null;
         end case;
                  
      end loop ForschungSchleife;
      
      AktuelleAuswahl := 1;
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            return ForschungAuswahlKonsole;
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            return ForschungAuswahlSFML;
      end case;

   end AuswahlForschungNeu;
   
   
   
   function ForschungAuswahlSFML
     return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin
      
      TextAllgemeinSFML.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                              FontAccessExtern   => GrafikEinstellungenSFML.SchriftartAccess,
                                              SchriftgrößeExtern => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße,
                                              FarbeExtern        => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Forschung_Enum);
      
      AuswahlSchleife:
      loop
         
         MausAuswahl;
         
         case
           Eingabe.Tastenwert
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl <= 0
               then
                  null;
                  
               else
                  GewählteForschung := EinheitStadtDatentypen.ForschungIDMitNullWert (ForschungText (AktuelleAuswahl).Nummer);
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               GewählteForschung := ForschungKonstanten.LeerForschungAnforderung;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
      
      return GewählteForschung;
      
   end ForschungAuswahlSFML;
   
   
   
   procedure MausAuswahl
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      TextPositionMaus := StartPositionText;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextKonstanten.FrageForschungsprojekt)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => 2 * GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 10.00 * Zeilenabstand;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
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
   
   
   
   function ForschungAuswahlKonsole
     return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin
            
      AuswahlSchleife:
      loop
         
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Oben_Enum =>
               if
                 AktuelleAuswahl = TextAnzeigeKonsole.AllgemeineAnzeigeText'First
               then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungDatentypen.Unten_Enum =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := TextAnzeigeKonsole.AllgemeineAnzeigeText'First;
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               return EinheitStadtDatentypen.ForschungIDMitNullWert (ForschungText (AktuelleAuswahl).Nummer);

            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
            
   end ForschungAuswahlKonsole;



   procedure ForschungFortschritt
   is begin
      
      RasseSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemDatentypen.Leer_Spieler_Enum =>
               null;
               
            when SystemDatentypen.Spieler_Mensch_Enum =>
               FortschrittMensch (RasseExtern => RasseSchleifenwert);
               
            when SystemDatentypen.Spieler_KI_Enum =>
               FortschrittKI (RasseExtern => RasseSchleifenwert);
         end case;
               
      end loop RasseSchleife;
      
   end ForschungFortschritt;
   
   
   
   -- Die beiden Forschrittprozeduren zusammenführen? Sinnvoll oder könnte es bei Erweiterungen kompliziert werden?
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
           AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Anfangswert_Enum)
           or
             AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Endwert_Enum)
         then
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseExtern);

         else
            null;
         end if;
         
         InteraktionLogiktask.AktuelleRasseÄndern (RasseExtern => RasseExtern);
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => AuswahlForschungNeu (RasseExtern => RasseExtern));
         InteraktionLogiktask.AktuelleRasseÄndern (RasseExtern => SystemDatentypen.Keine_Rasse_Enum);
            
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
           AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Anfangswert_Enum)
           or
             AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Endwert_Enum)
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
           LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                         IDExtern                => ForschungIDExtern,
                                                         WelcheAnforderungExtern => AnforderungSchleifenwert)
           = ForschungKonstanten.ForschungUnmöglich
         then
            return False;
                  
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
