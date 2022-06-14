pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with LadezeitenDatentypen;
with GrafikDatentypen;
with GlobaleTexte;

with HintergrundSFML;
with GrafikEinstellungenSFML;
with AllgemeineTextBerechnungenSFML;
with TextaccessVariablen;
with Ladezeiten;

package body LadezeitenSFML is

   procedure SpielweltErstellen
   is begin
      
      HintergrundSFML.StandardHintergrund (StandardHintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
      WelcheZeit := 1;
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      AktuelleTextposition.y := 20.00;
      AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                    position => (AktuelleTextposition));
      
      AktuelleTextposition.y := AktuelleTextposition.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.LadezeitenAccess (WelcheZeit)).height + ZeilenAbstand;
      
      --------------------------- Anstelle die Zeiten zu nutzen lieber ein internes System bauen.
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
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (WelcheZeit)) & " " & "" & "/" & "100");
         end case;
                                                 
         AktuelleTextposition.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
            
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                       position => (AktuelleTextposition));
      
         AktuelleTextposition.y := AktuelleTextposition.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.LadezeitenAccess (WelcheZeit)).height + ZeilenAbstand;
         
      end loop SpielweltErstellenSchleife;
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.LadezeitenAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.LadezeitenAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
                        
   end SpielweltErstellen;

end LadezeitenSFML;
