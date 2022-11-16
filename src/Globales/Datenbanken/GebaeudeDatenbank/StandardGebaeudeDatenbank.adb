with GebaeudeDatenbank;
with RassenDatentypen;

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

package body StandardGebaeudeDatenbank is

   procedure StandardGebaeudeDatenbankLaden
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GebaeudeDatenbank.GebäudelisteArray'Range (1) loop
         GebäudeSchleife:
         for GebäudeSchleifenwert in GebaeudeDatenbank.GebäudelisteArray'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when RassenDatentypen.Menschen_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMenschen.GebäudelisteMenschen (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Kasrodiah_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeKasrodiah.GebäudelisteKasrodiah (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Lasupin_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLasupin.GebäudelisteLasupin (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Lamustra_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLamustra.GebäudelisteLamustra (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Manuky_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeManuky.GebäudelisteManuky (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Suroka_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSuroka.GebäudelisteSuroka (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Pryolon_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudePryolon.GebäudelistePryolon (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Moru_Phisihl_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeMoruPhisihl.GebäudelisteMoruPhisihl (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Larinos_Lotaris_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeLarinosLotaris.GebäudelisteLarinosLotaris (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Carupex_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeCarupex.GebäudelisteCarupex (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Alary_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAlary.GebäudelisteAlary (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Natries_Zermanis_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeNatriesZermanis.GebäudelisteNatriesZermanis (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Tridatus_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTridatus.GebäudelisteTridatus (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Senelari_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeSenelari.GebäudelisteSenelari (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Aspari_2_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeAspari2.GebäudelisteAspari2 (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Ekropa_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeEkropa.GebäudelisteEkropa (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Tesorahn_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTesorahn.GebäudelisteTesorahn (GebäudeSchleifenwert);
                  
               when RassenDatentypen.Talbidahr_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (RasseSchleifenwert, GebäudeSchleifenwert) := GebaeudeTalbidahr.GebäudelisteTalbidahr (GebäudeSchleifenwert);
            end case;
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
   end StandardGebaeudeDatenbankLaden;

end StandardGebaeudeDatenbank;
