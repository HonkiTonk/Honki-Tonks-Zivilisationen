pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;

with EinheitStadtRecords; use EinheitStadtRecords;
with GrafikDatentypen; use GrafikDatentypen;
with StadtKonstanten;
with GlobaleTexte;
with TextKonstanten;
with TastenbelegungDatentypen;
with OptionenVariablen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with Eingabe;
with GebaeudeAllgemein;
with EinheitenModifizieren;
with InteraktionGrafiktask;
with TextAllgemeinSFML;
with GrafikEinstellungenSFML;
with Fehler;

package body InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      AktuellesBauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      NeuesBauprojekt := BauobjektAuswählen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        NeuesBauprojekt.Nummer = 0
        or
          NeuesBauprojekt = AktuellesBauprojekt
      then
         null;
            
      else
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => NeuesBauprojekt);
         SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         RessourcenExtern       => StadtKonstanten.LeerStadt.Ressourcen,
                                         ÄndernSetzenExtern     => False);
      end if;
      
   end Bauen;



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.BauprojektRecord
   is begin

      Ende := 0;
      Bauliste := (others => (True, 0));

      MöglicheGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      MöglicheEinheitenErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        Bauliste (Ende).Nummer = 0
        and
          Ende = 0
      then
         return StadtKonstanten.LeerBauprojekt;
         
      elsif
        OptionenVariablen.NutzerEinstellungen.Anzeigeart = GrafikDatentypen.Grafik_SFML_Enum
      then
         return AuswahlBauprojektSFML;
         
      else
         return AuswahlBauprojektKonsole;
      end if;
      
   end BauobjektAuswählen;
   
   
   
   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
                  
         if
           GebaeudeAllgemein.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            IDExtern               => GebäudeSchleifenwert)
           = True
         then
            EndeErhöhen;
            Bauliste (Ende).GebäudeEinheit := True;
            Bauliste (Ende).Nummer := GebäudeSchleifenwert;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
         
         if
           EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => EinheitSchleifenwert)
           = True
         then
            EndeErhöhen;
            Bauliste (Ende).GebäudeEinheit := False;
            Bauliste (Ende).Nummer := EinheitSchleifenwert;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end MöglicheEinheitenErmitteln;
   
   
   
   procedure EndeErhöhen
   is begin
      
      case
        Ende
      is
         when EinheitStadtDatentypen.MinimimMaximumID'Last =>
            Fehler.LogikFehler (FehlermeldungExtern => "InDerStadtBauen.EndeErhöhen - Ende ist über dem erlaubten Wert.");
            
         when others =>
            Ende := Ende + 1;
      end case;
      
   end EndeErhöhen;
   
   
   
   function AuswahlBauprojektSFML
     return EinheitStadtRecords.BauprojektRecord
   is begin
      
      TextAllgemeinSFML.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                              FontAccessExtern   => GrafikEinstellungenSFML.SchriftartAccess,
                                              SchriftgrößeExtern => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße,
                                              FarbeExtern        => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Bauen_Enum);
      
      AuswahlSchleife:
      loop
         
         MausAuswahl;
         
         case
           Eingabe.Tastenwert
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl < 0
               then
                  null;
                  
               else
                  GewähltesBauprojekt := Bauliste (AktuelleAuswahl);
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               GewähltesBauprojekt := StadtKonstanten.LeerBauprojekt;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektSFML;
   
   
   
   procedure MausAuswahl
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      TextPositionMaus := StartPositionText;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextKonstanten.FrageBauprojekt)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => 2 * GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 10.00 * Zeilenabstand;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      MausZeigerSchleife:
      for BaulisteSchleifenwert in BaulisteArray'First .. Ende loop
         
         case
           Bauliste (BaulisteSchleifenwert).GebäudeEinheit
         is
            when True =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (Bauliste (BaulisteSchleifenwert).Nummer) - 1)));
               
            when False =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (Bauliste (BaulisteSchleifenwert).Nummer) - 1)));
         end case;
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
           .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height)
           and
             MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x) .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextAccess).width)
         then
            AktuelleAuswahl := BaulisteSchleifenwert;
            return;
         
         else
            TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * Zeilenabstand;
         end if;
                  
      end loop MausZeigerSchleife;
      
      AktuelleAuswahl := -1;
      
   end MausAuswahl;
   
   
   
   function AuswahlBauprojektKonsole
     return EinheitStadtRecords.BauprojektRecord
   is begin
      
      AktuelleAuswahl := 1;
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Bauen_Enum);
      
      AuswahlSchleife:
      loop
         
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Oben_Enum =>
               if
                 AktuelleAuswahl = Bauliste'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungDatentypen.Unten_Enum =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Bauliste'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when TastenbelegungDatentypen.Auswählen_Enum =>
               GewähltesBauprojekt := Bauliste (AktuelleAuswahl);
               exit AuswahlSchleife;

            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               if
                 AktuellesBauprojekt.Nummer /= 0
               then
                  GewähltesBauprojekt := AktuellesBauprojekt;
                  
               else
                  GewähltesBauprojekt := StadtKonstanten.LeerBauprojekt;
               end if;
               
               exit AuswahlSchleife;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektKonsole;

end InDerStadtBauen;
