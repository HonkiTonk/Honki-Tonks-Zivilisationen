pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

with Karten;
with Eingabe;
with ZufallsgeneratorenSpieleinstellungen;
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
            when RueckgabeDatentypen.Kartengröße_Standard_Enum'Range =>
               Karten.Kartenparameter.Kartengröße := KartengrößeRückgabeZuKarten (KartengrößeAuswahl);

            when RueckgabeDatentypen.Kartengröße_Nutzer_Enum =>
               GrößeSelbstBestimmen (KartengrößeExtern => KartengrößeRückgabeZuKarten (KartengrößeAuswahl));
               
            when RueckgabeDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartengröße := ZufallsgeneratorenSpieleinstellungen.ZufälligeVordefinierteKartengröße;
               
            when RueckgabeDatentypen.Kartengröße_Zufall_Enum =>
               Karten.Kartenparameter.Kartengröße := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartengröße;
               
            when RueckgabeDatentypen.Fertig_Enum =>
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
            when RueckgabeDatentypen.Kartenart_Enum'Range =>
               Karten.Kartenparameter.Kartenart := KartenartRückgabeZuKarten (KartenartAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartenart := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenart;
               
            when RueckgabeDatentypen.Fertig_Enum =>
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
         
         -- case
         --  KartenformAuswahl
         -- is
          --  when KartenDatentypen.Kartenform_Verwendet_Enum'Range =>
          --     Karten.Kartenform := KartenformAuswahl;
               
          --  when RueckgabeDatentypen.Zufall_Enum =>
          --     ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenform;
               
         --   when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
         --   when others =>
          --     Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenformWählen - Ungültige Menüauswahl.");
        -- end case;

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
            when RueckgabeDatentypen.Kartentemperatur_Enum'Range =>
               Karten.Kartenparameter.Kartentemperatur := KartentemperaturRückgabeZuKarten (KartentemperaturAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartentemperatur := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               
            when RueckgabeDatentypen.Fertig_Enum =>
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
            when RueckgabeDatentypen.Kartenressourcen_Enum'Range =>
               Karten.Kartenparameter.Kartenressourcen := KartenressourcenRückgabeZuKarten (KartenressourcenAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartenressourcen := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenressourcenWählen - Ungültige Menüauswahl.");
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpieleinstellungenKarten;
