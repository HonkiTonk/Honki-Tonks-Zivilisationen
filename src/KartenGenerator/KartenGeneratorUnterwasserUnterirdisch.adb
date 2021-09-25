pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen, KartenKonstanten;
use GlobaleDatentypen;

with SchreibeKarten;
with LeseKarten;

with Ladezeiten, Karten, ZufallGeneratorenKarten;

package body KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, GlobaleDatentypen.Anfangswert) := Clock;
         
      YAchseUnterwasserSchleife:
      for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + KartenKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            case
              LeseKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert))
            is
               when GlobaleDatentypen.Leer =>               
                  GrundErzeugen (YPositionExtern => YAchseUnterwasserSchleifenwert,
                                 XPositionExtern => XAchseUnterwasserSchleifenwert);
                  
               when others =>
                  null;
            end case;
               
         end loop XAchseUnterwasserSchleife;
      end loop YAchseUnterwasserSchleife;
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, GlobaleDatentypen.Endwert) := Clock;
      
   end UnterwasserUnterirdisch;
   
   
   
   procedure GrundErzeugen
     (YPositionExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = GlobaleDatentypen.Eis
      then
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => GlobaleDatentypen.Unterwasser_Eis);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = GlobaleDatentypen.Wasser
      then
         WasserweltErzeugen (YPositionExtern => YPositionExtern,
                             XPositionExtern => XPositionExtern);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = GlobaleDatentypen.Küstengewässer
      then
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => GlobaleDatentypen.Unterwasser_Küstengewässer);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = GlobaleDatentypen.Gebirge
        or
          LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = GlobaleDatentypen.Hügel
          or
            LeseKarten.Hügel (PositionExtern => (0, YPositionExtern, XPositionExtern)) = True
      then
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => GlobaleDatentypen.Erdgestein);
                  
      elsif
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = GlobaleDatentypen.Wüste
      then
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => GlobaleDatentypen.Sand);
                     
      else
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => GlobaleDatentypen.Erde);
      end if;
      
   end GrundErzeugen;
   
   
   
   procedure WasserweltErzeugen
     (YPositionExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      GrundSchleife:
      for GrundSchleifenwert in GlobaleDatentypen.Karten_Unterwasser_Generator_Enum'Range loop
         
         AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                                                                                                   GrundExtern    => GrundSchleifenwert,
                                                                                                   EbeneExtern    => -1);
         
         if
           ZufallGeneratorenKarten.ZufälligerWert <= KartengrundWahrscheinlichkeiten (GrundSchleifenwert, AnzahlGleicherGrund)
         then
            SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                                  GrundExtern    => GrundSchleifenwert);
               
         else
            null;
         end if;
         
      end loop GrundSchleife;
      
      case
        LeseKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern))
      is
         when GlobaleDatentypen.Leer =>
            SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                                  GrundExtern    => GlobaleDatentypen.Unterwasser_Wasser);
            
         when others =>
            null;
      end case;
      
   end WasserweltErzeugen;
   
   
   
   procedure ErdweltErzeugen
     (YPositionExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      null;
      
   end ErdweltErzeugen;

end KartenGeneratorUnterwasserUnterirdisch;
