pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with Ladezeiten, Karten, KartePositionPruefen, KartenAllgemein, ZufallGeneratorenKarten;

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
              Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund
            is
               when GlobaleDatentypen.Leer =>               
                  if
                    Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund = GlobaleDatentypen.Eis
                  then
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Unterwasser_Eis;
                     
                  elsif
                    Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund = GlobaleDatentypen.Wasser
                  then
                     WasserweltErzeugen (YPositionExtern => YAchseUnterwasserSchleifenwert,
                                         XPositionExtern => XAchseUnterwasserSchleifenwert);
                     
                  elsif
                    Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund = GlobaleDatentypen.Küstengewässer
                  then
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Unterwasser_Küstengewässer;
                     
                  elsif
                    Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund = GlobaleDatentypen.Gebirge
                    or
                      Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund = GlobaleDatentypen.Hügel
                    or
                      Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Hügel = True
                  then
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Erdgestein;
                  
                  elsif
                    Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund = GlobaleDatentypen.Wüste
                  then
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Sand;
                     
                  else
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := GlobaleDatentypen.Erde;
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
                 KartenAllgemein.FeldGrund (PositionExtern => KartenWert) = GrundSchleifenwert
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
            Karten.Weltkarte (-1, YPositionExtern, XPositionExtern).Grund := GrundSchleifenwert;
               
         else
            null;
         end if;    
         
      end loop GrundSchleife;
      
      case
        Karten.Weltkarte (-1, YPositionExtern, XPositionExtern).Grund
      is
         when GlobaleDatentypen.Leer =>
            Karten.Weltkarte (-1, YPositionExtern, XPositionExtern).Grund := GlobaleDatentypen.Unterwasser_Wasser;
            
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
