pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with Ladezeiten, Karten, KartePositionPruefen, LeseKarten, ZufallGeneratorenKarten, SchreibeKarten;

package body KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, GlobaleDatentypen.Anfangswert) := Clock;
         
      YAchseUnterwasserSchleife:
      for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            case
              LeseKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert))
            is
               when GlobaleDatentypen.Leer =>               
                  if
                    LeseKarten.Grund (PositionExtern => (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert)) = GlobaleDatentypen.Eis
                  then
                     SchreibeKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert),
                                           GrundExtern    => GlobaleDatentypen.Unterwasser_Eis);
                     
                  elsif
                    LeseKarten.Grund (PositionExtern => (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert)) = GlobaleDatentypen.Wasser
                  then
                     WasserweltErzeugen (YPositionExtern => YAchseUnterwasserSchleifenwert,
                                         XPositionExtern => XAchseUnterwasserSchleifenwert);
                     
                  elsif
                    LeseKarten.Grund (PositionExtern => (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert)) = GlobaleDatentypen.Küstengewässer
                  then
                     SchreibeKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert),
                                           GrundExtern    => GlobaleDatentypen.Unterwasser_Küstengewässer);
                     
                  elsif
                    LeseKarten.Grund (PositionExtern => (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert)) = GlobaleDatentypen.Gebirge
                    or
                      LeseKarten.Grund (PositionExtern => (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert)) = GlobaleDatentypen.Hügel
                      or
                        LeseKarten.Hügel (PositionExtern => (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert)) = True
                  then
                     SchreibeKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert),
                                           GrundExtern    => GlobaleDatentypen.Erdgestein);
                  
                  elsif
                    LeseKarten.Grund (PositionExtern => (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert)) = GlobaleDatentypen.Wüste
                  then
                     SchreibeKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert),
                                           GrundExtern    => GlobaleDatentypen.Sand);
                     
                  else
                     SchreibeKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert),
                                           GrundExtern    => GlobaleDatentypen.Erde);
                  end if;
                  
               when others =>
                  null;
            end case;
               
         end loop XAchseUnterwasserSchleife;
      end loop YAchseUnterwasserSchleife;
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, GlobaleDatentypen.Endwert) := Clock;
      
   end UnterwasserUnterirdisch;
   
   
   
   procedure WasserweltErzeugen
     (YPositionExtern, XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      GrundSchleife:
      for GrundSchleifenwert in GlobaleDatentypen.Karten_Unterwasser_Generator_Enum'Range loop
         
         AnzahlGleicherGrund := 0;
         
         YAchseSchleife:
         for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XAchsenSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (-1, YPositionExtern, XPositionExtern),
                                                                           ÄnderungExtern    => (0, YAchseSchleifenwert, XAchsenSchleifenwert));
               
               if
                 KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  null;
                  
               elsif
                 LeseKarten.Grund (PositionExtern => KartenWert) = GrundSchleifenwert
               then
                  AnzahlGleicherGrund := AnzahlGleicherGrund + 1;
                  
               else
                  null;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
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
     (YPositionExtern, XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      null;
      
   end ErdweltErzeugen;

end KartenGeneratorUnterwasserUnterirdisch;
