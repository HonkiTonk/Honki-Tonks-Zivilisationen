pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GlobaleTexte;
with TextKonstanten;
with Views;

with HintergrundGrafik;
with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessVariablen;
with LadezeitenLogik;
with RassenbeschreibungenGrafik;
with TextberechnungenBreiteGrafik;
with ViewsEinstellenGrafik;
with AllgemeineViewsGrafik;

package body LadezeitenGrafik is
   
   procedure Ladezeiten
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
            
      case
        WelcheLadeanzeigeExtern
      is
         when GrafikDatentypen.Grafik_Generierungszeit_Enum =>
            Text := GlobaleTexte.Ladezeit (1);
            
         when GrafikDatentypen.Grafik_KI_Rechenzeit_Enum =>
            Text := RassenbeschreibungenGrafik.BeschreibungKurz (RasseExtern => RasseExtern) & " " & GlobaleTexte.Ladezeit (10);
            
         when GrafikDatentypen.Grafik_Rundenende_Enum =>
            Text := GlobaleTexte.Ladezeit (15);
            
         when GrafikDatentypen.Grafik_Speichern_Laden_Enum =>
            Text := GlobaleTexte.Ladezeit (16);
      end case;
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Text),
                                          HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                          SpielenamenExtern => False);
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Ladebereich.width, GrafikRecordKonstanten.Ladebereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.LadeviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Ladebereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
            
      case
        WelcheLadeanzeigeExtern
      is
         when GrafikDatentypen.Grafik_Generierungszeit_Enum =>
            Viewfläche := SpielweltErstellen (ViewflächeExtern => Viewfläche);
            
         when GrafikDatentypen.Grafik_KI_Rechenzeit_Enum =>
            Viewfläche := KIRechnet (ViewflächeExtern => Viewfläche);
            
         when GrafikDatentypen.Grafik_Rundenende_Enum =>
            Viewfläche := Rundenende (ViewflächeExtern => Viewfläche);
            
         when GrafikDatentypen.Grafik_Speichern_Laden_Enum =>
            Viewfläche := SpeichernLaden (ViewflächeExtern => Viewfläche);
      end case;
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
   end Ladezeiten;
   
   

   -- Die ViewflächeExtern.y wird nicht benötigt, nur den x-Wert hineingeben als Float? äöü
   -- Gilt auch bei en anderen Funktionen. äöü
   function SpielweltErstellen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      WelcheZeit := TextaccessVariablen.LadezeitenAccess'First;
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
                     
      SpielweltErstellenSchleife:
      for SpielweltErstellenSchleifenwert in LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range loop
                
         Text := GlobaleTexte.Ladezeit (WelcheZeit) & TextKonstanten.StandardAbstand & ZahlAlsStringLadefortschritt (ZahlExtern => LadezeitenLogik.FortschrittSpielwelt (SpielweltErstellenSchleifenwert))
           & TextKonstanten.Trennzeichen & "100";
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                            str  => To_Wide_Wide_String (Text));
                                                 
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                                                                 ViewbreiteExtern => ViewflächeExtern.x);
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                                                             TextbreiteExtern => Textbreite);
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                       position => Textposition);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.LadezeitenAccess (WelcheZeit),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
         
         WelcheZeit := WelcheZeit + 1;
         
      end loop SpielweltErstellenSchleife;
      
      return (Textbreite, Textposition.y);
                        
   end SpielweltErstellen;
   
   
   
   function KIRechnet
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      WelcheZeit := TextaccessVariablen.KIZeitenAccess'First;
      
      KIRechnetSchleife:
      for KIRechnetSchleifenwert in LadezeitenDatentypen.KI_Rechnet_Enum'Range loop
                  
         Text := GlobaleTexte.Ladezeit (WelcheZeit) & TextKonstanten.StandardAbstand & ZahlAlsStringLadefortschritt (ZahlExtern => LadezeitenLogik.FortschrittKI (KIRechnetSchleifenwert))
           & TextKonstanten.Trennzeichen & "100";
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                            str  => To_Wide_Wide_String (Source => Text));
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                                                                 ViewbreiteExtern => ViewflächeExtern.x);
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                                                             TextbreiteExtern => Textbreite);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
            
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KIZeitenAccess (WelcheZeit),
                                       position => Textposition);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.KIZeitenAccess (WelcheZeit));
         
         WelcheZeit := WelcheZeit + 1;
         
      end loop KIRechnetSchleife;
      
      return (Textbreite, Textposition.y);
      
   end KIRechnet;
   
   
   
   function Rundenende
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RundenendeAccess (1),
                                         str  => To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => LadezeitenLogik.FortschrittRundenende)) & TextKonstanten.Trennzeichen & "100");
                                                 
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.RundenendeAccess (1),
                                                                              ViewbreiteExtern => ViewflächeExtern.x);
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.RundenendeAccess (1),
                                                                          TextbreiteExtern => 0.00);
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RundenendeAccess (1),
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.RundenendeAccess (1));
               
      return (Textbreite, Textposition.y);
      
   end Rundenende;
   
   
   
   function SpeichernLaden
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeichernLadenAccess (1),
                                         str  => To_Wide_Wide_String (Source => ZahlAlsStringLadefortschritt (ZahlExtern => LadezeitenLogik.FortschrittSpeichernLaden)) & TextKonstanten.Trennzeichen & "100");
                                                 
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SpeichernLadenAccess (1),
                                                                              ViewbreiteExtern => ViewflächeExtern.x);
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.RundenendeAccess (1),
                                                                          TextbreiteExtern => 0.00);
            
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SpeichernLadenAccess (1),
                                    position => Textposition);
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.SpeichernLadenAccess (1));
      
      return (Textbreite, Textposition.y);
      
   end SpeichernLaden;

end LadezeitenGrafik;
