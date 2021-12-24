pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;

with LeseStadtGebaut;
with LeseEinheitenGebaut;

with GrafikEinstellungen;
with InteraktionTasks;
with Eingabe;
with EinheitenBeschreibungen;

package body AuswahlStadtEinheit is

   function AuswahlStadtEinheit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      -- Wenn die StadtNummerExtern = 0 ist, dann wird von einem beladenen Transporter ausgegangen.
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert)
      return Integer
   is begin
      
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungen.Schriftart);
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      Zeilenabstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      
      WelcheAuswahl.MöglicheAuswahlen := (others => 0);
      
      if
        StadtNummerExtern /= EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
      then
         WelcheAuswahl.StadtEinheit := True;
         WelcheAuswahl.MöglicheAuswahlen (0) := StadtNummerExtern;
         WelcheAuswahl.MöglicheAuswahlen (1) := EinheitNummerExtern;

      else
         WelcheAuswahl.StadtEinheit := False;
         WelcheAuswahl.MöglicheAuswahlen (0) := EinheitNummerExtern;
         
         TransporterSchleife:
         for WirdTransportiertSchleifenwert in EinheitStadtRecords.TransporterArray'Range loop
            
            WelcheAuswahl.MöglicheAuswahlen (WirdTransportiertSchleifenwert) := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern),
                                                                                                                    PlatzExtern              => WirdTransportiertSchleifenwert);
              
         end loop TransporterSchleife;
      end if;
      
      AktuelleAuswahl := 0;
      
      InteraktionTasks.Eingabe := SystemDatentypen.Einheit_Auswahl;
      
      AuswahlSchleife:
      loop
         
         MausAuswahl (RasseExtern => RasseExtern);
         
         case
           Eingabe.Tastenwert
         is               
            when SystemDatentypen.Auswählen =>
               if
                 AktuelleAuswahl >= 0
               then
                  exit AuswahlSchleife;
                  
               else
                  null;
               end if;
               
            when SystemDatentypen.Menü_Zurück =>
               AktuelleAuswahl := -1;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionTasks.Eingabe := SystemDatentypen.Keine_Eingabe;
      
      return AktuelleAuswahl;
      
   end AuswahlStadtEinheit;
   
   
   
   procedure MausAuswahl
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungen.MausPosition;
      TextPositionMaus := (Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungen.AktuelleFensterAuflösung.y) / 2.00);
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in WelcheAuswahl.MöglicheAuswahlen'Range loop
         
         if
           AuswahlSchleifenwert = WelcheAuswahl.MöglicheAuswahlen'First
         then
            case
              WelcheAuswahl.StadtEinheit
            is
               when True =>
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (2))
                                                     & To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (0)))));
         
               when False =>
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (0)))));
            end case;
            
         else
            if
              WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
            then
               null;
               
            else
               Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                  str  => EinheitenBeschreibungen.BeschreibungKurz
                                                    (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert)))));
            end if;
         end if;
            
         if
           -- Hier besser MaximaleStädteMitNullWert prüfen, wenn gleich es auch mit MaximaleEinheitenMitNullWert gehen sollte.
           WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
         then
            null;
            
         elsif
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
           .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height)
           and
             MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00)
               .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00)
         then
            AktuelleAuswahl := Natural (AuswahlSchleifenwert);
            return;
         
         else
            TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * Zeilenabstand;
         end if;
         
      end loop AuswahlSchleife;
              
      AktuelleAuswahl := -1;
      
   end MausAuswahl;

end AuswahlStadtEinheit;
