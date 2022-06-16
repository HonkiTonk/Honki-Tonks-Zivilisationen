pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GrafikDatentypen;
with GlobaleTexte;

with HintergrundSFML;
with GrafikEinstellungenSFML;
with AllgemeineTextBerechnungenSFML;
with TextaccessVariablen;
with Ladezeiten;
with InteraktionGrafiktask;
with RassenAllgemein;

package body LadezeitenSFML is

   procedure SpielweltErstellen
   is begin
      
      StandardsFestlegen;
      
      WelcheZeit := 1;
      AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                    position => (AktuelleTextposition));
      
      AktuelleTextposition.y := AktuelleTextposition.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.LadezeitenAccess (WelcheZeit)).height + ZeilenAbstand;
      
      SpielweltErstellenSchleife:
      for SpielweltErstellenSchleifenwert in LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range loop
         
         WelcheZeit := WelcheZeit + 1;
         
         case
           Ladezeiten.FortschrittSpielwelt (SpielweltErstellenSchleifenwert)
         is
            when 0 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (WelcheZeit)));
            
            when others =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (WelcheZeit)) & " "
                                                  & To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittSpielwelt (SpielweltErstellenSchleifenwert))) & "/" & "100");
         end case;
                                                 
         AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
            
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                       position => AktuelleTextposition);
      
         AktuelleTextposition.y := AktuelleTextposition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.LadezeitenAccess (WelcheZeit)).height + ZeilenAbstand;
         
      end loop SpielweltErstellenSchleife;
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.LadezeitenAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.LadezeitenAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
                        
   end SpielweltErstellen;
   
   
   
   procedure KIRechnet
   is begin
      
      WelcheRasse := InteraktionGrafiktask.KIRechnet;
      
      case
        WelcheRasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            return;
            
         when others =>
            StandardsFestlegen;
      end case;
            
      AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccess'First));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccess'First),
                                    position => (AktuelleTextposition));
      
      AktuelleTextposition.y := AktuelleTextposition.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccess'First)).height + ZeilenAbstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccess'Last),
                                         str  => RassenAllgemein.Rassenname (RasseExtern => WelcheRasse) & " "
                                         & To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittKI (WelcheRasse))) & "/" & "100");
                                                 
      AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccess'Last));
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccess'Last),
                                    position => AktuelleTextposition);
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.KIZeitenAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.KIZeitenAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
      
   end KIRechnet;
   
   
   
   procedure Rundenende
   is begin
      
      StandardsFestlegen;
            
      AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'First));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'First),
                                    position => (AktuelleTextposition));
      
      AktuelleTextposition.y := AktuelleTextposition.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'First)).height + ZeilenAbstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'Last),
                                         str  => To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittRundenende)) & "/" & "100");
                                                 
      AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'Last));
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'Last),
                                    position => AktuelleTextposition);
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.RundenendeAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.RundenendeAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
      
   end Rundenende;
   
   
   
   procedure SpeichernLaden
   is begin
      
      StandardsFestlegen;
            
      AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'First));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'First),
                                    position => (AktuelleTextposition));
      
      AktuelleTextposition.y := AktuelleTextposition.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'First)).height + ZeilenAbstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'Last),
                                         str  => To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittSpeichernLaden)) & "/" & "100");
                                                 
      AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'Last));
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'Last),
                                    position => AktuelleTextposition);
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.RundenendeAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.SpeichernLadenAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
      
   end SpeichernLaden;
   
   
   
   procedure StandardsFestlegen
   is begin
      
      HintergrundSFML.StandardHintergrund (StandardHintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      AktuelleTextposition.y := 20.00;
      
   end StandardsFestlegen;

end LadezeitenSFML;
