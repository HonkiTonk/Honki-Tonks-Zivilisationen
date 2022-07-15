pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen;
with GlobaleTexte;
with TextKonstanten;

with EingabeSFML;
with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with EingabeSystemeSFML;
with EinheitenBeschreibungen;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with TextaccessVariablen;
with TextberechnungenHoeheSFML;
with InteraktionAuswahl;
with InteraktionEingabe;
with TextberechnungenBreiteSFML;

package body AnzeigeEingabeSFML is

   procedure AnzeigeGanzeZahl
   is begin
      
      WelcheFrage := EingabeSFML.Frage;
                  
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
      
      Textbreite := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).width;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00 - Textbreite / 2.00), 100.00));
      
      case
        EingabeSFML.WelchesVorzeichen
      is
         when False =>
            AktuellerText := To_Unbounded_Wide_Wide_String (Source => "-") & ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);
                              
         when True =>
            AktuellerText := ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);       
      end case;
                              
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                         str  => To_Wide_Wide_String (Source => AktuellerText));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last)).width / 2.00),
                                                 150.00));
      
      ----------------------- Die Abmessungen der Rechtecke immer an den größten Text anpassen.
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Textbreite + 20.00, 100.00),
                                            PositionExtern       => (Sf.Graphics.Text.getPosition (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).x
                                                                     - 10.00,
                                                                     Sf.Graphics.Text.getPosition (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).y
                                                                     - 10.00),
                                            FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                            RechteckAccessExtern => RechteckAccess);
      
      ZahlenanzeigeSchleife:
      for ZahlenanzeigeSchleifenwert in TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Range loop
      
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (ZahlenanzeigeSchleifenwert));
         
      end loop ZahlenanzeigeSchleife;
      
   end AnzeigeGanzeZahl;
   
   
   
   procedure AnzeigeText
   is begin
      
      WelcheFrage := EingabeSFML.Frage;
                  
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
      
      Textbreite := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).width;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00 - Textbreite / 2.00), 100.00));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                         str  => To_Wide_Wide_String (Source => EingabeSystemeSFML.EingegebenerText.EingegebenerText));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                    position => ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00
                                                 - Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last)).width / 2.00),
                                                 150.00));
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (Textbreite + 20.00, 100.00),
                                            PositionExtern       => (Sf.Graphics.Text.getPosition (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).x
                                                                     - 10.00,
                                                                     Sf.Graphics.Text.getPosition (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).y
                                                                     - 10.00),
                                            FarbeExtern          => Sf.Graphics.Color.sfBlack,
                                            RechteckAccessExtern => RechteckAccess);
      
      ZahlenanzeigeSchleife:
      for ZahlenanzeigeSchleifenwert in TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Range loop
      
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (ZahlenanzeigeSchleifenwert));
         
      end loop ZahlenanzeigeSchleife;
      
   end AnzeigeText;
   
   
   
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -------------------- Allgemeine Werte wie Zeilenabstand, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00 und Änhliches auch mal auslagern und nur bei Änderungen der jeweiligen Werte anpassen.
      Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      AktuelleAuswahl := AuswahlStadtEinheit.AktuelleAuswahl;
      WelcheAuswahl := AuswahlStadtEinheit.WelcheAuswahl;
      TextPosition := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00);
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in WelcheAuswahl.MöglicheAuswahlen'Range loop
         
         if
           AuswahlSchleifenwert = WelcheAuswahl.MöglicheAuswahlen'First
         then
            case
              WelcheAuswahl.StadtEinheit
            is
               when True =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugStadt))
                                                     & To_Wide_Wide_String (Source => LeseStadtGebaut.Name
                                                                              (StadtRasseNummerExtern => (RasseExtern, StadtDatentypen.MaximaleStädteMitNullWert (WelcheAuswahl.MöglicheAuswahlen (0))))));
                  
               when False =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (0)))));
            end case;
            
            InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
         else
            if
              WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               null;
               
            else
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                  str  => EinheitenBeschreibungen.BeschreibungKurz
                                                    (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert)))));
            
               InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            end if;
         end if;
         
         if
           WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenDatentypen.MaximaleEinheitenMitNullWert (StadtDatentypen.MaximaleStädteMitNullWert'First)
         then
            null;
            
         else
            if
              AktuelleAuswahl = Natural (AuswahlSchleifenwert)
            then
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
         
            else
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            end if;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                          position => (TextPosition.x - Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert)).width / 2.00, TextPosition.y));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert)).height + 3.00 * Zeilenabstand;
         end if;
         
      end loop AuswahlSchleife;
            
   end AnzeigeEinheitenStadt;
   
   
   
   procedure AnzeigeJaNein
   is begin
      
      WelcheFrage := InteraktionEingabe.JaNeinFrage;
      
      case
        WelcheFrage
      is
         when 0 =>
            return;
            
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.JaNeinAccess (1),
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (WelcheFrage)));
            Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      end case;
      
      TextPosition := (TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (1)), TextberechnungenHoeheSFML.HalbeBildschirmhöhe);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (1),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.JaNeinAccess (1)).height + 3.00 * Zeilenabstand;
      TextPosition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (2));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (2),
                                    position => TextPosition);
      
      InteraktionAuswahl.PositionenJaNein (1) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (2));
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.JaNeinAccess (2)).height + 3.00 * Zeilenabstand;
      TextPosition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (3));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (3),
                                    position => TextPosition);
      
      InteraktionAuswahl.PositionenJaNein (2) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (3));
      
      ------------------------ Das ganze Draw Zeug mal auslagern.
      TextAnzeigenSchleife:
      for TextAnzeigenSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.JaNeinAccess (TextAnzeigenSchleifenwert));
         
      end loop TextAnzeigenSchleife;
      
   end AnzeigeJaNein;

end AnzeigeEingabeSFML;
