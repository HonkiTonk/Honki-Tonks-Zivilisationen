pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen;
with GlobaleTexte;
with TextnummernKonstanten;
with GrafikDatentypen;

with EingabeSFML;
with GrafikEinstellungenSFML;
with ObjekteZeichnenSFML;
with EinheitenBeschreibungen;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with TextaccessVariablen;
with TextberechnungenHoeheSFML;
with InteraktionAuswahl;
with TextberechnungenBreiteSFML;
with NachLogiktask;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;
with ViewsSFML;

package body AnzeigeEingabeSFML is
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesNatural;
      EingabeExtern : in SystemDatentypen.Eingaben_Fragen_Enum)
   is begin
      
      case
        FrageExtern
      is
         when 0 =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        EingabeExtern
      is
         when SystemDatentypen.Text_Eingabe_Enum =>
            AnzeigeText (FrageExtern => FrageExtern);
            
         when SystemDatentypen.Zahlen_Eingabe_Enum =>
            AnzeigeGanzeZahl (FrageExtern => FrageExtern);
            
         when SystemDatentypen.Ja_Nein_Enum =>
            AnzeigeJaNein (FrageExtern => FrageExtern);
      end case;
      
   end Fragenaufteilung;
   
   

   procedure AnzeigeGanzeZahl
     (FrageExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ZusatztextviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => (0.25, 0.10, 0.50, 0.20));
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
      
      Textposition := Startposition;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (FrageExtern)));
      
      Textbreite := Startposition.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).width + Startposition.x;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                    position => Textposition);
      
      case
        EingabeSFML.WelchesVorzeichen
      is
         when False =>
            AktuellerText := To_Unbounded_Wide_Wide_String (Source => "-") & ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);
                              
         when True =>
            AktuellerText := ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);       
      end case;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.GroßerZeilenabstand;
                              
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                         str  => To_Wide_Wide_String (Source => AktuellerText));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                    position =>
                                      (Viewfläche.x / 2.00
                                       - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last)),
                                       Textposition.y));
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
      Textposition.x := Startposition.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last)).width + Startposition.x;
      
      if
        Textbreite > Textposition.x
      then
         Textposition.x := Textbreite;
         
      else
         null;
      end if;
      
      Viewfläche := Textposition;
      
      ZahlenanzeigeSchleife:
      for ZahlenanzeigeSchleifenwert in TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Range loop
      
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (ZahlenanzeigeSchleifenwert));
         
      end loop ZahlenanzeigeSchleife;
      
   end AnzeigeGanzeZahl;
   
   
   
   procedure AnzeigeText
     (FrageExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (FrageExtern)));
      
      Textbreite := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).width;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                    position => ((GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 2.00 - Textbreite / 2.00), 100.00));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                         str  => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                    position => ((GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 2.00
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
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            return;
            
         when others =>
            null;
      end case;
            
      AktuelleAuswahl := AuswahlStadtEinheit.AktuelleAuswahl;
      WelcheAuswahl := AuswahlStadtEinheit.WelcheAuswahl;
      Textposition := (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 2.00, GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 2.00);
      
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
                                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextnummernKonstanten.ZeugStadt))
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
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
         
            else
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
            end if;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                          position => (Textposition.x - Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert)).width / 2.00, Textposition.y));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         end if;
         
      end loop AuswahlSchleife;
            
   end AnzeigeEinheitenStadt;
   
   
   
   procedure AnzeigeJaNein
     (FrageExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      case
        FrageExtern
      is
         when 0 =>
            return;
            
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.JaNeinAccess (1),
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (FrageExtern)));
      end case;
      
      Textposition := (TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (1),
                                                                           ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x),
                       TextberechnungenHoeheSFML.HalbeBildschirmhöhe);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (1),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.GroßerZeilenabstand;
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (2),
                                                                            ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (2),
                                    position => Textposition);
      
      InteraktionAuswahl.PositionenJaNein (1) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (2));
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (3),
                                                                            ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (3),
                                    position => Textposition);
      
      InteraktionAuswahl.PositionenJaNein (2) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (3));
      
      -- Das ganze Draw Zeug mal auslagern? äöü
      -- Bringt es wahrscheinlich nicht wirklich, da ich ja dann immer noch die Schleife hier habe. äöü
      TextAnzeigenSchleife:
      for TextAnzeigenSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.JaNeinAccess (TextAnzeigenSchleifenwert));
         
      end loop TextAnzeigenSchleife;
      
   end AnzeigeJaNein;

end AnzeigeEingabeSFML;
