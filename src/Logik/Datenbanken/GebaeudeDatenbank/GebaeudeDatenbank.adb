pragma SPARK_Mode (On);

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
               when SystemDatentypen.Menschen =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMenschen.GebäudeMenschenListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Kasrodiah =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeKasrodiah.GebäudeKasrodiahListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Lasupin =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLasupin.GebäudeLasupinListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Lamustra =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLamustra.GebäudeLamustraListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Manuky =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeManuky.GebäudeManukyListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Suroka =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSuroka.GebäudeSurokaListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Pryolon =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudePryolon.GebäudePryolonListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Talbidahr =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTalbidahr.GebäudeTalbidahrListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Moru_Phisihl =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMoruPhisihl.GebäudeMoruPhisihlListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Larinos_Lotaris =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLarinosLotaris.GebäudeLarinosLotarisListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Carupex =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeCarupex.GebäudeCarupexListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Alary =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAlary.GebäudeAlaryListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Tesorahn =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTesorahn.GebäudeTesorahnListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Natries_Zermanis =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeNatriesZermanis.GebäudeNatriesZermanisListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Tridatus =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTridatus.GebäudeTridatusListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Senelari =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSenelari.GebäudeSenelariListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Aspari_2 =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAspari2.GebäudeAspari2Liste (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Ekropa =>
                    GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeEkropa.GebäudeEkropaListe (GebäudeSchleifenwert);
            end case;
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
   end StandardGebaeudeDatenbankLaden;

end GebaeudeDatenbank;
