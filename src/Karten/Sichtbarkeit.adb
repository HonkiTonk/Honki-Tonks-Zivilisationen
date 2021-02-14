pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with KartenDatenbank, EinheitenDatenbank, VerbesserungenDatenbank, SchleifenPruefungen;

package body Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      EinheitenPlätzeSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

         case GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID is
            when 0 =>
               exit EinheitenPlätzeSchleife;
            
            when others =>
               SichtbarkeitsprüfungFürEinheit (EinheitRasseNummer => (RasseExtern, EinheitNummer));
         end case;
         
      end loop EinheitenPlätzeSchleife;

      StadtPlätzeSchleife:
      for StadtNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

         case GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID is
            when 0 =>
               exit StadtPlätzeSchleife;
               
            when others =>
               SichtbarkeitsprüfungFürStadt (StadtRasseNummer => (RasseExtern, StadtNummer));
         end case;
         
      end loop StadtPlätzeSchleife;
      
   end SichtbarkeitsprüfungFürRasse;



   procedure SichtbarkeitsprüfungFürEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      case Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse).Grund is
         when 7 =>
            Sichtweite := 3;

         when 9 =>
            Sichtweite := 1;
               
         when others =>
            Sichtweite := 2;
      end case;

      YÄnderungEinheitenSchleife:
      for YÄnderung in -Sichtweite .. Sichtweite loop            
         XÄnderungEinheitenSchleife:
         for XÄnderung in -Sichtweite .. Sichtweite loop
               
            Kartenwert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case Kartenwert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XÄnderungEinheitenSchleife;
                     
               when others =>
                  Karten.Karten (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse).Sichtbar (EinheitRasseNummer.Rasse) := True;
            end case;
            
         end loop XÄnderungEinheitenSchleife;
      end loop YÄnderungEinheitenSchleife;
      
   end SichtbarkeitsprüfungFürEinheit;



   procedure SichtbarkeitsprüfungFürStadt (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner < 10 then
         Sichtweite := 2;
            
      else
         Sichtweite := 3;
      end if;

      YÄnderungStadtSchleife:         
      for YÄnderung in -Sichtweite .. Sichtweite loop            
         XÄnderungStadtSchleife:
         for XÄnderung in -Sichtweite .. Sichtweite loop

            Kartenwert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);
               
            case Kartenwert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XÄnderungStadtSchleife;
                     
               when others =>
                  Karten.Karten (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse).Sichtbar (StadtRasseNummer.Rasse) := True;
            end case;
            
         end loop XÄnderungStadtSchleife;
      end loop YÄnderungStadtSchleife;
      
   end SichtbarkeitsprüfungFürStadt;



   procedure Sichtbarkeit (InDerStadt : Boolean; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord; RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen
      -- Über den Kartenressourcen kommen die Kartenverbesserungen
      -- Über die Kartenverbesserungen kommen die Städte
      -- Über die Städte kommen die Einheiten
      -- Über den Einheiten kommt der Cursor      
       
      if Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Sichtbar (RasseExtern) = True then
         if Koordinaten = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition and InDerStadt = False then
            Farben (Einheit            => 0,
                    Verbesserung       => 0,
                    Ressource          => 0,
                    Grund              => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund,
                    Cursor             => True,
                    RasseExtern        => RasseExtern,
                    RasseIntern        => 0);
            return;
         
         else
            null;
         end if;
                  
         RassenEinheitenPrüfenSchleife:
         for RasseIntern in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
            EinheitenPrüfenSchleife:
            for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
               if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
                  exit EinheitenPrüfenSchleife;
               
               elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AchsenPosition = Koordinaten then
                  Farben (Einheit            => GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID,
                          Verbesserung       => 0,
                          Ressource          => 0,
                          Grund              => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund,
                          Cursor             => False,
                          RasseExtern        => RasseExtern,
                          RasseIntern        => RasseIntern);
                  return;
               
               else
                  null;
               end if;
            
            end loop EinheitenPrüfenSchleife;
         end loop RassenEinheitenPrüfenSchleife;

         RassenStädtePrüfenSchleife:
         for RasseIntern in GlobaleVariablen.StadtGebautArray'Range (1) loop
            StädtePrüfenSchleife:
            for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
               if GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).ID = 0 then
                  exit StädtePrüfenSchleife;

               elsif GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).AchsenPosition = Koordinaten then
                  Farben (Einheit            => 0,
                          Verbesserung       => GlobaleDatentypen.KartenVerbesserung (GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).ID),
                          Ressource          => 0,
                          Grund              => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund,
                          Cursor             => False,
                          RasseExtern        => RasseExtern,
                          RasseIntern        => RasseIntern);
                  return;
               
               else
                  null;
               end if;
               
            end loop StädtePrüfenSchleife;
         end loop RassenStädtePrüfenSchleife;

         if Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungGebiet /= 0 then            
            Farben (Einheit            => 0,
                    Verbesserung       => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungGebiet,
                    Ressource          => 0,
                    Grund              => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund,
                    Cursor             => False,
                    RasseExtern        => RasseExtern,
                    RasseIntern        => 0);
           
         elsif Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße /= 0 then
            Farben (Einheit            => 0,
                    Verbesserung       => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).VerbesserungStraße,
                    Ressource          => 0,
                    Grund              => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund,
                    Cursor             => False,
                    RasseExtern        => RasseExtern,
                    RasseIntern        => 0);
            
         elsif Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Ressource /= 0 then
            Farben (Einheit            => 0,
                    Verbesserung       => 0,
                    Ressource          => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Ressource,
                    Grund              => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund,
                    Cursor             => False,
                    RasseExtern        => RasseExtern,
                    RasseIntern        => 0);
            
         elsif Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Fluss /= 0 then
            Farben (Einheit            => 0,
                    Verbesserung       => 0,
                    Ressource          => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Fluss,
                    Grund              => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund,
                    Cursor             => False,
                    RasseExtern        => RasseExtern,
                    RasseIntern        => 0);
            
         else
            Farben (Einheit            => 0,
                    Verbesserung       => 0,
                    Ressource          => 0,
                    Grund              => Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund,
                    Cursor             => False,
                    RasseExtern        => RasseExtern,
                    RasseIntern        => 0);
         end if;
         
      else
         if Koordinaten = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition then         
            Farben (Einheit            => 0,
                    Verbesserung       => 0,
                    Ressource          => 0,
                    Grund              => 0,
                    Cursor             => True,
                    RasseExtern        => RasseExtern,
                    RasseIntern        => 0);
         
         else
            Put (Item => NichtSichtbar);
         end if;
      end if;
      
   end Sichtbarkeit;



   procedure Farben (Einheit : GlobaleDatentypen.KartenverbesserungEinheitenID; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund;
                     Cursor : in Boolean; RasseExtern, RasseIntern : in GlobaleDatentypen.RassenMitNullwert) is
   begin

      case Cursor is
         when True =>
            case Grund is
               when 1 | 4 | 5 | 31 | 37 =>
                  Put (Item => CSI & "38;2;0;0;0m");
                  
               when others =>
                  Put (Item => CSI & "38;2;255;255;255m");
            end case;
            
         when False =>
            null;
      end case;

      case Einheit is
         when EinheitenDatenbank.EinheitenListe'Range (2) =>
            case Grund is
               when 1 | 4 | 5 | 31 | 37 =>
                  Put (Item => CSI & "38;2;0;0;0m");
                  
               when others =>
                  Put (Item => CSI & "38;2;255;255;255m");
            end case;
            
         when others =>
            null;
      end case;
      
      case Verbesserung is
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
      
      case Ressource is
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
      
      case Grund is
         when 1 =>
            Put (Item => CSI & "48;2;255;245;238m");
            
         when 2 =>
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
            
         when 31 =>
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
      
      if Cursor = True then
         Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");
         
      elsif Einheit /= 0 then
         Put (Item => EinheitenDatenbank.EinheitenListe (RasseExtern, Einheit).EinheitenGrafik & CSI & "0m");
        
      elsif Verbesserung /= 0 then
         if Verbesserung = 1 and RasseIntern = RasseExtern then            
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (1).VerbesserungGrafik & CSI & "0m");
            
         elsif Verbesserung = 2 and RasseIntern = RasseExtern then            
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (2).VerbesserungGrafik & CSI & "0m");
            
         elsif Verbesserung = 1 then
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (3).VerbesserungGrafik & CSI & "0m");
            
         elsif Verbesserung = 2 then
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (4).VerbesserungGrafik & CSI & "0m");
            
         else
            Put (Item => VerbesserungenDatenbank.VerbesserungListe (Verbesserung).VerbesserungGrafik & CSI & "0m");
         end if;

      elsif Ressource /= 0 then
         Put (Item => KartenDatenbank.KartenListe (Ressource).KartenGrafik & CSI & "0m");
            
      else
         Put (Item => KartenDatenbank.KartenListe (Grund).KartenGrafik & CSI & "0m");
      end if;
      
   end Farben;

end Sichtbarkeit;
