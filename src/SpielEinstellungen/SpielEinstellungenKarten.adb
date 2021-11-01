pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with KartenDatentypen;
with SystemKonstanten;
with GlobaleTexte;

with Karten;
with Eingabe;
with ZufallGeneratorenSpieleinstellungen;
with AuswahlMenue;

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

            when SystemDatentypen.Karte_Nutzer =>
               return GrößeSelbstBestimmen;
               
            when SystemDatentypen.Karte_Zufall =>
               Karten.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeKartengröße;
               return SystemDatentypen.Auswahl_Kartenart;

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return KartengrößeAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   function GrößeSelbstBestimmen
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
      
      Karten.Kartengrößen (KartengrößeAuswahl).YAchsenGröße := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
      BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                      ZeileExtern         => 25,
                                                      ZahlenMinimumExtern => 20,
                                                      ZahlenMaximumExtern => 1_000);
      
      if
        BenutzerdefinierteGröße = SystemKonstanten.GanzeZahlAbbruchKonstante
      then
         return SystemDatentypen.Auswahl_Kartengröße;
                           
      else
         Karten.Kartengrößen (KartengrößeAuswahl).XAchsenGröße := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
         return SystemDatentypen.Auswahl_Kartenart;
      end if;
      
   end GrößeSelbstBestimmen;



   -- 1 = Inseln, 2 = Kontinente, 3 = Pangäa, 4 = Nur Land, 5 = Chaos
   function KartenartWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Kartenart_Menü);
         
         case
           KartenartAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartenart := KartenartAuswahl;
               return SystemDatentypen.Auswahl_Kartenform;
               
            when 6 =>
               Karten.Kartenart := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenart;
               return SystemDatentypen.Auswahl_Kartenform;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Kartengröße;

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return KartenartAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;

      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   -- 1 = X-Zylinder, 2 = Y-Zylinder, 3 = Torus, 4 = Kugel, 5 = Viereck, 6 = Kugel gedreht, 7 = Tugel, 8 = Tugel gedreht, 9 = Tugel extrem
   function KartenformWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen);
         
         case
           KartenformAuswahl
         is
            when 1 .. 9 =>
               Karten.Kartenform := KartenformAuswahl;
               return SystemDatentypen.Auswahl_Kartentemperatur;
               
            when 10 =>
               Karten.Kartenform := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenform;
               return SystemDatentypen.Auswahl_Kartentemperatur;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Kartenart;

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return KartenformAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;

      end loop KartenformSchleife;
      
   end KartenformWählen;



   -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste
   function KartentemperaturWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen);
                  
         case
           KartentemperaturAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartentemperatur := KartentemperaturAuswahl;
               return SystemDatentypen.Auswahl_Kartenressourcen;
               
            when 6 =>
               Karten.Kartentemperatur := ZufallGeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               return SystemDatentypen.Auswahl_Kartenressourcen;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Kartenform;

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return KartentemperaturAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;
                  
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   -- 1 = Arm, 2 = Wenig, 3 = Mittel, 4 = Viel, 5 = Überfluss
   function KartenressourcenWählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen);
         
         case
           KartenressourcenAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartenressourcen := KartenressourcenAuswahl;
               return SystemDatentypen.Auswahl_Spieleranzahl;
               
            when 6 =>
               Karten.Kartenressourcen := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               return SystemDatentypen.Auswahl_Spieleranzahl;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Kartentemperatur;

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return KartenressourcenAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpielEinstellungenKarten;
