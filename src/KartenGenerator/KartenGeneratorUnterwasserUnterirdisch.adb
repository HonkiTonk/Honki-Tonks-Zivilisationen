pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with KartenKonstanten;
with SystemDatentypen;

with SchreibeKarten;
with LeseKarten;

with Ladezeiten;
with Karten;
with ZufallGeneratorenKarten;

package body KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Anfangswert) := Clock;
         
      YAchseUnterwasserSchleife:
      for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + KartenKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            case
              LeseKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert))
            is
               when KartenDatentypen.Leer =>               
                  GrundErzeugen (YPositionExtern => YAchseUnterwasserSchleifenwert,
                                 XPositionExtern => XAchseUnterwasserSchleifenwert);
                  
               when others =>
                  null;
            end case;
               
         end loop XAchseUnterwasserSchleife;
      end loop YAchseUnterwasserSchleife;
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Endwert) := Clock;
      
   end UnterwasserUnterirdisch;
   
   
   
   procedure GrundErzeugen
     (YPositionExtern : in KartenDatentypen.KartenfeldPositiv;
      XPositionExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = KartenDatentypen.Eis
      then
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => KartenDatentypen.Unterwasser_Eis);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = KartenDatentypen.Wasser
      then
         WasserweltErzeugen (YPositionExtern => YPositionExtern,
                             XPositionExtern => XPositionExtern);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = KartenDatentypen.Küstengewässer
      then
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => KartenDatentypen.Unterwasser_Küstengewässer);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = KartenDatentypen.Gebirge
        or
          LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = KartenDatentypen.Hügel
          or
            LeseKarten.Hügel (PositionExtern => (0, YPositionExtern, XPositionExtern)) = True
      then
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => KartenDatentypen.Erdgestein);
                  
      elsif
        LeseKarten.Grund (PositionExtern => (0, YPositionExtern, XPositionExtern)) = KartenDatentypen.Wüste
      then
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => KartenDatentypen.Sand);
                     
      else
         SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                               GrundExtern    => KartenDatentypen.Erde);
      end if;
      
   end GrundErzeugen;
   
   
   
   procedure WasserweltErzeugen
     (YPositionExtern : in KartenDatentypen.KartenfeldPositiv;
      XPositionExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      GrundSchleife:
      for GrundSchleifenwert in KartenDatentypen.Karten_Unterwasser_Generator_Enum'Range loop
         
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
         when KartenDatentypen.Leer =>
            SchreibeKarten.Grund (PositionExtern => (-1, YPositionExtern, XPositionExtern),
                                  GrundExtern    => KartenDatentypen.Unterwasser_Wasser);
            
         when others =>
            null;
      end case;
      
   end WasserweltErzeugen;
   
   
   
   procedure ErdweltErzeugen
     (YPositionExtern : in KartenDatentypen.KartenfeldPositiv;
      XPositionExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      null;
      
   end ErdweltErzeugen;

end KartenGeneratorUnterwasserUnterirdisch;
