pragma SPARK_Mode (On);

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
               when SystemDatentypen.Menschen =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMenschen.ForschungMenschenListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Kasrodiah =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungKasrodiah.ForschungKasrodiahListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Lasupin =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLasupin.ForschungLasupinListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Lamustra =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLamustra.ForschungLamustraListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Manuky =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungManuky.ForschungManukyListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Suroka =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSuroka.ForschungSurokaListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Pryolon =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungPryolon.ForschungPryolonListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Talbidahr =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTalbidahr.ForschungTalbidahrListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Moru_Phisihl =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMoruPhisihl.ForschungMoruPhisihlListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Larinos_Lotaris =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLarinosLotaris.ForschungLarinosLotarisListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Carupex =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungCarupex.ForschungCarupexListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Alary =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAlary.ForschungAlaryListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Tesorahn =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTesorahn.ForschungTesorahnListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Natries_Zermanis =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungNatriesZermanis.ForschungNatriesZermanisListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Tridatus =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTridatus.ForschungTridatusListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Senelari =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSenelari.ForschungSenelariListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Aspari_2 =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAspari2.ForschungAspari2Liste (ForschungSchleifenwert);
                  
               when SystemDatentypen.Ekropa =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungEkropa.ForschungEkropaListe (ForschungSchleifenwert);
            end case;
            
         end loop ForschungsSchleife;
      end loop RassenSchleife;
      
   end StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
