pragma SPARK_Mode (On);

with SystemKonstanten;
with GlobaleTexte;

with Karten;
with Eingabe;
with ZufallGeneratorenSpieleinstellungen;
with AuswahlMenue;
with Fehler;

package body SpielEinstellungenKarten is

   function KartengrößeWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartengröße_Menü);
         
         case
           KartengrößeAuswahl
         is
            when KartenDatentypen.Kartengröße_Standard_Enum'Range =>
               Karten.Kartengröße := KartengrößeAuswahl;
               return SystemDatentypen.Auswahl_Kartenart;

            when SystemDatentypen.Karte_Größe_Nutzer =>
               return GrößeSelbstBestimmen (KartengrößeExtern => KartengrößeAuswahl);
               
            when SystemDatentypen.Zufall =>
               Karten.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeVordefinierteKartengröße;
               return SystemDatentypen.Auswahl_Kartenart;
               
            when SystemDatentypen.Karte_Größe_Zufall =>
               Karten.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeKartengröße;
               return SystemDatentypen.Auswahl_Kartenart;

            when SystemDatentypen.Zurück_Beenden_Enum'Range =>
               return KartengrößeAuswahl;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "SpielEinstellungenKarten.KartengrößeWählen - Ungültige Menüauswahl.");
         end case;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   function GrößeSelbstBestimmen
     (KartengrößeExtern : in KartenDatentypen.Kartengröße_Enum)
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                      ZeileExtern         => 19,
                                                      ZahlenMinimumExtern => 20,
                                                      ZahlenMaximumExtern => 1_000);
      if
        BenutzerdefinierteGröße = SystemKonstanten.GanzeZahlAbbruchKonstante
      then
         return SystemDatentypen.Auswahl_Kartengröße;
                     
      else
         null;
      end if;
      
      Karten.Kartengrößen (KartengrößeExtern).YAchsenGröße := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
      BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                      ZeileExtern         => 25,
                                                      ZahlenMinimumExtern => 20,
                                                      ZahlenMaximumExtern => 1_000);
      
      if
        BenutzerdefinierteGröße = SystemKonstanten.GanzeZahlAbbruchKonstante
      then
         return SystemDatentypen.Auswahl_Kartengröße;
                           
      else
         Karten.Kartengrößen (KartengrößeExtern).XAchsenGröße := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
         Karten.Kartengröße := KartengrößeExtern;
         return SystemDatentypen.Auswahl_Kartenart;
      end if;
      
   end GrößeSelbstBestimmen;



   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   function KartenartWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenart_Menü);
         
         case
           KartenartAuswahl
         is
            when KartenDatentypen.Kartenart_Verwendet_Enum'Range =>
               Karten.Kartenart := KartenartAuswahl;
               return SystemDatentypen.Auswahl_Kartenform;
               
            when SystemDatentypen.Zufall =>
               Karten.Kartenart := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenart;
               return SystemDatentypen.Auswahl_Kartenform;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Kartengröße;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartenartAuswahl;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "SpielEinstellungenKarten.KartenartWählen - Ungültige Menüauswahl.");
         end case;

      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel gedreht, Tugel, Tugel gedreht, Tugel extrem
   function KartenformWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenform_Menü);
         
         case
           KartenformAuswahl
         is
            when KartenDatentypen.Kartenform_Verwendet_Enum'Range =>
               Karten.Kartenform := KartenformAuswahl;
               return SystemDatentypen.Auswahl_Kartentemperatur;
               
            when SystemDatentypen.Zufall =>
               Karten.Kartenform := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenform;
               return SystemDatentypen.Auswahl_Kartentemperatur;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Kartenart;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartenformAuswahl;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "SpielEinstellungenKarten.KartenformWählen - Ungültige Menüauswahl.");
         end case;

      end loop KartenformSchleife;
      
   end KartenformWählen;



   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   function KartentemperaturWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartentemperatur_Menü);
                  
         case
           KartentemperaturAuswahl
         is
            when KartenDatentypen.Kartentemperatur_Verwendet_Enum'Range =>
               Karten.Kartentemperatur := KartentemperaturAuswahl;
               return SystemDatentypen.Auswahl_Kartenressourcen;
               
            when SystemDatentypen.Zufall =>
               Karten.Kartentemperatur := ZufallGeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               return SystemDatentypen.Auswahl_Kartenressourcen;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Kartenform;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartentemperaturAuswahl;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "SpielEinstellungenKarten.KartentemperaturWählen - Ungültige Menüauswahl.");
         end case;
                  
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   -- Arm, Wenig, Mittel, Viel, Überfluss
   function KartenressourcenWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenressourcen_Menü);
         
         case
           KartenressourcenAuswahl
         is
            when KartenDatentypen.Kartenressourcen_Verwendet_Enum'Range =>
               Karten.Kartenressourcen := KartenressourcenAuswahl;
               return SystemDatentypen.Auswahl_Rassen;
               
            when SystemDatentypen.Zufall =>
               Karten.Kartenressourcen := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               return SystemDatentypen.Auswahl_Rassen;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Kartentemperatur;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartenressourcenAuswahl;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "SpielEinstellungenKarten.KartenressourcenWählen - Ungültige Menüauswahl.");
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpielEinstellungenKarten;
