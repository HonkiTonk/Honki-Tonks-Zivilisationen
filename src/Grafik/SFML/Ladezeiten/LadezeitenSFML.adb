pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GlobaleTexte;
with TextKonstanten;

with HintergrundSFML;
with GrafikEinstellungenSFML;
with TextberechnungenHoeheSFML;
with TextaccessVariablen;
with Ladezeiten;
with RassenAllgemein;
with TextberechnungenBreiteSFML;
with Fehler;

package body LadezeitenSFML is
   
   procedure LadezeitenSFML
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      HintergrundSFML.StandardHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
      
      case
        WelcheLadeanzeigeExtern
      is
         when GrafikDatentypen.Grafik_Generierungszeit_Enum =>
            SpielweltErstellen;
            
         when GrafikDatentypen.Grafik_KI_Rechenzeit_Enum =>
            if
              RasseExtern = RassenDatentypen.Keine_Rasse_Enum
            then
               Fehler.GrafikFehler (FehlermeldungExtern => "LadezeitenSFML.LadezeitenSFML - Keine Rasse ausgewählt.");
               
            else
               KIRechnet (RasseExtern => RasseExtern);
            end if;
            
         when GrafikDatentypen.Grafik_Rundenende_Enum =>
            Rundenende;
            
         when GrafikDatentypen.Grafik_Speichern_Laden_Enum =>
            SpeichernLaden;
      end case;
      
   end LadezeitenSFML;
      
   

   procedure SpielweltErstellen
   is begin
            
      WelcheZeit := TextaccessVariablen.LadezeitenAccess'First;
      AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
      AktuelleTextposition.y := AnfangspositionText;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                    position => AktuelleTextposition);
      
      AktuelleTextposition.y := AktuelleTextposition.y + TextberechnungenHoeheSFML.Überschriftabstand;
            
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
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (WelcheZeit)) & TextKonstanten.StandardAbstand
                                                  & To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittSpielwelt (SpielweltErstellenSchleifenwert))) & "/" & "100");
         end case;
                                                 
         AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
            
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                       position => AktuelleTextposition);
         
         AktuelleTextposition.y := AktuelleTextposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
      end loop SpielweltErstellenSchleife;
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.LadezeitenAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.LadezeitenAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
                        
   end SpielweltErstellen;
   
   
   
   procedure KIRechnet
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      WelcheZeit := TextaccessVariablen.KIZeitenAccess'First;
      AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (WelcheZeit));
      AktuelleTextposition.y := AnfangspositionText;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                    position => (AktuelleTextposition));
      
      AktuelleTextposition.y := AktuelleTextposition.y + TextberechnungenHoeheSFML.Überschriftabstand;
      
      WelcheZeit := WelcheZeit + 1;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                         str  => RassenAllgemein.Rassenname (RasseExtern => RasseExtern));
                                                 
      AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (WelcheZeit));
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                    position => AktuelleTextposition);
      
      KIRechnetSchleife:
      for KIRechnetSchleifenwert in LadezeitenDatentypen.KI_Rechnet_Enum'Range loop
         
         AktuelleTextposition.y := AktuelleTextposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         WelcheZeit := WelcheZeit + 1;
         
         case
           Ladezeiten.FortschrittKI (KIRechnetSchleifenwert)
         is
            when 0 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (WelcheZeit)));
            
            when others =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (WelcheZeit)) & TextKonstanten.StandardAbstand
                                                  & To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittKI (KIRechnetSchleifenwert))) & "/" & "100");
         end case;
         
         AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (WelcheZeit));
            
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                       position => AktuelleTextposition);
         
      end loop KIRechnetSchleife;
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.KIZeitenAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.KIZeitenAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
      
   end KIRechnet;
   
   
   
   procedure Rundenende
   is begin
                  
      AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'First));
      AktuelleTextposition.y := AnfangspositionText;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'First),
                                    position => (AktuelleTextposition));
      
      AktuelleTextposition.y := AktuelleTextposition.y + TextberechnungenHoeheSFML.Überschriftabstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'Last),
                                         str  => To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittRundenende)) & "/" & "100");
                                                 
      AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccess'Last));
            
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
                  
      AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'First));
      AktuelleTextposition.y := AnfangspositionText;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'First),
                                    position => (AktuelleTextposition));
      
      AktuelleTextposition.y := AktuelleTextposition.y + TextberechnungenHoeheSFML.Überschriftabstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'Last),
                                         str  => To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittSpeichernLaden)) & "/" & "100");
                                                 
      AktuelleTextposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'Last));
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccess'Last),
                                    position => AktuelleTextposition);
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.RundenendeAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.SpeichernLadenAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
      
   end SpeichernLaden;

end LadezeitenSFML;
