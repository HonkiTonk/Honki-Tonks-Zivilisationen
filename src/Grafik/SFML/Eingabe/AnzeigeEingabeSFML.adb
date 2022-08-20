pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen;
with GlobaleTexte;
with TextnummernKonstanten;
with GrafikDatentypen;
with ViewsSFML;
with TextaccessVariablen;

with EingabeSFML;
with GrafikEinstellungenSFML;
with EinheitenbeschreibungenSFML;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with TextberechnungenHoeheSFML;
with InteraktionAuswahl;
with TextberechnungenBreiteSFML;
with NachLogiktask;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;
with NachGrafiktask;

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
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.20));
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.20));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ZusatztextviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => (0.25, 0.45, 0.50, 0.10));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (FrageExtern)));
      
      Textposition.y := TextKonstanten.StartpositionText.y;
      Textposition.x := Viewfläche.x / 2.00
        - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First));
      
      Textbreite := 0.01;
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                                                        TextbreiteExtern => Textbreite);
      
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
      
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                                                        TextbreiteExtern => Textbreite);
      
      Textposition.x := Viewfläche.x / 2.00
        - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
      
      ZahlenanzeigeSchleife:
      for ZahlenanzeigeSchleifenwert in TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Range loop
      
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (ZahlenanzeigeSchleifenwert));
         
      end loop ZahlenanzeigeSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeGanzeZahl;
   
   
   
   -- Hier zwei Views einbauen, damit bei langen Texteingaben es nicht zu merkwürdigen Skalierungen bei der Frage kommt. äöü
   procedure AnzeigeText
     (FrageExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.20));
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.20));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ZusatztextviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => (0.25, 0.45, 0.50, 0.10));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (FrageExtern)));
      
      Textposition.y := TextKonstanten.StartpositionText.y;
      Textposition.x := Viewfläche.x / 2.00
        - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First));
      
      Textbreite := 0.01;
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                                                        TextbreiteExtern => Textbreite);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                    position => Textposition);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                         str  => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText));
      
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                                                        TextbreiteExtern => Textbreite);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Großerzeilenabstand;
      Textposition.x := Viewfläche.x / 2.00
        - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
      
      ZahlenanzeigeSchleife:
      for ZahlenanzeigeSchleifenwert in TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Range loop
      
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (ZahlenanzeigeSchleifenwert));
         
      end loop ZahlenanzeigeSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
      
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
            Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                            VerhältnisExtern => (0.25, 0.20));
            Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                            VerhältnisExtern => (0.25, 0.20));
      
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ZusatztextviewAccess,
                                                GrößeExtern          => Viewfläche,
                                                AnzeigebereichExtern => (0.25, 0.45, 0.50, 0.10));
      
            HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                              AbmessungenExtern => Viewfläche);
      end case;
      
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl;
      WelcheAuswahl := NachGrafiktask.WelcheAuswahl;
      
      Textposition.y := TextKonstanten.StartpositionText.y;
      Textbreite := 0.01;
            
      AuswahlSchleife:
      for AuswahlSchleifenwert in WelcheAuswahl.MöglicheAuswahlen'Range loop
         
         if
           AuswahlSchleifenwert = WelcheAuswahl.MöglicheAuswahlen'First
         then
            case
              WelcheAuswahl.StadtEinheit
            is
               when True =>
                  Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugStadt)
                    & LeseStadtGebaut.Name (StadtRasseNummerExtern => (RasseExtern, StadtDatentypen.MaximaleStädteMitNullWert (WelcheAuswahl.MöglicheAuswahlen (0))));
                  
               when False =>
                  Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern,
                                                                                                                                                                                  WelcheAuswahl.MöglicheAuswahlen (0)))));
            end case;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => Text));
                        
            InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
         else
            if
              WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               null;
               
            else
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                  str  => EinheitenbeschreibungenSFML.BeschreibungKurz
                                                    (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, WelcheAuswahl.MöglicheAuswahlen (AuswahlSchleifenwert)))));
               
               Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                 TextbreiteExtern => Textbreite);
            
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
               Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
         
            else
               Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
            end if;
            
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                       color => Farbe);
            
            Textposition.x := Viewfläche.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                          position => Textposition);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                              TextbreiteExtern => Textbreite);
            
            Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         end if;
         
      end loop AuswahlSchleife;
      
      Viewfläche := (Textbreite, Textposition.x);
            
   end AnzeigeEinheitenStadt;
   
   
   
   procedure AnzeigeJaNein
     (FrageExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.20));
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.25, 0.20));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ZusatztextviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => (0.25, 0.45, 0.50, 0.10));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
            
      Textbreite := 0.01;
      Textposition.y := TextKonstanten.StartpositionText.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.JaNeinAccess (1),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (FrageExtern)));
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Textposition.x := Viewfläche.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                       position => Textposition);
         
         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                           TextbreiteExtern => Textbreite);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.GroßerZeilenabstand;
         
         case
           TextSchleifenwert
         is
            when TextaccessVariablen.JaNeinAccessArray'First =>
               Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
            when others =>
               InteraktionAuswahl.PositionenJaNein (TextSchleifenwert - 1) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         end case;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         
      end loop TextSchleife;
      
      Textposition.y := Textposition.y - TextberechnungenHoeheSFML.GroßerZeilenabstand;
      Textposition.y := Textposition.y - TextberechnungenHoeheSFML.Zeilenabstand;
            
      Viewfläche := (Textbreite, Textposition.x);
      
   end AnzeigeJaNein;

end AnzeigeEingabeSFML;
