pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenDatentypen; use KartenDatentypen;
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
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
         
      YAchseUnterwasserSchleife:
      for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            case
              LeseKarten.Grund (KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert))
            is
               when KartenGrundDatentypen.Leer_Grund_Enum =>               
                  GrundErzeugen (YXAchsenExtern => (YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
                  
               when others =>
                  null;
            end case;
               
         end loop XAchseUnterwasserSchleife;
      end loop YAchseUnterwasserSchleife;
         
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end UnterwasserUnterirdisch;
   
   
   
   procedure GrundErzeugen
     (YXAchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord)
   is begin
      
      if
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundDatentypen.Eis_Enum
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenGrundDatentypen.Unterwasser_Eis_Enum);
                     
      elsif
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundDatentypen.Wasser_Enum
      then
         WasserweltErzeugen (YXAchsenExtern => YXAchsenExtern);
                     
      elsif
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundDatentypen.Küstengewässer_Enum
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenGrundDatentypen.Unterwasser_Küstengewässer_Enum);
                     
      elsif
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundDatentypen.Gebirge_Enum
        or
          LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundDatentypen.Hügel_Enum
          or
            LeseKarten.Hügel (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = True
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenGrundDatentypen.Erdgestein_Enum);
                  
      elsif
        LeseKarten.Grund (KoordinatenExtern => (0, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse)) = KartenGrundDatentypen.Wüste_Enum
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenGrundDatentypen.Sand_Enum);
                     
      else
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                               GrundExtern       => KartenGrundDatentypen.Erde_Enum);
      end if;
      
   end GrundErzeugen;
   
   
   
   procedure WasserweltErzeugen
     (YXAchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord)
   is begin
      
      GrundSchleife:
      for GrundSchleifenwert in KartenGrundDatentypen.Karten_Unterwasser_Generator_Enum'Range loop
         
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
         when KartenGrundDatentypen.Leer_Grund_Enum =>
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YXAchsenExtern.YAchse, YXAchsenExtern.XAchse),
                                  GrundExtern       => KartenGrundDatentypen.Unterwasser_Wasser_Enum);
            
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
