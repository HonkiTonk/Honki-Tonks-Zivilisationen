pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemKonstanten;
with KartenEinstellungenKonstanten;

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
               return SystemKonstanten.AuswahlKartenartKonstante;

            when KartenEinstellungenKonstanten.KartengrößeNutzerKonstante =>
               return GrößeSelbstBestimmen (KartengrößeExtern => KartengrößeAuswahl);
               
            when SystemKonstanten.ZufallKonstante =>
               Karten.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeVordefinierteKartengröße;
               return SystemKonstanten.AuswahlKartenartKonstante;
               
            when KartenEinstellungenKonstanten.KartengrößeZufallKonstante =>
               Karten.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeKartengröße;
               return SystemKonstanten.AuswahlKartenartKonstante;

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
            return SystemKonstanten.AuswahlKartengrößeKonstante;
            
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
            return SystemKonstanten.AuswahlKartengrößeKonstante;
            
         when True =>
            Karten.Kartengrößen (KartengrößeExtern).XAchsenGröße := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
            Karten.Kartengröße := KartengrößeExtern;
            return SystemKonstanten.AuswahlKartenartKonstante;
      end case;
      
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
               return SystemKonstanten.AuswahlKartenformKonstante;
               
            when SystemKonstanten.ZufallKonstante =>
               Karten.Kartenart := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenart;
               return SystemKonstanten.AuswahlKartenformKonstante;
               
            when SystemKonstanten.ZurückKonstante =>
               return SystemKonstanten.AuswahlKartengrößeKonstante;

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

         KartenformAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenform_Menü);
         
         case
           KartenformAuswahl
         is
            when KartenDatentypen.Kartenform_Verwendet_Enum'Range =>
               Karten.Kartenform := KartenformAuswahl;
               return SystemKonstanten.AuswahlKartentemperaturKonstante;
               
            when SystemKonstanten.ZufallKonstante =>
               Karten.Kartenform := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenform;
               return SystemKonstanten.AuswahlKartentemperaturKonstante;
               
            when SystemKonstanten.ZurückKonstante =>
               return SystemKonstanten.AuswahlKartenartKonstante;

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

         KartentemperaturAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartentemperatur_Menü);
                  
         case
           KartentemperaturAuswahl
         is
            when KartenDatentypen.Kartentemperatur_Verwendet_Enum'Range =>
               Karten.Kartentemperatur := KartentemperaturAuswahl;
               return SystemKonstanten.AuswahlKartenressourcenKonstante;
               
            when SystemKonstanten.ZufallKonstante =>
               Karten.Kartentemperatur := ZufallGeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               return SystemKonstanten.AuswahlKartenressourcenKonstante;
               
            when SystemKonstanten.ZurückKonstante =>
               return SystemKonstanten.AuswahlKartenformKonstante;

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

         KartenressourcenAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenressourcen_Menü);
         
         case
           KartenressourcenAuswahl
         is
            when KartenDatentypen.Kartenressourcen_Verwendet_Enum'Range =>
               Karten.Kartenressourcen := KartenressourcenAuswahl;
               return SystemKonstanten.AuswahlRassenKonstante;
               
            when SystemKonstanten.ZufallKonstante =>
               Karten.Kartenressourcen := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               return SystemKonstanten.AuswahlRassenKonstante;
               
            when SystemKonstanten.ZurückKonstante =>
               return SystemKonstanten.AuswahlKartentemperaturKonstante;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return KartenressourcenAuswahl;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenressourcenWählen - Ungültige Menüauswahl.");
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpielEinstellungenKarten;
