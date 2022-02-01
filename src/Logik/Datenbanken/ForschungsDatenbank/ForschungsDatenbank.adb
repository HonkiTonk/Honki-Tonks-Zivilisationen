pragma SPARK_Mode (On);

with SystemKonstanten;

with ForschungMenschen;
with ForschungKasrodiah;
with ForschungLasupin;
with ForschungLamustra;
with ForschungManuky;
with ForschungSuroka;
with ForschungPryolon;
with ForschungTalbidahr;
with ForschungMoruPhisihl;
with ForschungLarinosLotaris;
with ForschungCarupex;
with ForschungAlary;
with ForschungTesorahn;
with ForschungNatriesZermanis;
with ForschungTridatus;
with ForschungSenelari;
with ForschungAspari2;
with ForschungEkropa;

package body ForschungsDatenbank is
   
   procedure StandardForschungsDatenbankLaden
   is begin
            
      RassenSchleife:
      for RasseSchleifenwert in ForschungListe'Range (1) loop
         ForschungsSchleife:
         for ForschungSchleifenwert in ForschungListe'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when SystemKonstanten.MenschenKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMenschen.ForschungMenschenListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.KasrodiahKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungKasrodiah.ForschungKasrodiahListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.LasupinKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLasupin.ForschungLasupinListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.LamustraKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLamustra.ForschungLamustraListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.ManukyKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungManuky.ForschungManukyListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.SurokaKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSuroka.ForschungSurokaListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.PryolonKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungPryolon.ForschungPryolonListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.TalbidahrKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTalbidahr.ForschungTalbidahrListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.MoruPhisihlKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMoruPhisihl.ForschungMoruPhisihlListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.LarinosLotarisKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLarinosLotaris.ForschungLarinosLotarisListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.CarupexKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungCarupex.ForschungCarupexListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.AlaryKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAlary.ForschungAlaryListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.TesorahnKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTesorahn.ForschungTesorahnListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.NatriesZermanisKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungNatriesZermanis.ForschungNatriesZermanisListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.TridatusKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTridatus.ForschungTridatusListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.SenelariKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSenelari.ForschungSenelariListe (ForschungSchleifenwert);
                  
               when SystemKonstanten.Aspari2Konstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAspari2.ForschungAspari2Liste (ForschungSchleifenwert);
                  
               when SystemKonstanten.EkropaKonstante =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungEkropa.ForschungEkropaListe (ForschungSchleifenwert);
            end case;
            
         end loop ForschungsSchleife;
      end loop RassenSchleife;
      
   end StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
