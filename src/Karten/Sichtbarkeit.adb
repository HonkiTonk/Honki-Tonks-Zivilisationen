pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with KartenDatenbank, EinheitenDatenbank, VerbesserungenDatenbank, KartenPruefungen;

package body Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

         case
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).ID
         is
            when 0 =>
               null;
            
            when others =>
               SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert));
         end case;
         
      end loop EinheitenSchleife;

      StädteSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop

         case
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).ID
         is
            when 0 =>
               null;
               
            when others =>
               SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert));
         end case;
         
      end loop StädteSchleife;
      
   end SichtbarkeitsprüfungFürRasse;



   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund
      is
         when 7 =>
            SichtweiteObjekt := 3;

         when 9 =>
            SichtweiteObjekt := 1;
               
         when others =>
            SichtweiteObjekt := 2;
      end case;

      YÄnderungEinheitenSchleife:
      for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop            
         XÄnderungEinheitenSchleife:
         for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
               
            Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);

            case
              Kartenwert.Erfolgreich
            is
               when False =>
                  exit XÄnderungEinheitenSchleife;
                     
               when True =>
                  Karten.Weltkarte (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse).Sichtbar (EinheitRasseNummerExtern.Rasse) := True;
            end case;
            
         end loop XÄnderungEinheitenSchleife;
      end loop YÄnderungEinheitenSchleife;
      
   end SichtbarkeitsprüfungFürEinheit;



   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner < 10
      then
         SichtweiteObjekt := 2;
            
      else
         SichtweiteObjekt := 3;
      end if;

      YÄnderungStadtSchleife:         
      for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop            
         XÄnderungStadtSchleife:
         for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop

            Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
               
            case
              Kartenwert.Erfolgreich
            is
               when False =>
                  exit XÄnderungStadtSchleife;
                     
               when True =>
                  Karten.Weltkarte (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse).Sichtbar (StadtRasseNummerExtern.Rasse) := True;
            end case;
            
         end loop XÄnderungStadtSchleife;
      end loop YÄnderungStadtSchleife;
      
   end SichtbarkeitsprüfungFürStadt;



   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
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
           KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition
           and
             InDerStadtExtern = False
         then
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => 0,
                    RessourceExtern          => 0,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => True,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => 0);
            return;
         
         else
            null;
         end if;
                  
         RassenEinheitenSchleife:
         for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
            EinheitenSchleife:
            for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
               if
                 GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID = 0
               then
                  null;
               
               elsif
                 GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AchsenPosition = KoordinatenExtern
                 and
                   GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).WirdTransportiert = 0
               then
                  Farben (EinheitExtern            => GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID,
                          VerbesserungExtern       => 0,
                          RessourceExtern          => 0,
                          GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                          CursorExtern             => False,
                          EigeneRasseExtern        => RasseExtern,
                          RasseExtern              => RasseSchleifenwert);
                  return;
               
               else
                  null;
               end if;
            
            end loop EinheitenSchleife;
         end loop RassenEinheitenSchleife;

         RassenStädteSchleife:
         for RasseSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
            StädteSchleife:
            for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
               if
                 GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).ID = 0
               then
                  null;

               elsif
                 GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).AchsenPosition = KoordinatenExtern
               then
                  Farben (EinheitExtern            => 0,
                          VerbesserungExtern       => GlobaleDatentypen.KartenVerbesserung (GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).ID),
                          RessourceExtern          => 0,
                          GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                          CursorExtern             => False,
                          EigeneRasseExtern        => RasseExtern,
                          RasseExtern              => RasseSchleifenwert);
                  return;
               
               else
                  null;
               end if;
               
            end loop StädteSchleife;
         end loop RassenStädteSchleife;

         if
           Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet /= 0
         then            
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet,
                    RessourceExtern          => 0,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => 0);
           
         elsif
           Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße /= 0
         then
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße,
                    RessourceExtern          => 0,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => 0);
            
         elsif
           Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource /= 0
         then
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => 0,
                    RessourceExtern          => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => 0);
            
         elsif
           Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss /= 0
         then
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => 0,
                    RessourceExtern          => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => 0);
            
         else
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => 0,
                    RessourceExtern          => 0,
                    GrundExtern              => Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund,
                    CursorExtern             => False,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => 0);
         end if;
         
      else
         if
           KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition
         then         
            Farben (EinheitExtern            => 0,
                    VerbesserungExtern       => 0,
                    RessourceExtern          => 0,
                    GrundExtern              => 0,
                    CursorExtern             => True,
                    EigeneRasseExtern        => RasseExtern,
                    RasseExtern              => 0);
         
         else
            Put (Item => NichtSichtbar);
         end if;
      end if;
      
   end Sichtbarkeit;



   procedure Farben
     (EinheitExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID;
      VerbesserungExtern : in GlobaleDatentypen.KartenVerbesserung;
      RessourceExtern, GrundExtern : in GlobaleDatentypen.KartenGrund;
      CursorExtern : in Boolean;
      EigeneRasseExtern, RasseExtern : in GlobaleDatentypen.RassenMitNullwert)
   is begin
      
      case
        VerbesserungExtern
      is
         when 1 =>
            Put (Item => CSI & "38;2;0;0;0m");
         
         when 2 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 3 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 4 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 5 .. 19 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 20 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 21 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 22 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case
        RessourceExtern
      is
         when 10 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 11 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 12 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 13 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 14 .. 28 =>
            Put (Item => CSI & "38;2;0;0;205m");

         when 29 => 
            Put (Item => CSI & "38;2;255;255;255m");

         when 30 =>
            Put (Item => CSI & "38;2;255;255;255m");

         when 33 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case
        GrundExtern
      is
         when 1 =>
            Put (Item => CSI & "48;2;255;245;238m");
            
         when 2 | 41 =>
            Put (Item => CSI & "48;2;0;0;205m");
            
         when 3 =>
            Put (Item => CSI & "48;2;100;160;60m");
            
         when 4 =>
            Put (Item => CSI & "48;2;205;200;177m");
            
         when 5 =>
            Put (Item => CSI & "48;2;238;238;0m");
            
         when 6 =>
            Put (Item => CSI & "48;2;205;133;63m");
            
         when 7 =>
            Put (Item => CSI & "48;2;120;120;120m");
            
         when 8 =>
            Put (Item => CSI & "48;2;30;130;30m");
            
         when 9 =>
            Put (Item => CSI & "48;2;0;70;0m");
            
         when 31 | 42 =>
            Put (Item => CSI & "48;2;135;206;250m");
            
         when 32 =>
            Put (Item => CSI & "48;2;0;40;0m");

         when 35 =>
            Put (Item => CSI & "48;2;139;69;19m");
            
         when 36 =>
            Put (Item => CSI & "48;2;250;39;39m");
            
         when 37 =>
            Put (Item => CSI & "48;2;236;236;236m");
            
         when 38 =>
            Put (Item => CSI & "48;2;127;127;127m");
            
         when 39 =>
            Put (Item => CSI & "48;2;97;56;11m");
            
         when 40 =>
            Put (Item => CSI & "48;2;87;87;87m");            
            
         when others =>
            null;
      end case;
      
      case
        GrundExtern
      is
         when 1 | 4 | 5 | 31 | 37 | 42 =>
            Put (Item => CSI & "38;2;0;0;0m");
                  
         when others =>
            Put (Item => CSI & "38;2;255;255;255m");
      end case;
      
      if
        CursorExtern = True
      then
         Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (EigeneRasseExtern).CursorGrafik & CSI & "0m");
         
      elsif
        EinheitExtern /= 0
      then
         Put (Item => EinheitenDatenbank.EinheitenListe (EigeneRasseExtern, EinheitExtern).EinheitenGrafik & CSI & "0m");
        
      elsif
        VerbesserungExtern /= 0
      then         
         if
           VerbesserungExtern = 1
           and
             RasseExtern = EigeneRasseExtern
         then            
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (1).VerbesserungGrafik & CSI & "0m");
            
         elsif
           VerbesserungExtern = 2
           and
             RasseExtern = EigeneRasseExtern
         then            
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (2).VerbesserungGrafik & CSI & "0m");
            
         elsif
           VerbesserungExtern = 1
         then
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (3).VerbesserungGrafik & CSI & "0m");
            
         elsif
           VerbesserungExtern = 2
         then
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (4).VerbesserungGrafik & CSI & "0m");
            
         else
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).VerbesserungGrafik & CSI & "0m");
         end if;

      elsif
        RessourceExtern /= 0
      then
         Put (Item => KartenDatenbank.KartenListe (RessourceExtern).KartenGrafik & CSI & "0m");
            
      else
         Put (Item => KartenDatenbank.KartenListe (GrundExtern).KartenGrafik & CSI & "0m");
      end if;
      
   end Farben;

end Sichtbarkeit;
