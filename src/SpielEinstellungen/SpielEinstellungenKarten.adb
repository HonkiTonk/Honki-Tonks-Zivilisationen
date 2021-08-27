pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten, GlobaleDatentypen, GlobaleTexte;

with Auswahl, Karten, Eingabe, ZufallGeneratorenSpieleinstellungen;

package body SpielEinstellungenKarten is

   function KartengrößeWählen
     return Integer
   is begin
      
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 1,
                                                  ErsteZeileExtern  => 2,
                                                  LetzteZeileExtern => 14);
         
         case
           KartengrößeAuswahl
         is
            when 1 .. 9 =>
               Karten.Kartengröße := GlobaleDatentypen.Kartengröße_Verwendet_Enum'Val (KartengrößeAuswahl);
               return GlobaleKonstanten.AuswahlKartenart;

            when 10 =>
               Karten.Kartengröße := GlobaleDatentypen.Kartengröße_Verwendet_Enum'Val (KartengrößeAuswahl);
               BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                               ZeileExtern         => 19,
                                                               ZahlenMinimumExtern => 20,
                                                               ZahlenMaximumExtern => 1_000);
               if
                 BenutzerdefinierteGröße = GlobaleKonstanten.GanzeZahlAbbruchKonstante
               then
                  return GlobaleKonstanten.AuswahlKartengröße;
                     
               else
                  null;
               end if;
               
               Karten.Kartengrößen (GlobaleDatentypen.Kartengröße_Verwendet_Enum'Val (KartengrößeAuswahl)).YAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
               BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                               ZeileExtern         => 25,
                                                               ZahlenMinimumExtern => 20,
                                                               ZahlenMaximumExtern => 1_000);
                     
               if
                 BenutzerdefinierteGröße = GlobaleKonstanten.GanzeZahlAbbruchKonstante
               then
                  return GlobaleKonstanten.AuswahlKartengröße;
                           
               else
                  Karten.Kartengrößen (GlobaleDatentypen.Kartengröße_Verwendet_Enum'Val (KartengrößeAuswahl)).XAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
                  return GlobaleKonstanten.AuswahlKartenart;
               end if;
               
            when 11 =>               
               Karten.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeKartengröße;
               return GlobaleKonstanten.AuswahlKartenart;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartengrößeAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;



   -- 1 = Inseln, 2 = Kontinente, 3 = Pangäa, 4 = Nur Land, 5 = Chaos
   function KartenartWählen
     return Integer
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                              TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                              FrageZeileExtern  => 15,
                                              ErsteZeileExtern  => 16,
                                              LetzteZeileExtern=> 24);
         
         case
           KartenartAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartenart := GlobaleDatentypen.Kartenart_Verwendet_Enum'Val (KartenartAuswahl);
               return GlobaleKonstanten.AuswahlKartenform;
               
            when 6 =>               
               Karten.Kartenart := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenart;
               return GlobaleKonstanten.AuswahlKartenform;
               
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlKartengröße;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartenartAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");

      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   -- 1 = X-Zylinder, 2 = Y-Zylinder, 3 = Torus, 4 = Kugel, 5 = Viereck, 6 = Kugel gedreht, 7 = Tugel, 8 = Tugel gedreht, 9 = Tugel extrem
   function KartenformWählen
     return Integer
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                               TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                               FrageZeileExtern  => 72,
                                               ErsteZeileExtern  => 73,
                                               LetzteZeileExtern => 84);
         
         case
           KartenformAuswahl
         is
            when 1 .. 9 =>
               Karten.Kartenform := GlobaleDatentypen.Kartenform_Verwendet_Enum'Val (KartenformAuswahl);
               return GlobaleKonstanten.AuswahlKartentemperatur;
               
            when 10 =>
               Karten.Kartenform := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenform;
               return GlobaleKonstanten.AuswahlKartentemperatur;
               
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlKartenart;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartenformAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");                  

      end loop KartenformSchleife;
      
   end KartenformWählen;



   -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste
   function KartentemperaturWählen
     return Integer
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                                     TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                     FrageZeileExtern  => 25,
                                                     ErsteZeileExtern  => 26,
                                                     LetzteZeileExtern => 34);
                  
         case
           KartentemperaturAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartentemperatur := GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Val (KartentemperaturAuswahl);
               return GlobaleKonstanten.AuswahlKartenressourcen;
               
            when 6 =>               
               Karten.Kartentemperatur := ZufallGeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               return GlobaleKonstanten.AuswahlKartenressourcen;
               
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlKartenform;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartentemperaturAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   -- 1 = Arm, 2 = Wenig, 3 = Mittel, 4 = Viel, 5 = Überfluss
   function KartenressourcenWählen
     return Integer
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                                     TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                     FrageZeileExtern  => 85,
                                                     ErsteZeileExtern  => 86,
                                                     LetzteZeileExtern => 93);
                  
         case
           KartenressourcenAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartenressourcen := GlobaleDatentypen.Karten_Ressourcen_Reichtum_Verwendet_Enum'Val (KartenressourcenAuswahl);
               return GlobaleKonstanten.AuswahlSpieleranzahl;
               
            when 6 =>               
               Karten.Kartenressourcen := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               return GlobaleKonstanten.AuswahlSpieleranzahl;
               
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlKartentemperatur;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartenressourcenAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpielEinstellungenKarten;
