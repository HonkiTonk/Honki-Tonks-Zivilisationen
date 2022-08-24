pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GlobaleTexte;
with TextKonstanten;
with Views;

with HintergrundSFML;
with GrafikEinstellungenSFML;
with TextberechnungenHoeheSFML;
with TextaccessVariablen;
with Ladezeiten;
with RassenbeschreibungenSFML;
with TextberechnungenBreiteSFML;
with ViewsEinstellenSFML;
with AllgemeineViewsSFML;

package body LadezeitenSFML is
   
   procedure LadezeitenSFML
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      case
        WelcheLadeanzeigeExtern
      is
         when GrafikDatentypen.Grafik_Generierungszeit_Enum =>
            Text := GlobaleTexte.Ladezeit (1);
            
         when GrafikDatentypen.Grafik_KI_Rechenzeit_Enum =>
            Text := RassenbeschreibungenSFML.BeschreibungKurz (RasseExtern => RasseExtern) & " " & GlobaleTexte.Ladezeit (10);
            
         when GrafikDatentypen.Grafik_Rundenende_Enum =>
            Text := GlobaleTexte.Ladezeit (15);
            
         when GrafikDatentypen.Grafik_Speichern_Laden_Enum =>
            Text := GlobaleTexte.Ladezeit (16);
      end case;
      
      AllgemeineViewsSFML.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Text),
                                        HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.LadeviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Ladebereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
            
      case
        WelcheLadeanzeigeExtern
      is
         when GrafikDatentypen.Grafik_Generierungszeit_Enum =>
            Viewfläche := SpielweltErstellen;
            
         when GrafikDatentypen.Grafik_KI_Rechenzeit_Enum =>
            Viewfläche := KIRechnet;
            
         when GrafikDatentypen.Grafik_Rundenende_Enum =>
            Viewfläche := Rundenende;
            
         when GrafikDatentypen.Grafik_Speichern_Laden_Enum =>
            Viewfläche := SpeichernLaden;
      end case;
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end LadezeitenSFML;
   
   

   function SpielweltErstellen
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      WelcheZeit := TextaccessVariablen.LadezeitenAccess'First;
      Textposition.y := TextberechnungenHoeheSFML.Zeilenabstand;
                     
      SpielweltErstellenSchleife:
      for SpielweltErstellenSchleifenwert in LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range loop
                  
         case
           Ladezeiten.FortschrittSpielwelt (SpielweltErstellenSchleifenwert)
         is
            when 0 =>
               Text := GlobaleTexte.Ladezeit (WelcheZeit);
            
            when others =>
               Text := GlobaleTexte.Ladezeit (WelcheZeit) & TextKonstanten.StandardAbstand & ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittSpielwelt (SpielweltErstellenSchleifenwert)) & "/" & "100";
         end case;
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                            str  => To_Wide_Wide_String (Text));
                                                 
         Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                                                               ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                                                           TextbreiteExtern => Textbreite);
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                       position => Textposition);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
         
         WelcheZeit := WelcheZeit + 1;
         
      end loop SpielweltErstellenSchleife;
      
      return (Textbreite, Textposition.y);
                        
   end SpielweltErstellen;
   
   
   
   function KIRechnet
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      Textposition.y := TextberechnungenHoeheSFML.Zeilenabstand;
      WelcheZeit := TextaccessVariablen.KIZeitenAccess'First;
      
      KIRechnetSchleife:
      for KIRechnetSchleifenwert in LadezeitenDatentypen.KI_Rechnet_Enum'Range loop
                  
         case
           Ladezeiten.FortschrittKI (KIRechnetSchleifenwert)
         is
            when 0 =>
               Text := GlobaleTexte.Ladezeit (WelcheZeit);
            
            when others =>
               Text := GlobaleTexte.Ladezeit (WelcheZeit) & TextKonstanten.StandardAbstand & ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittKI (KIRechnetSchleifenwert)) & "/" & "100";
         end case;
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                            str  => To_Wide_Wide_String (Source => Text));
         
         Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                                                               ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                                                           TextbreiteExtern => Textbreite);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
            
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                       position => Textposition);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.KIZeitenAccess (WelcheZeit));
         
         WelcheZeit := WelcheZeit + 1;
         
      end loop KIRechnetSchleife;
      
      return (Textbreite, Textposition.y);
      
   end KIRechnet;
   
   
   
   function Rundenende
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheSFML.Zeilenabstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RundenendeAccess (1),
                                         str  => To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittRundenende)) & "/" & "100");
                                                 
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.RundenendeAccess (1),
                                                                            ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.RundenendeAccess (1),
                                                                        TextbreiteExtern => 0.00);
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RundenendeAccess (1),
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.RundenendeAccess (1));
         
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
      
      return (Textbreite, Textposition.y);
      
   end Rundenende;
   
   
   
   function SpeichernLaden
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheSFML.Zeilenabstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeichernLadenAccess (1),
                                         str  => To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => Ladezeiten.FortschrittSpeichernLaden)) & "/" & "100");
                                                 
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SpeichernLadenAccess (1),
                                                                            ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.RundenendeAccess (1),
                                                                        TextbreiteExtern => 0.00);
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SpeichernLadenAccess (1),
                                    position => Textposition);
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.SpeichernLadenAccess (1));
      
      return (Textbreite, Textposition.y);
      
   end SpeichernLaden;

end LadezeitenSFML;
