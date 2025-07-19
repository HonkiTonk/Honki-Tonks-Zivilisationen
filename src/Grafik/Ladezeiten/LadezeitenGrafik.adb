with TextKonstantenHTSEB;

with Spieltexte;
with Views;
with LadezeitenDatentypen;
with TextnummernKonstanten;

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
            Text := Spieltexte.Ladezeiten (TextnummernKonstanten.LadezeitSpielstand);
            
         when GrafikDatentypen.Laden_Enum =>
            Text := Spieltexte.Ladezeiten (TextnummernKonstanten.LadezeitSpielstand);
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
            
         when GrafikDatentypen.Speichern_Enum =>
            Viewfläche.y := SpeichernLaden (MaximaleTextbreiteExtern => Viewfläche.x);
            
         when GrafikDatentypen.Laden_Enum =>
            Viewfläche.y := SpeichernLaden (MaximaleTextbreiteExtern => Viewfläche.x);
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
                
         Text := Spieltexte.Ladezeiten (WelcheZeit) & TextKonstantenHTSEB.StandardAbstand & ZahlAlsString (ZahlExtern => LadezeitenLogik.FortschrittSpielwelt (SpielweltErstellenSchleifenwert))
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
   
   
   
   function SpeichernLaden
     (MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
         
      Textposition.y := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenMittelnZeichnen (TextExtern               => ZahlAlsString (ZahlExtern => LadezeitenLogik.FortschrittSpeichernLaden)
                                                                                                 & TextKonstantenHTSEB.Trennzeichen & MaximalerLadefortschritt,
                                                                                                 TextpositionExtern       => Textposition,
                                                                                                 MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                 TextAccessExtern         => TextaccessVariablen.SpeichernLadenAccess (1));
      
      return Textposition.y;
      
   end SpeichernLaden;
   
   
   
   -- Die beiden Funktionen mal um eine Anzeige erweitern, was genau gerade berechnet wird. äöü
   function Rundenende
     (MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
         
      Textposition.y := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenMittelnZeichnen (TextExtern               => ZahlAlsString (ZahlExtern => LadezeitenLogik.FortschrittRundenende)
                                                                                                 & TextKonstantenHTSEB.Trennzeichen & MaximalerLadefortschritt,
                                                                                                 TextpositionExtern       => Textposition,
                                                                                                 MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                 TextAccessExtern         => TextaccessVariablen.RundenendeAccess (1));
      
      return Textposition.y;
      
   end Rundenende;

end LadezeitenGrafik;
