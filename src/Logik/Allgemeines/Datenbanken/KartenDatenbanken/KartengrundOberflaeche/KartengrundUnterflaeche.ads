pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with EinheitenDatentypen;
with RassenDatentypen;

with DatenbankRecords;

package KartengrundUnterflaeche is
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type KartengrundlisteUnterflächeArray is array (KartengrundDatentypen.Kartengrund_Unterfläche_Enum'Range) of DatenbankRecords.KartengrundlisteRecord;
   KartengrundlisteUnterfläche : constant KartengrundlisteUnterflächeArray := (
                                                                                 KartengrundDatentypen.Untereis_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                       others                                => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),
                                      
                                                                                 KartengrundDatentypen.Erde_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                       others                                => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),
      
                                                                                 KartengrundDatentypen.Erdgestein_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                       others                                => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),
                                      
                                                                                 KartengrundDatentypen.Gestein_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                                       others                                   => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),
      
                                                                                 KartengrundDatentypen.Sand_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                       others                                => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),
      
                                                                                 KartengrundDatentypen.Meeresgrund_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                                       others                               => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),
                                      
                                                                                 KartengrundDatentypen.Küstengrund_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                                       others                               => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),
      
                                                                                 KartengrundDatentypen.Korallen_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                                       others                               => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   ),
      
                                                                                 KartengrundDatentypen.Unterwald_Enum =>
                                                                                   (
                                                                                    Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                                       others                               => False),
                                                                    
                                                                                    Bewertung => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                                      ),
                                                                       
                                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                                    Wirtschaft => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                      ),
                                                                    
                                                                                      -- Verteidigung, Angriff
                                                                                    Kampf => 
                                                                                      (
                                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                      )
                                                                                   )
                                                                                );

end KartengrundUnterflaeche;
