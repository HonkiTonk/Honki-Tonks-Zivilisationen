pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen;
use GlobaleDatentypen;

with Ladezeiten, Karten;

package body KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (9, 1) := Clock;
         
      YAchseUnterwasserSchleife:
      for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            case
              Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund
            is
               when GlobaleDatentypen.Eis =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund;
                     
               when GlobaleDatentypen.Wasser =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Unter_Wasser;
                     
               when GlobaleDatentypen.Küstengewässer =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Unter_Küstengewässer;
                     
               when GlobaleDatentypen.Gebirge =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Gestein;
                     
               when others =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Erde;
            end case;

            case
              Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource
            is
               when GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource;
                       
               when others =>
                  null;
            end case;

            case
              Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss
            is
               when GlobaleDatentypen.Leer =>
                  null;
                     
               when others =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss;
            end case;
               
         end loop XAchseUnterwasserSchleife;
      end loop YAchseUnterwasserSchleife;
         
      Ladezeiten.SpielweltErstellenZeit (9, 2) := Clock;
      
   end UnterwasserUnterirdisch;

end KartenGeneratorUnterwasserUnterirdisch;
