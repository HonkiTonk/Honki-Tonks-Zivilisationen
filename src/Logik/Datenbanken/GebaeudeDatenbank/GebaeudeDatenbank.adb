pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
               when SystemDatentypen.Menschen_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMenschen.GebäudeMenschenListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Kasrodiah_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeKasrodiah.GebäudeKasrodiahListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Lasupin_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLasupin.GebäudeLasupinListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Lamustra_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLamustra.GebäudeLamustraListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Manuky_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeManuky.GebäudeManukyListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Suroka_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSuroka.GebäudeSurokaListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Pryolon_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudePryolon.GebäudePryolonListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Talbidahr_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTalbidahr.GebäudeTalbidahrListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Moru_Phisihl_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMoruPhisihl.GebäudeMoruPhisihlListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Larinos_Lotaris_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLarinosLotaris.GebäudeLarinosLotarisListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Carupex_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeCarupex.GebäudeCarupexListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Alary_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAlary.GebäudeAlaryListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Tesorahn_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTesorahn.GebäudeTesorahnListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Natries_Zermanis_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeNatriesZermanis.GebäudeNatriesZermanisListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Tridatus_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTridatus.GebäudeTridatusListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Senelari_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSenelari.GebäudeSenelariListe (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Aspari_2_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAspari2.GebäudeAspari2Liste (GebäudeSchleifenwert);
                  
               when SystemDatentypen.Ekropa_Enum =>
                  GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeEkropa.GebäudeEkropaListe (GebäudeSchleifenwert);
            end case;
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
   end StandardGebaeudeDatenbankLaden;

end GebaeudeDatenbank;
