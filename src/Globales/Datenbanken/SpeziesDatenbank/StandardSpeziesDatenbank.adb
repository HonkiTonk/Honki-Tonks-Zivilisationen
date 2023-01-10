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

   -- Das hier später auch mal anpassen oder entfernen. äöü
   procedure StandardSpeziesDatenbankLaden
   is begin
      
      SpeziesDatenbank.Speziesliste := (
                                        SpeziesMenschen.SpeziesMenschenListe,
                                        SpeziesKasrodiah.SpeziesKasrodiahListe,
                                        SpeziesLasupin.SpeziesLasupinListe,
                                        SpeziesLamustra.SpeziesLamustraListe,
                                        SpeziesManuky.SpeziesManukyListe,
                                        SpeziesSuroka.SpeziesSurokaListe,
                                        SpeziesPryolon.SpeziesPryolonListe,
                                        SpeziesTalbidahr.SpeziesTalbidahrListe,
                                        SpeziesMoruPhisihl.SpeziesMoruPhisihlListe,
                                        SpeziesLarinosLotaris.SpeziesLarinosLotarisListe,
                                        SpeziesCarupex.SpeziesCarupexListe,
                                        SpeziesAlary.SpeziesAlaryListe,
                                        SpeziesTesorahn.SpeziesTesorahnListe,
                                        SpeziesNatriesZermanis.SpeziesNatriesZermanisListe,
                                        SpeziesTridatus.SpeziesTridatusListe,
                                        SpeziesSenelari.SpeziesSenelariListe,
                                        SpeziesAspari2.SpeziesAspari2Liste,
                                        SpeziesEkropa.SpeziesEkropaListe
                                       );
      
      -- Kann wegen dam Kompilerfehler mit gnat-wu aktuell nicht verwendet werden. äöü
      -- SpeziesDatenbank.Speziesliste := (
      --                                 SpeziesDatentypen.Menschen_Enum         => SpeziesMenschen.SpeziesMenschenListe,
      --                               SpeziesDatentypen.Kasrodiah_Enum        => SpeziesKasrodiah.SpeziesKasrodiahListe,
      --                             SpeziesDatentypen.Lasupin_Enum          => SpeziesLasupin.SpeziesLasupinListe,
      --                           SpeziesDatentypen.Lamustra_Enum         => SpeziesLamustra.SpeziesLamustraListe,
      --                         SpeziesDatentypen.Manuky_Enum           => SpeziesManuky.SpeziesManukyListe,
      --                       SpeziesDatentypen.Suroka_Enum           => SpeziesSuroka.SpeziesSurokaListe,
      --                     SpeziesDatentypen.Pryolon_Enum          => SpeziesPryolon.SpeziesPryolonListe,
      --                   SpeziesDatentypen.Talbidahr_Enum        => SpeziesTalbidahr.SpeziesTalbidahrListe,
      --                 SpeziesDatentypen.Moru_Phisihl_Enum     => SpeziesMoruPhisihl.SpeziesMoruPhisihlListe,
      --               SpeziesDatentypen.Larinos_Lotaris_Enum  => SpeziesLarinosLotaris.SpeziesLarinosLotarisListe,
      --             SpeziesDatentypen.Carupex_Enum          => SpeziesCarupex.SpeziesCarupexListe,
      --           SpeziesDatentypen.Alary_Enum            => SpeziesAlary.SpeziesAlaryListe,
      --         SpeziesDatentypen.Tesorahn_Enum         => SpeziesTesorahn.SpeziesTesorahnListe,
      --       SpeziesDatentypen.Natries_Zermanis_Enum => SpeziesNatriesZermanis.SpeziesNatriesZermanisListe,
      --     SpeziesDatentypen.Tridatus_Enum         => SpeziesTridatus.SpeziesTridatusListe,
      --   SpeziesDatentypen.Senelari_Enum         => SpeziesSenelari.SpeziesSenelariListe,
      -- SpeziesDatentypen.Aspari_2_Enum         => SpeziesAspari2.SpeziesAspari2Liste,
      -- SpeziesDatentypen.Ekropa_Enum           => SpeziesEkropa.SpeziesEkropaListe
      -- );
      
   end StandardSpeziesDatenbankLaden;

end StandardSpeziesDatenbank;
