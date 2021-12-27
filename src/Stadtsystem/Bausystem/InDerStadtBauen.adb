pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;

with EinheitStadtRecords; use EinheitStadtRecords;
with StadtKonstanten;
with GlobaleTexte;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with Eingabe;
with GebaeudeAllgemein;
with EinheitenModifizieren;
with InteraktionTasks;
with GrafikTextAllgemein;
with GrafikEinstellungen;
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
        GlobaleVariablen.AnzeigeArt = SystemDatentypen.Grafik_SFML
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
            Fehler.LogikStopp (FehlermeldungExtern => "InDerStadtBauen.EndeErhöhen - Ende ist über dem erlaubten Wert.");
            
         when others =>
            Ende := Ende + 1;
      end case;
      
   end EndeErhöhen;
   
   
   
   function AuswahlBauprojektSFML
     return EinheitStadtRecords.BauprojektRecord
   is begin
      
      GrafikTextAllgemein.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                                FontAccessExtern   => GrafikEinstellungen.SchriftartAccess,
                                                SchriftgrößeExtern => GrafikEinstellungen.FensterEinstellungen.Schriftgröße,
                                                FarbeExtern        => GrafikEinstellungen.Schriftfarben.FarbeStandardText);
      Zeilenabstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      
      InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Bauen);
      
      AuswahlSchleife:
      loop
         
         MausAuswahl;
         
         case
           Eingabe.Tastenwert
         is               
            when SystemDatentypen.Auswählen =>
               if
                 AktuelleAuswahl < 0
               then
                  null;
                  
               else
                  GewähltesBauprojekt := Bauliste (AktuelleAuswahl);
                  exit AuswahlSchleife;
               end if;
               
            when SystemDatentypen.Menü_Zurück =>
               GewähltesBauprojekt := StadtKonstanten.LeerBauprojekt;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektSFML;
   
   
   
   procedure MausAuswahl
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungen.MausPosition;
      TextPositionMaus := StartPositionText;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (9)));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => 2 * GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 10.00 * Zeilenabstand;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
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
      InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Bauen);
      
      AuswahlSchleife:
      loop
         
         case
           Eingabe.Tastenwert
         is
            when SystemDatentypen.Oben =>
               if
                 AktuelleAuswahl = Bauliste'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Unten =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Bauliste'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when SystemDatentypen.Auswählen =>
               GewähltesBauprojekt := Bauliste (AktuelleAuswahl);
               exit AuswahlSchleife;

            when SystemDatentypen.Menü_Zurück =>
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
      
      InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektKonsole;

end InDerStadtBauen;
