with SpeziesDatenbank;

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
      
      SpeziesDatenbank.Speziesliste := (
                                        SpeziesMenschen.SpezieslisteMenschen,
                                        SpeziesKasrodiah.SpezieslisteKasrodiah,
                                        SpeziesLasupin.SpezieslisteLasupin,
                                        SpeziesLamustra.SpezieslisteLamustra,
                                        SpeziesManuky.SpezieslisteManuky,
                                        SpeziesSuroka.SpezieslisteSuroka,
                                        SpeziesPryolon.SpezieslistePryolon,
                                        SpeziesTalbidahr.SpezieslisteTalbidahr,
                                        SpeziesMoruPhisihl.SpezieslisteMoruPhisihl,
                                        SpeziesLarinosLotaris.SpezieslisteLarinosLotaris,
                                        SpeziesCarupex.SpezieslisteCarupex,
                                        SpeziesAlary.SpezieslisteAlary,
                                        SpeziesTesorahn.SpezieslisteTesorahn,
                                        SpeziesNatriesZermanis.SpezieslisteNatriesZermanis,
                                        SpeziesTridatus.SpezieslisteTridatus,
                                        SpeziesSenelari.SpezieslisteSenelari,
                                        SpeziesAspari2.SpezieslisteAspari2,
                                        SpeziesEkropa.SpezieslisteEkropa
                                       );
      
      -- Kann wegen dam Kompilerfehler mit gnat-wu aktuell nicht verwendet werden. äöü
      -- SpeziesDatenbank.Speziesliste := (
      --                                 SpeziesDatentypen.Menschen_Enum         => SpeziesMenschen.SpezieslisteMenschen,
      --                               SpeziesDatentypen.Kasrodiah_Enum        => SpeziesKasrodiah.SpezieslisteKasrodiah,
      --                             SpeziesDatentypen.Lasupin_Enum          => SpeziesLasupin.SpezieslisteLasupin,
      --                           SpeziesDatentypen.Lamustra_Enum         => SpeziesLamustra.SpezieslisteLamustra,
      --                         SpeziesDatentypen.Manuky_Enum           => SpeziesManuky.SpezieslisteManuky,
      --                       SpeziesDatentypen.Suroka_Enum           => SpeziesSuroka.SpezieslisteSuroka,
      --                     SpeziesDatentypen.Pryolon_Enum          => SpeziesPryolon.SpezieslistePryolon,
      --                   SpeziesDatentypen.Talbidahr_Enum        => SpeziesTalbidahr.SpezieslisteTalbidahr,
      --                 SpeziesDatentypen.Moru_Phisihl_Enum     => SpeziesMoruPhisihl.SpezieslisteMoruPhisihl,
      --               SpeziesDatentypen.Larinos_Lotaris_Enum  => SpeziesLarinosLotaris.SpezieslisteLarinosLotaris,
      --             SpeziesDatentypen.Carupex_Enum          => SpeziesCarupex.SpezieslisteCarupex,
      --           SpeziesDatentypen.Alary_Enum            => SpeziesAlary.SpezieslisteAlary,
      --         SpeziesDatentypen.Tesorahn_Enum         => SpeziesTesorahn.SpezieslisteTesorahn,
      --       SpeziesDatentypen.Natries_Zermanis_Enum => SpeziesNatriesZermanis.SpezieslisteNatriesZermanis,
      --     SpeziesDatentypen.Tridatus_Enum         => SpeziesTridatus.SpezieslisteTridatus,
      --   SpeziesDatentypen.Senelari_Enum         => SpeziesSenelari.SpezieslisteSenelari,
      -- SpeziesDatentypen.Aspari_2_Enum         => SpeziesAspari2.SpezieslisteAspari2,
      -- SpeziesDatentypen.Ekropa_Enum           => SpeziesEkropa.SpezieslisteEkropa
      -- );
      
   end StandardSpeziesDatenbankLaden;

end StandardSpeziesDatenbank;
