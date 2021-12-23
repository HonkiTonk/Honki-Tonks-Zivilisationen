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
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert)
      return KartenDatentypen.LoopRangeMinusEinsZuEins
   is begin
      
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungen.Schriftart);
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
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

      StadtRasseNummer := (RasseExtern, StadtNummerExtern); -- Die zwei Dinger hier können weg.
      EinheitRasseNummer := (RasseExtern, EinheitNummerExtern);
      
      AktuelleAuswahl := 0;
      
      InteraktionTasks.Eingabe := SystemDatentypen.Einheit_Auswahl;
      
      AuswahlSchleife:
      loop
         
         MausAuswahl;
         
         case
           Eingabe.Tastenwert
         is               
            when SystemDatentypen.Auswählen =>
               if
                 AktuelleAuswahl = 1
                 or
                   AktuelleAuswahl = -1
               then
                  Auswahl := KartenDatentypen.LoopRangeMinusEinsZuEins (AktuelleAuswahl);
                  exit AuswahlSchleife;
                  
               else
                  null;
               end if;
               
            when SystemDatentypen.Menü_Zurück =>
               Auswahl := 0;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionTasks.Eingabe := SystemDatentypen.Keine_Eingabe;
      
      return Auswahl;
      
   end AuswahlStadtEinheit;
   
   
   
   procedure MausAuswahl
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungen.MausPosition;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (2)) & To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummer)));
              
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => ((Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) / 2.00 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00),
                                                 (Float (GrafikEinstellungen.AktuelleFensterAuflösung.y) / 2.00)));
      
      TextPositionMaus := Sf.Graphics.Text.getPosition (text => TextAccess);
      
      if
        MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
        .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height)
        and
          MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x) .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextAccess).width)
      then
         AktuelleAuswahl := 1;
         return;
         
      else
         Sf.Graphics.Text.setPosition (text     => TextAccess,
                                       position => ((Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) / 2.00 - Sf.Graphics.Text.getLocalBounds (text => TextAccess).width / 2.00),
                                                    (Float (GrafikEinstellungen.AktuelleFensterAuflösung.y) / 2.00 + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 10.00)));
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
         TextPositionMaus := Sf.Graphics.Text.getPosition (text => TextAccess);
      end if;
      
      if
        MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
        .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height)
        and
          MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x) .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextAccess).width)
      then
         AktuelleAuswahl := -1;
         
      else
         AktuelleAuswahl := 0;
      end if;
      
   end MausAuswahl;

end AuswahlStadtEinheit;
