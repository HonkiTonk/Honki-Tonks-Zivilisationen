pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;
with KartenRecordKonstanten;

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
      for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            case
              LeseKarten.Grund (KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert))
            is
               when KartenGrundKonstanten.LeerGrund =>               
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
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundKonstanten.EisKonstante
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenDatentypen.Unterwasser_Eis);
                     
      elsif
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundKonstanten.WasserKonstante
      then
         WasserweltErzeugen (YXAchsenExtern => YXAchsenExtern);
                     
      elsif
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundKonstanten.KüstengewässerKonstante
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenDatentypen.Unterwasser_Küstengewässer);
                     
      elsif
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundKonstanten.GebirgeKonstante
        or
          LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundKonstanten.HügelKonstante
          or
            LeseKarten.Hügel (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = True
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenGrundKonstanten.ErdgesteinKonstante);
                  
      elsif
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundKonstanten.WüsteKonstante
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenGrundKonstanten.SandKonstante);
                     
      else
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenGrundKonstanten.ErdeKonstante);
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
        LeseKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse))
      is
         when KartenGrundKonstanten.LeerGrund =>
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                                  GrundExtern       => KartenGrundKonstanten.UnterwasserWasserKonstante);
            
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
