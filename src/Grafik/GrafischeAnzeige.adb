pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with KartenDatenbank, EinheitenDatenbank, VerbesserungenDatenbank;

with EinheitSuchen, StadtSuchen;

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
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern) = True
      then
         if
           KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
           and
             InDerStadtExtern = False
         then
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
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
           GlobaleVariablen.EinheitenGebaut (EinheitStadtRasseNummer.Rasse, EinheitStadtRasseNummer.Platznummer).WirdTransportiert /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            Farben (EinheitExtern            => GlobaleVariablen.EinheitenGebaut (EinheitStadtRasseNummer.Rasse,
                    GlobaleVariablen.EinheitenGebaut (EinheitStadtRasseNummer.Rasse, EinheitStadtRasseNummer.Platznummer).WirdTransportiert).ID,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => EinheitStadtRasseNummer.Rasse);
            return;
            
         else
            Farben (EinheitExtern            => GlobaleVariablen.EinheitenGebaut (EinheitStadtRasseNummer.Rasse, EinheitStadtRasseNummer.Platznummer).ID,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => EinheitStadtRasseNummer.Rasse);
            return;
         end if;
         
         EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
         if
           EinheitStadtRasseNummer.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
         then
            null;
            
         else
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => GlobaleVariablen.StadtGebaut (EinheitStadtRasseNummer.Rasse, EinheitStadtRasseNummer.Platznummer).ID,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => EinheitStadtRasseNummer.Rasse);
            return;
         end if;

         if
           Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
         then            
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
           
         elsif
           Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungWeg /= GlobaleDatentypen.Leer
         then
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungWeg,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
            
         elsif
           Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource /= GlobaleDatentypen.Leer
         then
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
            
         elsif
           Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss /= GlobaleDatentypen.Leer
         then
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
            
         else
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => GlobaleDatentypen.Leer,
                    RessourceExtern          => GlobaleDatentypen.Leer,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => GlobaleDatentypen.Leer);
         end if;
         
      else
         if
           KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
         then         
            Farben (EinheitExtern            => 0,
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
     (EinheitExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID;
      VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern, GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern, RasseExtern : in GlobaleDatentypen.Rassen_Enum)
   is begin
      
      case
        VerbesserungExtern
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Put (Item => CSI & "38;2;0;0;0m");
      end case;
      
      case
        RessourceExtern
      is
         when GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range =>
            Put (Item => CSI & "38;2;0;0;205m");

         when GlobaleDatentypen.Karten_Grund_Ressourcen_Wasser => 
            Put (Item => CSI & "38;2;255;255;255m");
            
         when others =>
            null;
      end case;
      
      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis =>
            Put (Item => CSI & "48;2;255;245;238m");
            
         when GlobaleDatentypen.Wasser | GlobaleDatentypen.Unter_Wasser =>
            Put (Item => CSI & "48;2;0;0;205m");
            
         when GlobaleDatentypen.Flachland =>
            Put (Item => CSI & "48;2;100;160;60m");
            
         when GlobaleDatentypen.Tundra =>
            Put (Item => CSI & "48;2;205;200;177m");
            
         when GlobaleDatentypen.Wüste =>
            Put (Item => CSI & "48;2;238;238;0m");
            
         when GlobaleDatentypen.Hügel =>
            Put (Item => CSI & "48;2;205;133;63m");
            
         when GlobaleDatentypen.Gebirge =>
            Put (Item => CSI & "48;2;120;120;120m");
            
         when GlobaleDatentypen.Wald =>
            Put (Item => CSI & "48;2;30;130;30m");
            
         when GlobaleDatentypen.Dschungel =>
            Put (Item => CSI & "48;2;0;70;0m");
            
         when GlobaleDatentypen.Küstengewässer | GlobaleDatentypen.Unter_Küstengewässer =>
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
            
         when others =>
            null;
      end case;
      
      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Küstengewässer | GlobaleDatentypen.Wolken | GlobaleDatentypen.Unter_Küstengewässer =>
            if
              RessourceExtern in GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range
            then
               Put (Item => CSI & "38;2;0;0;205m");
               
            else
               Put (Item => CSI & "38;2;0;0;0m");
            end if;
                  
         when others =>
            if
              RessourceExtern in GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range
            then
               Put (Item => CSI & "38;2;135;206;250m");
               
            else
               Put (Item => CSI & "38;2;255;255;255m");
            end if;
      end case;
      
      if
        CursorExtern
      then
         Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (EigeneRasseExtern).CursorGrafik & CSI & "0m");
         
      elsif
        EinheitExtern /= 0
      then
         Put (Item => EinheitenDatenbank.EinheitenListe (EigeneRasseExtern, EinheitExtern).EinheitenGrafik & CSI & "0m");
        
      elsif
        VerbesserungExtern in GlobaleDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
        and
          RasseExtern = EigeneRasseExtern
      then            
         Put (Item => VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).VerbesserungGrafik & CSI & "0m");
            
      elsif
        VerbesserungExtern in GlobaleDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
      then
         case
           VerbesserungExtern
         is
            when GlobaleDatentypen.Eigene_Hauptstadt =>
               Put (Item => VerbesserungenDatenbank.VerbesserungListe (GlobaleDatentypen.Fremde_Hauptstadt).VerbesserungGrafik & CSI & "0m");
               
            when GlobaleDatentypen.Eigene_Stadt =>
               Put (Item => VerbesserungenDatenbank.VerbesserungListe (GlobaleDatentypen.Fremde_Stadt).VerbesserungGrafik & CSI & "0m");
               
            when others =>
               null;
         end case;
            
      elsif
        VerbesserungExtern /= GlobaleDatentypen.Leer
        and
          VerbesserungExtern not in GlobaleDatentypen.Karten_Verbesserung_Städte_Enum'Range
      then
         Put (Item => VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).VerbesserungGrafik & CSI & "0m");

      elsif
        RessourceExtern /= GlobaleDatentypen.Leer
      then
         Put (Item => KartenDatenbank.KartenListe (RessourceExtern).KartenGrafik & CSI & "0m");
            
      else
         Put (Item => KartenDatenbank.KartenListe (GrundExtern).KartenGrafik & CSI & "0m");
      end if;
      
   end Farben;


end GrafischeAnzeige;
