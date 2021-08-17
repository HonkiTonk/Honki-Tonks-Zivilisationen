pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleTexte, GlobaleKonstanten;

with Auswahl, ZufallGeneratorenSpieleinstellungen, Anzeige, Eingabe, ZufallGeneratorenKarten, EinheitenAllgemein, EinheitSuchen, KartePositionPruefen, BewegungPassierbarkeitPruefen, LeseKarten;

package body SpielEinstellungenRasseSpieler is

   function SpieleranzahlWählen
     return Integer
   is begin
      
      SpieleranzahlSchleife:
      loop

         SpieleranzahlAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 35,
                                                  ErsteZeileExtern  => 36,
                                                  LetzteZeileExtern => 40);
         
         case
           SpieleranzahlAuswahl
         is
            when 1 =>
               SpielerAnzahl := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                   ZeileExtern         => 1,
                                                   ZahlenMinimumExtern => 1,
                                                   ZahlenMaximumExtern => 18);
               if
                 SpielerAnzahl in 1 .. 18
               then
                  return GlobaleKonstanten.AuswahlBelegung;
                  
               else
                  null;
               end if;

            when 2 =>               
               SpielerAnzahl := ZufallGeneratorenSpieleinstellungen.ZufälligeSpieleranzahl;
               return GlobaleKonstanten.AuswahlBelegung;
               
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlKartenressourcen;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SpieleranzahlAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SpieleranzahlWählen;



   function SpielerbelegungWählen
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
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlSpieleranzahl;

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

      return GlobaleKonstanten.AuswahlSchwierigkeitsgrad;

   end SpielerbelegungWählen;


   
   function RasseWählen
     return Integer
   is begin

      RasseSchleife:
      loop
         
         RassenAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                           TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                           FrageZeileExtern  => 41,
                                           ErsteZeileExtern  => 42,
                                           LetzteZeileExtern => 63);

         case
           RassenAuswahl
         is
            when 1 .. 18 =>
               if
                 GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (RassenAuswahl)) = GlobaleDatentypen.Leer
               then
                  Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Spiel_Einstellungen,
                                                TextDateiExtern        => GlobaleTexte.Rassen_Beschreibung_Lang,
                                                ÜberschriftZeileExtern => RassenAuswahl + 41,
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

            when GlobaleKonstanten.ZurückKonstante | GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
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
        LeseKarten.Grund (PositionExtern => PositionExtern)
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
                      LeseKarten.Grund (PositionExtern => KartenWert) = GlobaleDatentypen.Lava
                    or
                      LeseKarten.Grund (PositionExtern => KartenWert) = GlobaleDatentypen.Eis
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

end SpielEinstellungenRasseSpieler;
