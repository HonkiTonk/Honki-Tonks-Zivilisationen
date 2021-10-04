pragma SPARK_Mode (On);

with ForschungMenschen, ForschungKasrodiah, ForschungLasupin, ForschungLamustra, ForschungManuky, ForschungSuroka, ForschungPryolon, ForschungTalbidahr, ForschungMoruPhisihl,
     ForschungLarinosLotaris, ForschungCarupex, ForschungAlary, ForschungTesorahn, ForschungNatriesZermanis, ForschungTridatus, ForschungSenelari, ForschungAspari2, ForschungEkropa;

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
               when SonstigeDatentypen.Menschen =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMenschen.ForschungMenschenListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Kasrodiah =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungKasrodiah.ForschungKasrodiahListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Lasupin =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLasupin.ForschungLasupinListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Lamustra =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLamustra.ForschungLamustraListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Manuky =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungManuky.ForschungManukyListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Suroka =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSuroka.ForschungSurokaListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Pryolon =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungPryolon.ForschungPryolonListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Talbidahr =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTalbidahr.ForschungTalbidahrListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Moru_Phisihl =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMoruPhisihl.ForschungMoruPhisihlListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Larinos_Lotaris =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLarinosLotaris.ForschungLarinosLotarisListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Carupex =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungCarupex.ForschungCarupexListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Alary =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAlary.ForschungAlaryListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Tesorahn =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTesorahn.ForschungTesorahnListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Natries_Zermanis =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungNatriesZermanis.ForschungNatriesZermanisListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Tridatus =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTridatus.ForschungTridatusListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Senelari =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSenelari.ForschungSenelariListe (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Aspari_2 =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAspari2.ForschungAspari2Liste (ForschungSchleifenwert);
                  
               when SonstigeDatentypen.Ekropa =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungEkropa.ForschungEkropaListe (ForschungSchleifenwert);
            end case;
            
         end loop ForschungsSchleife;
      end loop RassenSchleife;
      
   end StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
