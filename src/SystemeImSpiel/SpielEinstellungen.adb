pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;

with GlobaleKonstanten, GlobaleTexte;

with ImSpiel, KartenGenerator, Eingabe, Auswahl, Anzeige, ZufallGeneratorenKarten, Ladezeiten, KartePositionPruefen, EinheitSuchen, ZufallGeneratorenSpieleinstellungen, EinheitenAllgemein, BewegungPassierbarkeitPruefen,
     KartenAllgemein;

package body SpielEinstellungen is

   function SpielEinstellungen
     return Integer
   is begin

      HauptAuswahl := 1;

      AuswahlSchleife:
      loop

         case
           HauptAuswahl
         is
            when 1 =>
               HauptAuswahl := KartengrößeWählen;

            when 2 =>
               HauptAuswahl := KartenartWählen;
               
            when 3 =>
               HauptAuswahl := KartenformWählen;

            when 4 =>            
               HauptAuswahl := KartentemperaturWählen;
               
            when 5 =>
               HauptAuswahl := SpieleranzahlWählen;

            when 6 =>
               HauptAuswahl := MenschlicheSpieleranzahl;

            when 7 =>
               HauptAuswahl := SchwierigkeitsgradFestlegen;
               
            when 8 =>
               exit AuswahlSchleife;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return HauptAuswahl;

            when others =>
               null;
         end case;

      end loop AuswahlSchleife;

      KartenGenerator.KartenGenerator;
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Spieler_Platzieren, GlobaleDatentypen.Anfangswert) := Clock;
      StartwerteErmitteln;
      RassenVorhanden := False;
      
      SicherheitsSchleife:
      for RassenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when GlobaleDatentypen.Spieler_Mensch | GlobaleDatentypen.Spieler_KI =>
               RassenVorhanden := True;
               exit SicherheitsSchleife;
         end case;
         
      end loop SicherheitsSchleife;
      
      case
        RassenVorhanden
      is
         when True =>
            null;
            
         when False =>
            Put_Line ("SpielEinstellungen.SpielEinstellungen es wurden keine Rassen platziert!");
            return GlobaleKonstanten.SpielBeendenKonstante;
      end case;               
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Spieler_Platzieren, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Spieler_Platzieren);

      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Gesamtzeit);
         
      return ImSpiel.ImSpiel;
              
   end SpielEinstellungen;



   function KartengrößeWählen
     return Integer
   is begin
      
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 1,
                                                  ErsteZeileExtern  => 1,
                                                  LetzteZeileExtern => 13);
         
         case
           KartengrößeAuswahl
         is
            when 1 .. 9 =>
               Karten.Kartengröße := GlobaleDatentypen.Kartengröße_Verwendet_Enum'Val (KartengrößeAuswahl);
               return 2;

            when 10 =>
               Karten.Kartengröße := GlobaleDatentypen.Kartengröße_Verwendet_Enum'Val (KartengrößeAuswahl);
               BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                               ZeileExtern         => 19,
                                                               ZahlenMinimumExtern => 20,
                                                               ZahlenMaximumExtern => 1_000);
               if
                 BenutzerdefinierteGröße = GlobaleKonstanten.GanzeZahlAbbruchKonstante
               then
                  return 1;
                     
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
                  return 1;
                           
               else
                  Karten.Kartengrößen (GlobaleDatentypen.Kartengröße_Verwendet_Enum'Val (KartengrößeAuswahl)).XAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
                  return 2;
               end if;
               
            when 11 =>               
               Karten.Kartengröße := ZufallGeneratorenSpieleinstellungen.ZufälligeKartengröße;
               return 2;

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

         KartenartAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                                              TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                              FrageZeileExtern  => 2,
                                              ErsteZeileExtern  => 14,
                                              LetzteZeileExtern=> 22);
         
         case
           KartenartAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartenart := GlobaleDatentypen.Kartenart_Verwendet_Enum'Val (KartenartAuswahl);
               return 3;
               
            when 6 =>               
               Karten.Kartenart := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenart;
               return 3;
               
            when -2 =>
               return 1;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartenartAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");

      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   -- 1 = X-Zylinder, 2 = Y-Zylinder, 3 = Torus, 4 = Kugel, 5 = Viereck, 6 = Kugel gedreht, 7 = Tugel
   function KartenformWählen
     return Integer
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                                               TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                               FrageZeileExtern  => 31,
                                               ErsteZeileExtern  => 83,
                                               LetzteZeileExtern=> 94);
         
         case
           KartenformAuswahl
         is
            when 1 .. 9 =>
               Karten.Kartenform := GlobaleDatentypen.Kartenform_Verwendet_Enum'Val (KartenformAuswahl);
               return 4;
               
            when 10 =>
               Karten.Kartenform := ZufallGeneratorenSpieleinstellungen.ZufälligeKartenform;
               return 4;
               
            when -2 =>
               return 2;

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

         KartentemperaturAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                                                     TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                     FrageZeileExtern  => 3,
                                                     ErsteZeileExtern  => 23,
                                                     LetzteZeileExtern => 31);
                  
         case
           KartentemperaturAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartentemperatur := GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Val (KartentemperaturAuswahl);
               return 5;
               
            when 6 =>               
               Karten.Kartentemperatur := ZufallGeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               return 5;
               
            when -2 =>
               return 3;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartentemperaturAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;



   function SpieleranzahlWählen
     return Integer
   is begin
      
      SpieleranzahlSchleife:
      loop

         SpieleranzahlAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 4,
                                                  ErsteZeileExtern  => 32,
                                                  LetzteZeileExtern => 53);
         
         case
           SpieleranzahlAuswahl
         is
            when 1 .. 18 =>
               SpielerAnzahl := SpieleranzahlAuswahl;
               return 6;

            when 19 =>               
               SpielerAnzahl := ZufallGeneratorenSpieleinstellungen.ZufälligeSpieleranzahl;
               return 6;
               
            when -2 =>
               return 4;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SpieleranzahlAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SpieleranzahlWählen;



   function MenschlicheSpieleranzahl
     return Integer
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => GlobaleDatentypen.Leer);
      Spieler := 0;

      SpielerSchleife:
      while Spieler < SpielerAnzahl loop
         
         SpielerartAuswahl := RasseWählen;
         case
           SpielerartAuswahl
         is                  
            when -2 =>
               return 5;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SpielerartAuswahl;
               
            when others =>
               null;
         end case;
         
         case
           GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl))
         is
            when GlobaleDatentypen.Leer =>
               if
                 Auswahl.AuswahlJaNein (FrageZeileExtern => 21) = GlobaleKonstanten.JaKonstante
               then
                  GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl)) := GlobaleDatentypen.Spieler_Mensch;
                  Spieler := Spieler + 1;
                     
               else
                  GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl)) := GlobaleDatentypen.Spieler_KI;
                  Spieler := Spieler + 1;
               end if;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpielerSchleife;

      return 7;

   end MenschlicheSpieleranzahl;


   
   function RasseWählen
     return Integer
   is begin

      RasseSchleife:
      loop
         
         RassenAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                                           TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                           FrageZeileExtern  => 5,
                                           ErsteZeileExtern  => 54,
                                           LetzteZeileExtern => 75);

         case
           RassenAuswahl
         is
            when 1 .. 18 =>
               if
                 GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (RassenAuswahl)) = GlobaleDatentypen.Leer
               then
                  Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Spiel_Einstellungen,
                                                TextDateiExtern        => GlobaleTexte.Rassen_Beschreibung_Lang,
                                                ÜberschriftZeileExtern => RassenAuswahl + 53,
                                                ErsteZeileExtern       => RassenAuswahl,
                                                AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Leer);
                  Eingabe.WartenEingabe;
               
                  case
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 6)
                  is
                     when GlobaleKonstanten.JaKonstante =>
                        return RassenAuswahl;
                     
                     when others =>
                        null;
                  end case;
                  
               else               
                  case
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 32)
                  is
                     when GlobaleKonstanten.JaKonstante =>
                        GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (RassenAuswahl)) := GlobaleDatentypen.Leer;
                        Spieler := Spieler - 1;
                        return RassenAuswahl;
                     
                     when others =>
                        null;
                  end case;
               end if;

            when 19 =>
               return GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (ZufallGeneratorenSpieleinstellungen.ZufälligeRasse);

            when -2 .. 0 =>
               return RassenAuswahl;
               
            when others =>
               null;
         end case;               

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop RasseSchleife;
      
   end RasseWählen;



   procedure StartwerteErmitteln
   is begin
      
      SpieleranzahlWerteFestlegen:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
        
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               SicherheitsTestWert := 0;
         
               StartwerteFestlegenSchleife:
               loop
                  
                  StartKoordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallGeneratorenKarten.StartPosition (RasseSchleifenwert);

                  exit StartwerteFestlegenSchleife when UmgebungPrüfen (PositionExtern => GezogeneWerte,
                                                                         RasseExtern    => RasseSchleifenwert);
                  
                  SicherheitsTestWert := SicherheitsTestWert + 1;

                  case
                    SicherheitsTestWert
                  is
                     when GlobaleDatentypen.KartenfeldPositivMitNullwert'Last =>
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                              TextZeileExtern => 16);
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Rassen_Beschreibung_Kurz,
                                                              TextZeileExtern => GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert));
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                              TextZeileExtern => 17);
                        GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := GlobaleDatentypen.Leer;
                        exit StartwerteFestlegenSchleife;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
               
         end case;
         
      end loop SpieleranzahlWerteFestlegen;
      
   end StartwerteErmitteln;



   function UmgebungPrüfen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        KartenAllgemein.FeldGrund (PositionExtern => PositionExtern)
      is
         when GlobaleDatentypen.Lava | GlobaleDatentypen.Eis =>
            return False;
            
         when others =>
            null;
      end case;

      case
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => PositionExtern).Platznummer
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            StartKoordinaten (1) := PositionExtern;
            YAchseSchleife:
            for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               XAchseSchleife:
               for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

                  KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => PositionExtern,
                                                                              ÄnderungExtern       => (0, YÄnderung, XÄnderung));
            
                  if
                    KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
                  then
                     null;
                     
                  elsif
                    BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                           IDExtern           => 2,
                                                                           NeuePositionExtern => KartenWert) = False
                    or
                      Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = GlobaleDatentypen.Lava
                    or
                      Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = GlobaleDatentypen.Eis
                  then
                     null;
                     
                  elsif
                    YÄnderung = 0
                    and
                      XÄnderung = 0
                  then
                     null;
                     
                  else                           
                     case
                       EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer
                     is
                        when GlobaleKonstanten.LeerEinheitStadtNummer =>
                           StartKoordinaten (2) := KartenWert;
                           StartpunktFestlegen (RasseExtern => RasseExtern);
                           return True;
                                 
                        when others =>
                           null;
                     end case;
                  end if;

               end loop XAchseSchleife;
            end loop YAchseSchleife;
                           
         when others =>
            null;
      end case;
         
      return False;
      
   end UmgebungPrüfen;



   procedure StartpunktFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin

      EinheitenAllgemein.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (1),
                                          EinheitNummerExtern    => 1,
                                          IDExtern               => 1,
                                          StadtRasseNummerExtern => (RasseExtern, 0));
      
      EinheitenAllgemein.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (2),
                                          EinheitNummerExtern    => 2,
                                          IDExtern               => 2,
                                          StadtRasseNummerExtern => (RasseExtern, 0));
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).Position;
      GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt := GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).Position;
      
   end StartpunktFestlegen;



   function SchwierigkeitsgradFestlegen
     return Integer
   is begin
      
      SpieleranzahlSchleife:
      loop

         SchwierigkeitAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 26,
                                                  ErsteZeileExtern  => 76,
                                                  LetzteZeileExtern => 82);
         
         case
           SchwierigkeitAuswahl
         is
            when 1 .. 3 =>
               GlobaleVariablen.Schwierigkeitsgrad := GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Val (SchwierigkeitAuswahl);
               return 8;

            when 4 =>
               GlobaleVariablen.Schwierigkeitsgrad := ZufallGeneratorenSpieleinstellungen.ZufälligerSchwiewrigkeitsgrad;
               return 8;
               
            when -2 =>
               return 6;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SchwierigkeitAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungen;
