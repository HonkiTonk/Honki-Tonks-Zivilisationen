pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen;
use GlobaleDatentypen;

with Ladezeiten, Karten;

package body KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch is
   begin
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 8) := Clock;
         
      YAchseUnterwasserSchleife:
      for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            case
              Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund
            is
               when 1 =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund;
                     
               when 2 =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := 41;
                     
               when 31 =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := 42;
                     
               when 7 =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := 40;
                     
               when others =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := 35;
            end case;

            case
              Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource
            is
               when 10 .. 13 | 29 .. 30 | 33 =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource;
                       
               when others =>
                  null;
            end case;

            case
              Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss
            is
               when 0 =>
                  null;
                     
               when others =>
                  Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss;
            end case;
               
         end loop XAchseUnterwasserSchleife;
      end loop YAchseUnterwasserSchleife;
         
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 8) := Clock;
      
   end UnterwasserUnterirdisch;

end KartenGeneratorUnterwasserUnterirdisch;
