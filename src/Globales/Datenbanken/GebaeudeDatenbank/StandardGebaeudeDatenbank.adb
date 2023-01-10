with GebaeudeDatenbank;
with SpeziesDatentypen;

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
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in GebaeudeDatenbank.GebäudelisteArray'Range (1) loop
         GebäudeSchleife:
         for GebäudeSchleifenwert in GebaeudeDatenbank.GebäudelisteArray'Range (2) loop
            
            case
              SpeziesSchleifenwert
            is
               when SpeziesDatentypen.Menschen_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeMenschen.GebäudelisteMenschen (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Kasrodiah_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeKasrodiah.GebäudelisteKasrodiah (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Lasupin_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeLasupin.GebäudelisteLasupin (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Lamustra_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeLamustra.GebäudelisteLamustra (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Manuky_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeManuky.GebäudelisteManuky (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Suroka_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeSuroka.GebäudelisteSuroka (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Pryolon_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudePryolon.GebäudelistePryolon (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Moru_Phisihl_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeMoruPhisihl.GebäudelisteMoruPhisihl (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Larinos_Lotaris_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeLarinosLotaris.GebäudelisteLarinosLotaris (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Carupex_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeCarupex.GebäudelisteCarupex (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Alary_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeAlary.GebäudelisteAlary (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Natries_Zermanis_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeNatriesZermanis.GebäudelisteNatriesZermanis (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Tridatus_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeTridatus.GebäudelisteTridatus (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Senelari_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeSenelari.GebäudelisteSenelari (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Aspari_2_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeAspari2.GebäudelisteAspari2 (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Ekropa_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeEkropa.GebäudelisteEkropa (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Tesorahn_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeTesorahn.GebäudelisteTesorahn (GebäudeSchleifenwert);
                  
               when SpeziesDatentypen.Talbidahr_Enum =>
                  GebaeudeDatenbank.Gebäudeliste (SpeziesSchleifenwert, GebäudeSchleifenwert) := GebaeudeTalbidahr.GebäudelisteTalbidahr (GebäudeSchleifenwert);
            end case;
            
         end loop GebäudeSchleife;
      end loop SpeziesSchleife;
      
   end StandardGebaeudeDatenbankLaden;

end StandardGebaeudeDatenbank;
