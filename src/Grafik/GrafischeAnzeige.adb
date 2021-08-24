pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with EinheitSuchen, StadtSuchen, LeseKarten, LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseStadtGebaut, LeseKartenDatenbank, LeseVerbesserungenDatenbank;

package body GrafischeAnzeige is

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen
      -- Über den Kartenressourcen kommen die Kartenverbesserungen
      -- Über die Kartenverbesserungen kommen die Städte
      -- Über die Städte kommen die nicht Transporteinheiten
      -- Über den nicht Transporteinheiten kommen die Transporteinheiten
      -- Über den Transporteinheiten kommt der Cursor      
       
      if
        LeseKarten.Sichtbar (PositionExtern => KoordinatenExtern,
                             RasseExtern    => RasseExtern) = True
      then
         if
           KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
           and
             InDerStadtExtern = False
         then
            Farben (EinheitIDExtern          => 0,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern             => True,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
            return;
         
         else
            null;
         end if;
         
         EinheitStadtRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
         if
           EinheitStadtRasseNummer.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
         then
            null;
            
         elsif
           LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitStadtRasseNummer.Rasse,
                                                                                               LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer))),
                    VerbesserungExtern => GlobaleDatentypen.Leer,
                    RessourceExtern    => GlobaleDatentypen.Leer,
                    GrundExtern        => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern       => False,
                    EigeneRasseExtern  => RasseExtern,
                    RasseExtern        => EinheitStadtRasseNummer.Rasse);
            return;
            
         else
            Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitStadtRasseNummer),
                    VerbesserungExtern => GlobaleDatentypen.Leer,
                    RessourceExtern    => GlobaleDatentypen.Leer,
                    GrundExtern        => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern       => False,
                    EigeneRasseExtern  => RasseExtern,
                    RasseExtern        => EinheitStadtRasseNummer.Rasse);
            return;
         end if;
         
         EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
         if
           EinheitStadtRasseNummer.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
         then
            null;
            
         else
            Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                    VerbesserungExtern       => LeseStadtGebaut.ID (StadtRasseNummerExtern => EinheitStadtRasseNummer),
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => EinheitStadtRasseNummer.Rasse);
            return;
         end if;

         if
           LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
         then            
            Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                    VerbesserungExtern       => LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern),
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
           
         elsif
           LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
         then
            Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                    VerbesserungExtern       => LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern),
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
            
         elsif
           LeseKarten.Ressource (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
         then
            Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => LeseKarten.Ressource (PositionExtern => KoordinatenExtern),
                    GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
            
         elsif
           LeseKarten.Fluss (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
         then
            Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => LeseKarten.Fluss (PositionExtern => KoordinatenExtern),
                    GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
            
         else
            Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
         end if;
         
      else
         if
           KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
         then         
            Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => GlobaleDatentypen.Leer,
                    CursorExtern             => True,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
         
         else
            Put (Item => GlobaleKonstanten.NichtSichtbar);
         end if;
      end if;
      
   end Sichtbarkeit;



   procedure Farben
     (EinheitIDExtern : in GlobaleDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern, GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern, RasseExtern : in GlobaleDatentypen.Rassen_Enum)
   is begin
            
      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Unterwasser_Eis =>
            Put (Item => CSI & "48;2;255;245;238m");
            
         when GlobaleDatentypen.Wasser | GlobaleDatentypen.Unterwasser_Wasser =>
            Put (Item => CSI & "48;2;0;0;205m");
            
         when GlobaleDatentypen.Flachland =>
            Put (Item => CSI & "48;2;100;160;60m");
            
         when GlobaleDatentypen.Tundra =>
            Put (Item => CSI & "48;2;205;200;177m");
            
         when GlobaleDatentypen.Wüste | GlobaleDatentypen.Sand =>
            Put (Item => CSI & "48;2;238;238;0m");
            
         when GlobaleDatentypen.Hügel =>
            Put (Item => CSI & "48;2;205;133;63m");
            
         when GlobaleDatentypen.Gebirge =>
            Put (Item => CSI & "48;2;120;120;120m");
            
         when GlobaleDatentypen.Wald =>
            Put (Item => CSI & "48;2;30;130;30m");
            
         when GlobaleDatentypen.Dschungel =>
            Put (Item => CSI & "48;2;0;70;0m");
            
         when GlobaleDatentypen.Küstengewässer | GlobaleDatentypen.Unterwasser_Küstengewässer =>
            Put (Item => CSI & "48;2;135;206;250m");
            
         when GlobaleDatentypen.Sumpf =>
            Put (Item => CSI & "48;2;0;40;0m");

         when GlobaleDatentypen.Erde =>
            Put (Item => CSI & "48;2;139;69;19m");
            
         when GlobaleDatentypen.Erdgestein =>
            Put (Item => CSI & "48;2;120;120;120m");
            
         when GlobaleDatentypen.Lava =>
            Put (Item => CSI & "48;2;250;39;39m");
            
         when GlobaleDatentypen.Wolken =>
            Put (Item => CSI & "48;2;236;236;236m");
            
         when GlobaleDatentypen.Weltraum =>
            Put (Item => CSI & "48;2;127;127;127m");
            
         when GlobaleDatentypen.Gestein =>
            Put (Item => CSI & "48;2;87;87;87m");   
            
         when GlobaleDatentypen.Planetenkern =>
            Put (Item => CSI & "48;2;205;0;0m");
            
         when GlobaleDatentypen.Unterwasser_Wald =>
            Put (Item => CSI & "48;2;127;255;212m");
            
         when GlobaleDatentypen.Korallen =>
            Put (Item => CSI & "48;2;255;114;86m");
            
         when others =>
            null;
      end case;
      
      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Sand | GlobaleDatentypen.Küstengewässer | GlobaleDatentypen.Wolken | GlobaleDatentypen.Unterwasser_Eis
            | GlobaleDatentypen.Unterwasser_Küstengewässer =>
            if
              RessourceExtern in GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range
              or
                RessourceExtern in GlobaleDatentypen.Karten_Grund_Unterirdischer_Fluss_Enum'Range
            then
               Put (Item => CSI & "38;2;0;0;205m");
               
            elsif
              RessourceExtern in GlobaleDatentypen.Karten_Grund_Lavafluss_Enum'Range
            then
               Put (Item => CSI & "38;2;230;50;50m");
               
            else
               Put (Item => CSI & "38;2;0;0;0m");
            end if;
                  
         when others =>
            if
              RessourceExtern in GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range
              or
                RessourceExtern in GlobaleDatentypen.Karten_Grund_Unterirdischer_Fluss_Enum'Range
            then
               Put (Item => CSI & "38;2;135;206;250m");
               
            elsif
              RessourceExtern in GlobaleDatentypen.Karten_Grund_Lavafluss_Enum'Range
            then
               Put (Item => CSI & "38;2;230;50;50m");
               
            else
               Put (Item => CSI & "38;2;255;255;255m");
            end if;
      end case;
      
      if
        CursorExtern
      then
         Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (EigeneRasseExtern).CursorGrafik & CSI & "0m");
         
      elsif
        EinheitIDExtern > GlobaleDatentypen.EinheitenIDMitNullWert'First
      then
         Put (Item => LeseEinheitenDatenbank.EinheitenGrafik (RasseExtern => EigeneRasseExtern,
                                                              IDExtern    => EinheitIDExtern) & CSI & "0m");
        
      elsif
        VerbesserungExtern in GlobaleDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
        and
          RasseExtern = EigeneRasseExtern
      then            
         Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => VerbesserungExtern) & CSI & "0m");
            
      elsif
        VerbesserungExtern in GlobaleDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
      then
         case
           VerbesserungExtern
         is
            when GlobaleDatentypen.Eigene_Hauptstadt =>
               Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => GlobaleDatentypen.Fremde_Hauptstadt) & CSI & "0m");
               
            when GlobaleDatentypen.Eigene_Stadt =>
               Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => GlobaleDatentypen.Fremde_Stadt) & CSI & "0m");
               
            when others =>
               null;
         end case;
            
      elsif
        VerbesserungExtern /= GlobaleDatentypen.Leer
      then
         Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => VerbesserungExtern) & CSI & "0m");

      elsif
        RessourceExtern /= GlobaleDatentypen.Leer
      then
         Put (Item => LeseKartenDatenbank.KartenGrafik (GrundExtern => RessourceExtern) & CSI & "0m");
            
      else
         Put (Item => LeseKartenDatenbank.KartenGrafik (GrundExtern => GrundExtern) & CSI & "0m");
      end if;
      
   end Farben;

end GrafischeAnzeige;
