with SpeziesDatenbank;
with SpeziesDatentypen;

with SpeziesMenschen;
with SpeziesKasrodiah;
with SpeziesLasupin;
with SpeziesLamustra;
with SpeziesManuky;
with SpeziesSuroka;
with SpeziesPryolon;
with SpeziesTalbidahr;
with SpeziesMoruPhisihl;
with SpeziesLarinosLotaris;
with SpeziesCarupex;
with SpeziesAlary;
with SpeziesTesorahn;
with SpeziesNatriesZermanis;
with SpeziesTridatus;
with SpeziesSenelari;
with SpeziesAspari2;
with SpeziesEkropa;

package body StandardSpeziesDatenbank is

   procedure StandardSpeziesDatenbankLaden
   is begin
      
      -- Ersatz für die direkte Zuweisung in die Liste, da dies eine falsche Warnung mit -gnatwu erzeugt.
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatenbank.SpezieslisteArray'Range loop
         
         case
           SpeziesSchleifenwert
         is
            when SpeziesDatentypen.Menschen_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesMenschen.SpezieslisteMenschen;
               
            when SpeziesDatentypen.Kasrodiah_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesKasrodiah.SpezieslisteKasrodiah;
               
            when SpeziesDatentypen.Lasupin_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesLasupin.SpezieslisteLasupin;
               
            when SpeziesDatentypen.Lamustra_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesLamustra.SpezieslisteLamustra;
               
            when SpeziesDatentypen.Manuky_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesManuky.SpezieslisteManuky;
               
            when SpeziesDatentypen.Suroka_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesSuroka.SpezieslisteSuroka;
               
            when SpeziesDatentypen.Pryolon_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesPryolon.SpezieslistePryolon;
               
            when SpeziesDatentypen.Moru_Phisihl_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesMoruPhisihl.SpezieslisteMoruPhisihl;
               
            when SpeziesDatentypen.Larinos_Lotaris_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesLarinosLotaris.SpezieslisteLarinosLotaris;
               
            when SpeziesDatentypen.Carupex_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesCarupex.SpezieslisteCarupex;
               
            when SpeziesDatentypen.Alary_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesAlary.SpezieslisteAlary;
               
            when SpeziesDatentypen.Natries_Zermanis_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesNatriesZermanis.SpezieslisteNatriesZermanis;
               
            when SpeziesDatentypen.Tridatus_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesTridatus.SpezieslisteTridatus;
               
            when SpeziesDatentypen.Senelari_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesSenelari.SpezieslisteSenelari;
               
            when SpeziesDatentypen.Aspari_2_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesAspari2.SpezieslisteAspari2;
               
            when SpeziesDatentypen.Ekropa_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesEkropa.SpezieslisteEkropa;
               
            when SpeziesDatentypen.Talbidahr_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesTalbidahr.SpezieslisteTalbidahr;
               
            when SpeziesDatentypen.Tesorahn_Enum =>
               SpeziesDatenbank.Speziesliste (SpeziesSchleifenwert) := SpeziesTesorahn.SpezieslisteTesorahn;
         end case;
         
      end loop SpeziesSchleife;
      
   end StandardSpeziesDatenbankLaden;

end StandardSpeziesDatenbank;
