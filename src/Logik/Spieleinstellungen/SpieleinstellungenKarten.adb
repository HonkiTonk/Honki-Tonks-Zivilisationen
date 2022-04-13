pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Karten;
with Eingabe;
with ZufallGeneratorenSpieleinstellungen;
with AuswahlMenues;
with Fehler;

package body SpieleinstellungenKarten is

   ----------------------- Bei Zufall auch zurück?
   procedure KartengrößeWählen
   is begin
      
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Kartengröße_Menü_Enum);
         
         case
           KartengrößeAuswahl
         is
            when KartenDatentypen.Kartengröße_Standard_Enum'Range =>
               Karten.Kartenparameter.Kartengröße := KartengrößeAuswahl;

            when SystemDatentypen.Karte_Größe_Nutzer_Enum =>
               GrößeSelbstBestimmen (KartengrößeExtern => KartengrößeAuswahl);
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeVordefinierteKartengröße;
               
            when SystemDatentypen.Karte_Größe_Zufall_Enum =>
               Karten.Kartenparameter.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeKartengröße;
               
            when SystemDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartengrößeWählen - Ungültige Menüauswahl.");
         end case;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   procedure GrößeSelbstBestimmen
     (KartengrößeExtern : in KartenDatentypen.Kartengröße_Enum)
   is begin
      
      -- In eine Schleife umbauen?
      
      BenutzerdefinierteGröße := Eingabe.GanzeZahl (ZeileExtern         => 15,
                                                      ZahlenMinimumExtern => 20,
                                                      ZahlenMaximumExtern => 1_000);
      case
        BenutzerdefinierteGröße.EingabeAbbruch
      is
         when False =>
            return;
            
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
            null;
            
         when True =>
            Karten.Kartengrößen (KartengrößeExtern).XAchsenGröße := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
            Karten.Kartenparameter.Kartengröße := KartengrößeExtern;
      end case;
      
   end GrößeSelbstBestimmen;



   -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
   procedure KartenartWählen
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Kartenart_Menü_Enum);
         
         case
           KartenartAuswahl
         is
            when KartenDatentypen.Kartenart_Verwendet_Enum'Range =>
               Karten.Kartenparameter.Kartenart := KartenartAuswahl;
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartenart := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenart;
               
            when SystemDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenartWählen - Ungültige Menüauswahl.");
         end case;

      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   procedure KartenformWählen
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Kartenform_Menü_Enum);
         
         case
           KartenformAuswahl
         is
            when KartenDatentypen.Kartenform_Verwendet_Enum'Range =>
               Karten.Kartenform := KartenformAuswahl;
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenform := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenform;
               
            when SystemDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenformWählen - Ungültige Menüauswahl.");
         end case;

      end loop KartenformSchleife;
      
   end KartenformWählen;



   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   procedure KartentemperaturWählen
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Kartentemperatur_Menü_Enum);
                  
         case
           KartentemperaturAuswahl
         is
            when KartenDatentypen.Kartentemperatur_Verwendet_Enum'Range =>
               Karten.Kartenparameter.Kartentemperatur := KartentemperaturAuswahl;
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartentemperatur := ZufallGeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               
            when SystemDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartentemperaturWählen - Ungültige Menüauswahl.");
         end case;
         
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   -- Arm, Wenig, Mittel, Viel, Überfluss
   procedure KartenressourcenWählen
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Kartenressourcen_Menü_Enum);
         
         case
           KartenressourcenAuswahl
         is
            when KartenDatentypen.Kartenressourcen_Verwendet_Enum'Range =>
               Karten.Kartenparameter.Kartenressourcen := KartenressourcenAuswahl;
               
            when SystemDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartenressourcen := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               
            when SystemDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenressourcenWählen - Ungültige Menüauswahl.");
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpieleinstellungenKarten;
