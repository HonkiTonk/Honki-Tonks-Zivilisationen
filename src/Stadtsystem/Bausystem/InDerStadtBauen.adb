pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;

with EinheitenKonstanten;
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

package body InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      AktuellesBauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      NeuesBauprojekt := BauobjektAuswählen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        NeuesBauprojekt = 0
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
      return Natural
   is begin

      Ende := 1;
      Bauliste := (others => (True, 0));

      MöglicheGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      MöglicheEinheitenErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        Bauliste (Ende).Nummer = 0
        and
          Ende = 1
      then
         return 0;
         
      elsif
        GlobaleVariablen.AnzeigeArt = SystemDatentypen.SFML
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
            Bauliste (Ende).GebäudeEinheit := True;
            Bauliste (Ende).Nummer := StadtKonstanten.GebäudeAufschlag + Positive (GebäudeSchleifenwert);
            Ende := Ende + 1;
            
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
            Bauliste (Ende).GebäudeEinheit := False;
            Bauliste (Ende).Nummer := EinheitenKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
            Ende := Ende + 1;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end MöglicheEinheitenErmitteln;
   
   
   
   function AuswahlBauprojektSFML
     return Natural
   is begin
      
      GrafikTextAllgemein.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                                FontExtern         => GrafikEinstellungen.Schriftart,
                                                SchriftgrößeExtern => GrafikEinstellungen.FensterEinstellungen.Schriftgröße,
                                                FarbeExtern        => GrafikEinstellungen.Schriftfarben.FarbeStandardText);
      Zeilenabstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      
      InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Bauen;
      
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
                  exit AuswahlSchleife;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
      
      return 0;
      
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
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (Bauliste (BaulisteSchleifenwert).Nummer)));
               
            when False =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (Bauliste (BaulisteSchleifenwert).Nummer)));
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
     return Natural
   is begin
      
      AktuelleAuswahl := 1;
      InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Bauen;
      
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
               GewähltesBauprojekt := Bauliste (AktuelleAuswahl).Nummer;
               exit AuswahlSchleife;

            when SystemDatentypen.Menü_Zurück =>
               if
                 AktuellesBauprojekt /= 0
               then
                  GewähltesBauprojekt := AktuellesBauprojekt;
                  
               else
                  GewähltesBauprojekt := 0;
               end if;
               
               exit AuswahlSchleife;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektKonsole;

end InDerStadtBauen;
