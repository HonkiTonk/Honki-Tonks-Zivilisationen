pragma SPARK_Mode (On);

with GebaeudeMenschen, GebaeudeKasrodiah, GebaeudeLasupin, GebaeudeLamustra, GebaeudeManuky, GebaeudeSuroka, GebaeudePryolon, GebaeudeTalbidahr, GebaeudeMoruPhisihl, GebaeudeLarinosLotaris,
     GebaeudeCarupex, GebaeudeAlary, GebaeudeTesorahn, GebaeudeNatriesZermanis, GebaeudeTridatus, GebaeudeSenelari, GebaeudeAspari2, GebaeudeEkropa;

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
               when GlobaleDatentypen.Menschen =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMenschen.GebäudeMenschenListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Kasrodiah =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeKasrodiah.GebäudeKasrodiahListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Lasupin =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLasupin.GebäudeLasupinListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Lamustra =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLamustra.GebäudeLamustraListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Manuky =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeManuky.GebäudeManukyListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Suroka =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSuroka.GebäudeSurokaListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Pryolon =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudePryolon.GebäudePryolonListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Talbidahr =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTalbidahr.GebäudeTalbidahrListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Moru_Phisihl =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMoruPhisihl.GebäudeMoruPhisihlListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Larinos_Lotaris =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLarinosLotaris.GebäudeLarinosLotarisListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Carupex =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeCarupex.GebäudeCarupexListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Alary =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAlary.GebäudeAlaryListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Tesorahn =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTesorahn.GebäudeTesorahnListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Natries_Zermanis =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeNatriesZermanis.GebäudeNatriesZermanisListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Tridatus =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTridatus.GebäudeTridatusListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Senelari =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSenelari.GebäudeSenelariListe (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Aspari_2 =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAspari2.GebäudeAspari2Liste (GebäudeSchleifenwert);
                  
               when GlobaleDatentypen.Ekropa =>
                    GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeEkropa.GebäudeEkropaListe (GebäudeSchleifenwert);
            end case;
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
   end StandardGebaeudeDatenbankLaden;

end GebaeudeDatenbank;
