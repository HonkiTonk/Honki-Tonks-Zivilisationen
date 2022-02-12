pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with KartenKonstanten;
with SystemDatentypen;

with SchreibeKarten;
with LeseKarten;

with Karten;
with ZufallGeneratorenKarten;
with LadezeitenDatentypen;

package body KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Anfangswert) := Clock;
         
      YAchseUnterwasserSchleife:
      for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + KartenKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            case
              LeseKarten.Grund (PositionExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert))
            is
               when KartenDatentypen.Leer_Grund =>               
                  GrundErzeugen (YXAchsenExtern => (YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
                  
               when others =>
                  null;
            end case;
               
         end loop XAchseUnterwasserSchleife;
      end loop YAchseUnterwasserSchleife;
         
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Endwert) := Clock;
      
   end UnterwasserUnterirdisch;
   
   
   
   procedure GrundErzeugen
     (YXAchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord)
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenDatentypen.Eis
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenDatentypen.Unterwasser_Eis);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenDatentypen.Wasser
      then
         WasserweltErzeugen (YXAchsenExtern => YXAchsenExtern);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenDatentypen.Küstengewässer
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenDatentypen.Unterwasser_Küstengewässer);
                     
      elsif
        LeseKarten.Grund (PositionExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenDatentypen.Gebirge
        or
          LeseKarten.Grund (PositionExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenDatentypen.Hügel
          or
            LeseKarten.Hügel (PositionExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = True
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenDatentypen.Erdgestein);
                  
      elsif
        LeseKarten.Grund (PositionExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenDatentypen.Wüste
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenDatentypen.Sand);
                     
      else
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenDatentypen.Erde);
      end if;
      
   end GrundErzeugen;
   
   
   
   procedure WasserweltErzeugen
     (YXAchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord)
   is begin
      
      GrundSchleife:
      for GrundSchleifenwert in KartenDatentypen.Karten_Unterwasser_Generator_Enum'Range loop
         
         AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                                                                                                   GrundExtern       => GrundSchleifenwert,
                                                                                                   EbeneExtern       => -1);
         
         if
           ZufallGeneratorenKarten.ZufälligerWert <= KartengrundWahrscheinlichkeiten (GrundSchleifenwert, AnzahlGleicherGrund)
         then
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                                  GrundExtern       => GrundSchleifenwert);
               
         else
            null;
         end if;
         
      end loop GrundSchleife;
      
      case
        LeseKarten.Grund (PositionExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse))
      is
         when KartenDatentypen.Leer_Grund =>
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                                  GrundExtern       => KartenDatentypen.Unterwasser_Wasser);
            
         when others =>
            null;
      end case;
      
   end WasserweltErzeugen;
   
   
   
   procedure ErdweltErzeugen
     (YXAchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord)
   is begin
      
      null;
      
   end ErdweltErzeugen;

end KartenGeneratorUnterwasserUnterirdisch;
