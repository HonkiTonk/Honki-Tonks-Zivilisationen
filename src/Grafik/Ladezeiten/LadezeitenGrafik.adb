with TextKonstantenHTSEB;

with Spieltexte;
with Views;
with LadezeitenDatentypen;
with TextnummernKonstanten;
with LeseGrafiktask;

with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessVariablen;
with LadezeitenLogik;
with SpeziesbeschreibungenGrafik;
with TextberechnungenBreiteGrafik;
with ViewsEinstellenGrafik;
with AllgemeineViewsGrafik;
with TextaccessverwaltungssystemErweitertGrafik;

package body LadezeitenGrafik is
   
   procedure Ladezeiten
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      case
        WelcheLadeanzeigeExtern
      is
         when GrafikDatentypen.Generierungszeit_Enum =>
            Text := Spieltexte.Ladezeiten (TextnummernKonstanten.LadezeitSpielwelt);
            
         when GrafikDatentypen.KI_Rechenzeit_Enum =>
            Text := SpeziesbeschreibungenGrafik.Kurzbeschreibung (SpeziesExtern => SpeziesExtern) & " " & Spieltexte.Ladezeiten (TextnummernKonstanten.LadezeitRechnet);
            
         when GrafikDatentypen.Rundenende_Enum =>
            Text := Spieltexte.Ladezeiten (TextnummernKonstanten.LadezeitRundenwechsel);
            
         when GrafikDatentypen.Speichern_Enum =>
            Text := Spieltexte.Ladezeiten (TextnummernKonstanten.Speichern) & " " & LeseGrafiktask.Dateiname;
            
         when GrafikDatentypen.Prüfen_Enum =>
            Text := Spieltexte.Ladezeiten (TextnummernKonstanten.Prüfen) & " " & LeseGrafiktask.Dateiname;
            
         when GrafikDatentypen.Laden_Enum =>
            Text := Spieltexte.Ladezeiten (TextnummernKonstanten.Laden) & " " & LeseGrafiktask.Dateiname;
      end case;
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Text),
                                          HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                          SpielenamenExtern => False);
     
      Viewfläche := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (GrafikRecordKonstanten.Ladebereich.width, GrafikRecordKonstanten.Ladebereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.LadeviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Ladebereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      case
        WelcheLadeanzeigeExtern
      is
         when GrafikDatentypen.Generierungszeit_Enum =>
            Viewfläche.y := SpielweltErstellen (MaximaleTextbreiteExtern => Viewfläche.x);
            
         when GrafikDatentypen.KI_Rechenzeit_Enum =>
            Viewfläche.y := KIRechnet (MaximaleTextbreiteExtern => Viewfläche.x);
            
         when GrafikDatentypen.Rundenende_Enum =>
            Viewfläche.y := Rundenende (MaximaleTextbreiteExtern => Viewfläche.x);
            
         when GrafikDatentypen.Spielstand_Enum'Range =>
            Viewfläche.y := Spielstand (MaximaleTextbreiteExtern => Viewfläche.x,
                                        SpielstandExtern         => WelcheLadeanzeigeExtern);
      end case;
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
   end Ladezeiten;
   
   

   function SpielweltErstellen
     (MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      WelcheZeit := TextaccessVariablen.LadezeitenAccess'First;
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
                     
      SpielweltErstellenSchleife:
      for SpielweltErstellenSchleifenwert in LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range loop
                
         Text := Spieltexte.Ladezeiten (WelcheZeit) & TextKonstantenHTSEB.StandardAbstand & ZahlAlsString (ZahlExtern => LadezeitenLogik.FortschrittKartengenerator (SpielweltErstellenSchleifenwert))
           & TextKonstantenHTSEB.Trennzeichen & MaximalerLadefortschritt;
         
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenMittelnZeichnen (TextExtern               => To_Wide_Wide_String (Source => Text),
                                                                                                    TextpositionExtern       => Textposition,
                                                                                                    MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                    TextAccessExtern         => TextaccessVariablen.LadezeitenAccess (WelcheZeit));
         
         WelcheZeit := WelcheZeit + 1;
         
      end loop SpielweltErstellenSchleife;
      
      return Textposition.y;
                        
   end SpielweltErstellen;
   
   
   
   function KIRechnet
     (MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      WelcheZeit := TextaccessVariablen.KIZeitenAccess'First;
      
      KIRechnetSchleife:
      for KIRechnetSchleifenwert in LadezeitenDatentypen.KI_Rechnet_Enum'Range loop
                  
         Text := Spieltexte.Ladezeiten (WelcheZeit) & TextKonstantenHTSEB.StandardAbstand & ZahlAlsString (ZahlExtern => LadezeitenLogik.FortschrittKI (KIRechnetSchleifenwert))
           & TextKonstantenHTSEB.Trennzeichen & MaximalerLadefortschritt;
         
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenMittelnZeichnen (TextExtern               => To_Wide_Wide_String (Source => Text),
                                                                                                    TextpositionExtern       => Textposition,
                                                                                                    MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                    TextAccessExtern         => TextaccessVariablen.KIZeitenAccess (WelcheZeit));
         
         WelcheZeit := WelcheZeit + 1;
         
      end loop KIRechnetSchleife;
      
      return Textposition.y;
      
   end KIRechnet;
   
   
   
   function Spielstand
     (MaximaleTextbreiteExtern : in Float;
      SpielstandExtern : in GrafikDatentypen.Spielstand_Enum)
      return Float
   is begin
      
      WelcheZeit := TextaccessVariablen.SpielstandzeitAccess'First;
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      
      SpeichernSchleife:
      for SpeichernSchleifenwert in LadezeitenDatentypen.Speichern_Laden_Enum'Range loop
         
         case
           SpielstandExtern
         is
            when GrafikDatentypen.Speichern_Enum =>
               Text := Spieltexte.Ladezeiten (TextnummernKonstanten.Speichern) & " ";
               
            when GrafikDatentypen.Prüfen_Enum =>
               Text := Spieltexte.Ladezeiten (TextnummernKonstanten.Prüfen) & " ";
               
            when GrafikDatentypen.Laden_Enum =>
               Text := Spieltexte.Ladezeiten (TextnummernKonstanten.Laden) & " ";
         end case;
         
         Text := Text & Spieltexte.Ladezeiten (WelcheZeit) & TextKonstantenHTSEB.StandardAbstand & ZahlAlsString (ZahlExtern => LadezeitenLogik.FortschrittSpeichernLaden (SpeichernSchleifenwert))
           & TextKonstantenHTSEB.Trennzeichen & MaximalerLadefortschritt;
         
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenMittelnZeichnen (TextExtern               => To_Wide_Wide_String (Source => Text),
                                                                                                    TextpositionExtern       => Textposition,
                                                                                                    MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                    TextAccessExtern         => TextaccessVariablen.SpielstandzeitAccess (WelcheZeit));
         
         WelcheZeit := WelcheZeit + 1;
         
      end loop SpeichernSchleife;
      
      return Textposition.y;
      
   end Spielstand;
   
   
   
   -- Die beiden Funktionen mal um eine Anzeige erweitern, was genau gerade berechnet wird. äöü
   function Rundenende
     (MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      
      Text := Spieltexte.Ladezeiten (TextnummernKonstanten.LadezeitBerechne) & TextKonstantenHTSEB.StandardAbstand & ZahlAlsString (ZahlExtern => LadezeitenLogik.FortschrittRundenende)
        & TextKonstantenHTSEB.Trennzeichen & MaximalerLadefortschritt;
         
      Textposition.y := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenMittelnZeichnen (TextExtern               => To_Wide_Wide_String (Source => Text),
                                                                                                 TextpositionExtern       => Textposition,
                                                                                                 MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                 TextAccessExtern         => TextaccessVariablen.RundenendeAccess (1));
      
      return Textposition.y;
      
   end Rundenende;

end LadezeitenGrafik;
