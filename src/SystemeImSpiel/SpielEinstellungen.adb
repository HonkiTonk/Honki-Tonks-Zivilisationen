pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;

with GlobaleKonstanten;

with ImSpiel, KartenGenerator, Eingabe, Auswahl, Anzeige, ZufallGeneratorenKarten, Ladezeiten, KartenPruefungen, EinheitSuchen, ZufallGeneratorenSpieleinstellungen, EinheitenAllgemein;

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
               HauptAuswahl := KartentemperaturWählen;
               
            when 4 =>
               HauptAuswahl := SpieleranzahlWählen;

            when 5 =>
               HauptAuswahl := MenschlicheSpieleranzahl;

            when 6 =>
               HauptAuswahl := SchwierigkeitsgradFestlegen;
               
            when 7 =>
               exit AuswahlSchleife;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return HauptAuswahl;

            when others =>
               null;
         end case;

      end loop AuswahlSchleife;

      KartenGenerator.KartenGenerator;
      
      Ladezeiten.SpielweltErstellenZeit (12, 1) := Clock;
      StartwerteErmitteln;
      Ladezeiten.SpielweltErstellenZeit (12, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 12);

      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 1);
         
      return ImSpiel.ImSpiel;
              
   end SpielEinstellungen;



   function KartengrößeWählen
     return Integer
   is begin
      
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                                                  TextDateiExtern   => GlobaleDatentypen.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 1,
                                                  ErsteZeileExtern  => 1,
                                                  LetzteZeileExtern => 13);
         
         case
           KartengrößeAuswahl
         is
            when 1 .. 9 =>
               Karten.Kartengröße := KartengrößeAuswahl;
               return 2;

            when 10 =>
               Karten.Kartengröße := KartengrößeAuswahl;
               BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Fragen,
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
               
               Karten.Kartengrößen (KartengrößeAuswahl).YAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
               BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Fragen,
                                                               ZeileExtern         => 25,
                                                               ZahlenMinimumExtern => 20,
                                                               ZahlenMaximumExtern => 1_000);
                     
               if
                 BenutzerdefinierteGröße = GlobaleKonstanten.GanzeZahlAbbruchKonstante
               then
                  return 1;
                           
               else
                  Karten.Kartengrößen (KartengrößeAuswahl).XAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
                  Karten.Kartengrößen (KartengrößeAuswahl).Ressourcenmenge := Integer (Karten.Kartengrößen (KartengrößeAuswahl).YAchsenGröße) * Integer (Karten.Kartengrößen (KartengrößeAuswahl).XAchsenGröße) / 32;
                  return 2;
               end if;
               
            when 11 =>               
               Karten.Kartengröße := ZufallGeneratorenSpieleinstellungen.Spieleinstellungen (WelcheEinstellungExtern => 1);
               return 2;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartengrößeAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;



   function KartenartWählen
     return Integer
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                                              TextDateiExtern   => GlobaleDatentypen.Spiel_Einstellungen,
                                              FrageZeileExtern  => 2,
                                              ErsteZeileExtern  => 14,
                                              LetzteZeileExtern=> 22);
                  
         case
           KartenartAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartenart := KartenartAuswahl;
               return 3;
               
            when 6 =>               
               Karten.Kartenart := ZufallGeneratorenSpieleinstellungen.Spieleinstellungen (WelcheEinstellungExtern => 2);
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



   function KartentemperaturWählen
     return Integer
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                                                     TextDateiExtern   => GlobaleDatentypen.Spiel_Einstellungen,
                                                     FrageZeileExtern  => 3,
                                                     ErsteZeileExtern  => 23,
                                                     LetzteZeileExtern => 31);
                  
         case
           KartentemperaturAuswahl
         is
            when 1 .. 5 =>
               Karten.Kartentemperatur := KartentemperaturAuswahl;
               return 4;
               
            when 6 =>               
               Karten.Kartentemperatur := ZufallGeneratorenSpieleinstellungen.Spieleinstellungen (WelcheEinstellungExtern => 3);
               return 4;
               
            when -2 =>
               return 2;

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

         SpieleranzahlAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                                                  TextDateiExtern   => GlobaleDatentypen.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 4,
                                                  ErsteZeileExtern  => 32,
                                                  LetzteZeileExtern => 53);
         
         case
           SpieleranzahlAuswahl
         is
            when 1 .. 18 =>
               SpielerAnzahl := SpieleranzahlAuswahl;
               return 5;

            when 19 =>               
               SpielerAnzahl := ZufallGeneratorenSpieleinstellungen.Spieleinstellungen (WelcheEinstellungExtern => 4);
               return 5;
               
            when -2 =>
               return 3;

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
      
      GlobaleVariablen.RassenImSpiel := (others => 0);
      Spieler := 0;

      SpielerSchleife:
      while Spieler < SpielerAnzahl loop
         
         SpielerartAuswahl := RasseWählen;
         case
           SpielerartAuswahl
         is                  
            when -2 =>
               return 4;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SpielerartAuswahl;
               
            when others =>
               null;
         end case;
         
         case
           GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen (SpielerartAuswahl))
         is
            when 0 =>
               JaOderNein := Auswahl.AuswahlJaNein (FrageZeileExtern => 21);
         
               if
                 JaOderNein = GlobaleKonstanten.JaKonstante
               then
                  GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.RassenMitNullwert (SpielerartAuswahl)) := 1;
                  Spieler := Spieler + 1;
                     
               else
                  GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.RassenMitNullwert (SpielerartAuswahl)) := 2;
                  Spieler := Spieler + 1;
               end if;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpielerSchleife;

      return 6;

   end MenschlicheSpieleranzahl;


   
   function RasseWählen -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
     return Integer
   is begin

      RasseSchleife:
      loop
         
         RassenAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                                           TextDateiExtern   => GlobaleDatentypen.Spiel_Einstellungen,
                                           FrageZeileExtern  => 5,
                                           ErsteZeileExtern  => 54,
                                           LetzteZeileExtern => 75);

         case
           RassenAuswahl
         is
            when 1 .. 18 =>
               Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Spiel_Einstellungen,
                                             TextDateiExtern        => GlobaleDatentypen.Rassen_Beschreibung_Lang,
                                             ÜberschriftZeileExtern => RassenAuswahl + 53,
                                             ErsteZeileExtern       => RassenAuswahl,
                                             LetzteZeileExtern      => RassenAuswahl,
                                             AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                             AbstandEndeExtern      => GlobaleDatentypen.Keiner);
               Get_Immediate (Taste);
               JaOderNein := Auswahl.AuswahlJaNein (FrageZeileExtern => 6);
               
               if
                 JaOderNein = GlobaleKonstanten.JaKonstante
               then
                  return RassenAuswahl;
                     
               else
                  null;
               end if;

            when 19 =>               
               Zufallswahl := ZufallGeneratorenSpieleinstellungen.Spieleinstellungen (WelcheEinstellungExtern => 5);
               return Zufallswahl;

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
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
        
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when 0 =>
               null;
               
            when others =>
               SicherheitsTestWert := 0;
         
               StartwerteFestlegenSchleife:
               loop
                  
                  Koordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallGeneratorenKarten.YXPosition;

                  PrüfungEinheit := UmgebungPrüfen (YPositionExtern   => GezogeneWerte.YAchse,
                                                      XPositionExtern   => GezogeneWerte.XAchse,
                                                      RasseExtern       => RasseSchleifenwert);

                  case
                    PrüfungEinheit
                  is
                     when True =>
                        exit StartwerteFestlegenSchleife;
                        
                     when False =>
                        SicherheitsTestWert := SicherheitsTestWert + 1;
                  end case;

                  case
                    SicherheitsTestWert
                  is
                     when 10_000 =>
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                              TextZeileExtern => 16);
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Rassen_Beschreibung_Kurz,
                                                              TextZeileExtern => Positive (RasseSchleifenwert));
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                              TextZeileExtern => 17);
                        GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := 0;
                        exit StartwerteFestlegenSchleife;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
               
         end case;
         
      end loop SpieleranzahlWerteFestlegen;
      
   end StartwerteErmitteln;



   function UmgebungPrüfen
     (YPositionExtern, XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv;
      RasseExtern : in GlobaleDatentypen.Rassen) 
      return Boolean
   is begin
      
      PrüfungGrund := KartenPruefungen.KartenGrund (KoordinatenExtern => (0, YPositionExtern, XPositionExtern));

      case
        PrüfungGrund
      is
         when False =>
            return False;
            
         when True =>
            PositionWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => (0, YPositionExtern, XPositionExtern));
      end case;

      case
        PositionWert.Platznummer
      is
         when 0 =>
            Koordinaten (1) := (0, YPositionExtern, XPositionExtern);
            YAchseSchleife:
            for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               XAchseSchleife:
               for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

                  KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YPositionExtern, XPositionExtern),
                                                                          ÄnderungExtern       => (0, YÄnderung, XÄnderung),
                                                                          ZusatzYAbstandExtern => 0);
                  case
                    KartenWert.YAchse
                  is
                     when 0 =>
                        exit XAchseSchleife;
                  
                     when others =>
                        null;
                  end case;
                  
                  if
                    YÄnderung /= 0
                    or
                      XÄnderung /= 0
                  then
                     PrüfungGrund := KartenPruefungen.KartenGrund (KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

                     case
                       PrüfungGrund
                     is
                        when False =>
                           PlatzBelegt := (1, 1);
            
                        when True =>
                           PlatzBelegt := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
                     end case;                    
                           
                     case
                       PlatzBelegt.Platznummer
                     is
                        when 0 =>
                           Koordinaten (2) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse);
                           StartpunktFestlegen (RasseExtern => RasseExtern);
                           return True;
                                 
                        when others =>
                           null;
                     end case;
                                             
                  else
                     null;
                  end if;

               end loop XAchseSchleife;
            end loop YAchseSchleife;
                           
         when others =>
            null;
      end case;
         
      return False;
      
   end UmgebungPrüfen;



   procedure StartpunktFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin

      GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).ID := 1;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition.EAchse := Koordinaten (1).EAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition.YAchse := Koordinaten (1).YAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition.XAchse := Koordinaten (1).XAchse;
      EinheitenAllgemein.LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummerExtern => (RasseExtern, 1));

      GlobaleVariablen.EinheitenGebaut (RasseExtern, 2).ID := 2;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 2).AchsenPosition.EAchse := Koordinaten (2).EAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 2).AchsenPosition.YAchse := Koordinaten (2).YAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 2).AchsenPosition.XAchse := Koordinaten (2).XAchse;
      EinheitenAllgemein.LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummerExtern => (RasseExtern, 2));
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition;
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt := GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition;
      
   end StartpunktFestlegen;



   function SchwierigkeitsgradFestlegen
     return Integer
   is begin
      
      SpieleranzahlSchleife:
      loop

         SchwierigkeitAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                                                  TextDateiExtern   => GlobaleDatentypen.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 26,
                                                  ErsteZeileExtern  => 76,
                                                  LetzteZeileExtern => 82);
         
         case
           SchwierigkeitAuswahl
         is
            when 1 .. 3 =>
               GlobaleVariablen.Schwierigkeitsgrad := SchwierigkeitAuswahl;
               return 7;

            when 4 =>
               GlobaleVariablen.Schwierigkeitsgrad := ZufallGeneratorenSpieleinstellungen.Spieleinstellungen (WelcheEinstellungExtern => 6);
               return 7;
               
            when -2 =>
               return 5;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SchwierigkeitAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungen;
