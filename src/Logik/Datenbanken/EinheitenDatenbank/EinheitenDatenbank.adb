pragma SPARK_Mode (On);

with SystemKonstanten;

with EinheitenMenschen;
with EinheitenKasrodiah;
with EinheitenLasupin;
with EinheitenLamustra;
with EinheitenManuky;
with EinheitenSuroka;
with EinheitenPryolon;
with EinheitenTalbidahr;
with EinheitenMoruPhisihl;
with EinheitenLarinosLotaris;
with EinheitenCarupex;
with EinheitenAlary;
with EinheitenTesorahn;
with EinheitenNatriesZermanis;
with EinheitenTridatus;
with EinheitenSenelari;
with EinheitenAspari2;
with EinheitenEkropa;

package body EinheitenDatenbank is
   
   procedure StandardEinheitenDatenbankLaden
   is begin
            
      RassenSchleife:
      for RasseSchleifenwert in EinheitenListe'Range (1) loop
         EinheitenSchleife:
         for EinheitenSchleifenwert in EinheitenListe'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when SystemKonstanten.MenschenKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMenschen.EinheitenMenschenListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.KasrodiahKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenKasrodiah.EinheitenKasrodiahListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.LasupinKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLasupin.EinheitenLasupinListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.LamustraKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLamustra.EinheitenLamustraListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.ManukyKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenManuky.EinheitenManukyListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.SurokaKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSuroka.EinheitenSurokaListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.PryolonKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenPryolon.EinheitenPryolonListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.TalbidahrKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTalbidahr.EinheitenTalbidahrListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.MoruPhisihlKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMoruPhisihl.EinheitenMoruPhisihlListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.LarinosLotarisKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLarinosLotaris.EinheitenLarinosLotarisListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.CarupexKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenCarupex.EinheitenCarupexListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.AlaryKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAlary.EinheitenAlaryListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.TesorahnKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTesorahn.EinheitenTesorahnListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.NatriesZermanisKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenNatriesZermanis.EinheitenNatriesZermanisListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.TridatusKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTridatus.EinheitenTridatusListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.SenelariKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSenelari.EinheitenSenelariListe (EinheitenSchleifenwert);
                  
               when SystemKonstanten.Aspari2Konstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAspari2.EinheitenAspari2Liste (EinheitenSchleifenwert);
                  
               when SystemKonstanten.EkropaKonstante =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenEkropa.EinheitenEkropaListe (EinheitenSchleifenwert);
            end case;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end StandardEinheitenDatenbankLaden;
   
end EinheitenDatenbank;
