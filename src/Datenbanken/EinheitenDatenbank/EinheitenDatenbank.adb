pragma SPARK_Mode (On);

with EinheitenMenschen, EinheitenKasrodiah, EinheitenLasupin, EinheitenLamustra, EinheitenManuky, EinheitenSuroka, EinheitenPryolon, EinheitenTalbidahr, EinheitenMoruPhisihl,
     EinheitenLarinosLotaris, EinheitenCarupex, EinheitenAlary, EinheitenTesorahn, EinheitenNatriesZermanis, EinheitenTridatus, EinheitenSenelari, EinheitenAspari2, EinheitenEkropa;

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
               when SonstigeDatentypen.Menschen =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMenschen.EinheitenMenschenListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Kasrodiah =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenKasrodiah.EinheitenKasrodiahListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Lasupin =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLasupin.EinheitenLasupinListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Lamustra =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLamustra.EinheitenLamustraListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Manuky =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenManuky.EinheitenManukyListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Suroka =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSuroka.EinheitenSurokaListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Pryolon =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenPryolon.EinheitenPryolonListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Talbidahr =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTalbidahr.EinheitenTalbidahrListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Moru_Phisihl =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMoruPhisihl.EinheitenMoruPhisihlListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Larinos_Lotaris =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLarinosLotaris.EinheitenLarinosLotarisListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Carupex =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenCarupex.EinheitenCarupexListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Alary =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAlary.EinheitenAlaryListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Tesorahn =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTesorahn.EinheitenTesorahnListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Natries_Zermanis =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenNatriesZermanis.EinheitenNatriesZermanisListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Tridatus =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTridatus.EinheitenTridatusListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Senelari =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSenelari.EinheitenSenelariListe (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Aspari_2 =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAspari2.EinheitenAspari2Liste (EinheitenSchleifenwert);
                  
               when SonstigeDatentypen.Ekropa =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenEkropa.EinheitenEkropaListe (EinheitenSchleifenwert);
            end case;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end StandardEinheitenDatenbankLaden;
   
end EinheitenDatenbank;
