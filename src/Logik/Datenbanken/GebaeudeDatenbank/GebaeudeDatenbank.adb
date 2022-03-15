pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemKonstanten;

with GebaeudeMenschen;
with GebaeudeKasrodiah;
with GebaeudeLasupin;
with GebaeudeLamustra;
with GebaeudeManuky;
with GebaeudeSuroka;
with GebaeudePryolon;
with GebaeudeTalbidahr;
with GebaeudeMoruPhisihl;
with GebaeudeLarinosLotaris;
with GebaeudeCarupex;
with GebaeudeAlary;
with GebaeudeTesorahn;
with GebaeudeNatriesZermanis;
with GebaeudeTridatus;
with GebaeudeSenelari;
with GebaeudeAspari2;
with GebaeudeEkropa;

package body GebaeudeDatenbank is
   
   procedure StandardGebaeudeDatenbankLaden
   is begin

      RassenSchleife:
      for RasseSchleifenwert in GebäudeListe'Range (1) loop
         GebäudeSchleife:
         for GebäudeSchleifenwert in GebäudeListe'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when SystemKonstanten.MenschenKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMenschen.GebäudeMenschenListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.KasrodiahKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeKasrodiah.GebäudeKasrodiahListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.LasupinKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLasupin.GebäudeLasupinListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.LamustraKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLamustra.GebäudeLamustraListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.ManukyKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeManuky.GebäudeManukyListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.SurokaKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSuroka.GebäudeSurokaListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.PryolonKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudePryolon.GebäudePryolonListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.TalbidahrKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTalbidahr.GebäudeTalbidahrListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.MoruPhisihlKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMoruPhisihl.GebäudeMoruPhisihlListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.LarinosLotarisKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLarinosLotaris.GebäudeLarinosLotarisListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.CarupexKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeCarupex.GebäudeCarupexListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.AlaryKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAlary.GebäudeAlaryListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.TesorahnKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTesorahn.GebäudeTesorahnListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.NatriesZermanisKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeNatriesZermanis.GebäudeNatriesZermanisListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.TridatusKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTridatus.GebäudeTridatusListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.SenelariKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSenelari.GebäudeSenelariListe (GebäudeSchleifenwert);
                  
               when SystemKonstanten.Aspari2Konstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAspari2.GebäudeAspari2Liste (GebäudeSchleifenwert);
                  
               when SystemKonstanten.EkropaKonstante =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeEkropa.GebäudeEkropaListe (GebäudeSchleifenwert);
            end case;
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
   end StandardGebaeudeDatenbankLaden;

end GebaeudeDatenbank;
