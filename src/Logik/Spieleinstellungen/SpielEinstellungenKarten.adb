pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
         
         KartengrößeAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartengröße_Menü_Enum);
         
         case
           KartengrößeAuswahl
         is
            when KartenDatentypen.Kartengröße_Standard_Enum'Range =>
               Karten.Kartenparameter.Kartengröße := KartengrößeAuswahl;
               return SystemDatentypen.Auswahl_Kartenart_Enum;

            when SystemDatentypen.Karte_Größe_Nutzer_Enum =>
               return GrößeSelbstBestimmen (KartengrößeExtern => KartengrößeAuswahl);
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeVordefinierteKartengröße;
               return SystemDatentypen.Auswahl_Kartenart_Enum;
               
            when SystemDatentypen.Karte_Größe_Zufall_Enum =>
               Karten.Kartenparameter.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeKartengröße;
               return SystemDatentypen.Auswahl_Kartenart_Enum;

            when SystemDatentypen.Zurück_Beenden_Enum'Range =>
               return KartengrößeAuswahl;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartengrößeWählen - Ungültige Menüauswahl.");
         end case;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   function GrößeSelbstBestimmen
     (KartengrößeExtern : in KartenDatentypen.Kartengröße_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      -- In eine Schleife umbauen?
      
      BenutzerdefinierteGröße := Eingabe.GanzeZahl (ZeileExtern         => 15,
                                                      ZahlenMinimumExtern => 20,
                                                      ZahlenMaximumExtern => 1_000);
      case
        BenutzerdefinierteGröße.EingabeAbbruch
      is
         when False =>
            return SystemDatentypen.Auswahl_Kartengröße_Enum;
            
         when True =>
            null;
      end case;
      
      Karten.Kartengrößen (KartengrößeExtern).YAchsenGröße := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      BenutzerdefinierteGröße := Eingabe.GanzeZahl (ZeileExtern         => 21,
                                                      ZahlenMinimumExtern => 20,
                                                      ZahlenMaximumExtern => 1_000);
      
      case
        BenutzerdefinierteGröße.EingabeAbbruch
      is
         when False =>
            return SystemDatentypen.Auswahl_Kartengröße_Enum;
            
         when True =>
            Karten.Kartengrößen (KartengrößeExtern).XAchsenGröße := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
            Karten.Kartenparameter.Kartengröße := KartengrößeExtern;
            return SystemDatentypen.Auswahl_Kartenart_Enum;
      end case;
      
   end GrößeSelbstBestimmen;



   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   function KartenartWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenart_Menü_Enum);
         
         case
           KartenartAuswahl
         is
            when KartenDatentypen.Kartenart_Verwendet_Enum'Range =>
               Karten.Kartenparameter.Kartenart := KartenartAuswahl;
               return SystemDatentypen.Auswahl_Kartenform_Enum;
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartenart := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenart;
               return SystemDatentypen.Auswahl_Kartenform_Enum;
               
            when SystemDatentypen.Zurück_Enum =>
               return SystemDatentypen.Auswahl_Kartengröße_Enum;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartenartAuswahl;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenartWählen - Ungültige Menüauswahl.");
         end case;

      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   -- X-Zylinder, Y-Zylinder, Torus, Kugel, Viereck, Kugel gedreht, Tugel, Tugel gedreht, Tugel extrem
   function KartenformWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenform_Menü_Enum);
         
         case
           KartenformAuswahl
         is
            when KartenDatentypen.Kartenform_Verwendet_Enum'Range =>
               Karten.Kartenform := KartenformAuswahl;
               return SystemDatentypen.Auswahl_Kartentemperatur_Enum;
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenform := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenform;
               return SystemDatentypen.Auswahl_Kartentemperatur_Enum;
               
            when SystemDatentypen.Zurück_Enum =>
               return SystemDatentypen.Auswahl_Kartenart_Enum;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartenformAuswahl;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenformWählen - Ungültige Menüauswahl.");
         end case;

      end loop KartenformSchleife;
      
   end KartenformWählen;



   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   function KartentemperaturWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartentemperatur_Menü_Enum);
                  
         case
           KartentemperaturAuswahl
         is
            when KartenDatentypen.Kartentemperatur_Verwendet_Enum'Range =>
               Karten.Kartenparameter.Kartentemperatur := KartentemperaturAuswahl;
               return SystemDatentypen.Auswahl_Kartenressourcen_Enum;
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartentemperatur := ZufallGeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               return SystemDatentypen.Auswahl_Kartenressourcen_Enum;
               
            when SystemDatentypen.Zurück_Enum =>
               return SystemDatentypen.Auswahl_Kartenform_Enum;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartentemperaturAuswahl;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartentemperaturWählen - Ungültige Menüauswahl.");
         end case;
                  
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   -- Arm, Wenig, Mittel, Viel, Überfluss
   function KartenressourcenWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenressourcen_Menü_Enum);
         
         case
           KartenressourcenAuswahl
         is
            when KartenDatentypen.Kartenressourcen_Verwendet_Enum'Range =>
               Karten.Kartenparameter.Kartenressourcen := KartenressourcenAuswahl;
               return SystemDatentypen.Auswahl_Rassen_Enum;
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartenressourcen := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               return SystemDatentypen.Auswahl_Rassen_Enum;
               
            when SystemDatentypen.Zurück_Enum =>
               return SystemDatentypen.Auswahl_Kartentemperatur_Enum;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartenressourcenAuswahl;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenressourcenWählen - Ungültige Menüauswahl.");
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpielEinstellungenKarten;
