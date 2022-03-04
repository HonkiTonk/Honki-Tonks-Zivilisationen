pragma SPARK_Mode (On);

with SystemDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenGrundKonstanten;
with KartenVerbesserungKonstanten;

with DatenbankRecords;
with KartenDatenbank;
with VerbesserungenDatenbank;

package EingeleseneGrafikenKonsole is

   type EinheitenGrafikArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, DatenbankRecords.EinheitenListeArray'Range) of Wide_Wide_Character;
   EinheitenGrafik : EinheitenGrafikArray := (
                                              others =>
                                                (
                                                 -- Siedler
                                                 1 => 'S',
                                               
                                                 -- Steinzeitkämpfer
                                                 2 => 'N',
                                               
                                                 -- Bogenschütze
                                                 3 => 'F',
      
                                                 -- Erstes Schiff
                                                 4 => 'W',
                                               
                                                 -- Bronzekämpfer
                                                 5 => 'N',
                                               
                                                 -- Eisenkämpfer
                                                 6 => 'N',
                                               
                                                 -- Streitwagen
                                                 7 => 'N',
                                               
                                                 -- Katapult
                                                 8 => 'F',
                                               
                                                 -- Balliste
                                                 9 => 'F',
                                               
                                                 -- Segelschiff
                                                 10 => 'W',
                                               
                                                 -- Großes Segelschiff
                                                 11 => 'W',
                                               
                                                 -- Gewehrkämpfer
                                                 12 => 'N',
                                               
                                                 -- Kanone
                                                 13 => 'F',
                                               
                                                 -- Dampfschiff
                                                 14 => 'W',
                                               
                                                 -- Motorschiff
                                                 15 => 'W',
                                               
                                                 -- U-Boot
                                                 16 => 'W',
                                               
                                                 -- Gepanzerter Wagen
                                                 17 => 'N',
                                               
                                                 -- Panzer
                                                 18 => 'N',
                                               
                                                 -- Jäger
                                                 19 => 'L',
                                               
                                                 -- Bomber
                                                 20 => 'L',
                                               
                                                 -- Rakete
                                                 21 => 'O',
                                               
                                                 -- Düsenjäger
                                                 22 => 'L',
                                               
                                                 -- Düsenbomber
                                                 23 => 'L',
                                               
                                                 -- Atombombe
                                                 24 => 'S',
                                               
                                                 -- Drohne
                                                 25 => 'L',
                                               
                                                 -- Gensoldat
                                                 26 => 'N',
                                               
                                                 -- Wassersiedler
                                                 27 => 'S',
                                               
                                                 -- Cyborg
                                                 28 => 'N',
                                               
                                                 -- Unterwasser/Unterirdischer Siedler
                                                 29 => 'S',
                                               
                                                 -- PZB20
                                                 30 => 'S',
                                               
                                                 -- PZB40
                                                 31 => 'S',
                                               
                                                 -- PZB100
                                                 32 => 'S',
                                               
                                                 -- Gaußkämpfer
                                                 33 => 'N',
                                               
                                                 -- Magnetkämpfer
                                                 34 => 'N',
                                               
                                                 -- Schwebepanzer
                                                 35 => 'N',
                                               
                                                 -- Planetenkernsiedler
                                                 36 => 'S',
                                               
                                                 -- Himmel/Orbitalsiedler
                                                 37 => 'S',
                                               
                                                 -- Atmosphärenjäger
                                                 38 => 'L',
                                               
                                                 -- Atmosphärenbomber
                                                 39 => 'L',
                                               
                                                 -- Artillerie
                                                 40 => 'F',
                                               
                                                 -- Stellare Artillerie
                                                 41 => 'F',
                                               
                                                 -- Gräberschiff
                                                 42 => 'W',
                                               
                                                 -- Kerngräber
                                                 43 => 'W',
                                               
                                                 -- Moderne Infanterie
                                                 44 => 'N',
                                               
                                                 -- Alleskönner
                                                 45 => 'A',
                                                               
                                                 others => EinheitenKonstanten.LeerEinheitenGrafik
                                                )
                                             );
   
   type GebäudeGrafikArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, DatenbankRecords.GebäudeListeArray'Range) of Wide_Wide_Character;
   GebäudeGrafik : GebäudeGrafikArray := (
                                            others =>
                                              (
                                               -- Häuser
                                               1 => 'A',
                                             
                                               -- Nahrungslager
                                               2 => 'B',
                                             
                                               -- Holzpalisade
                                               3 => 'C',
                                             
                                               -- Schmiede
                                               4 => 'D',
      
                                               -- Bibliothek
                                               5 => 'E',
                                             
                                               -- Steinmauer
                                               6 => 'F',
                                             
                                               -- Bücherei
                                               7 => 'G',
                                             
                                               -- Bewässerungssystem
                                               8 => 'H',
                                             
                                               -- Kaserne
                                               9 => 'I',
                                             
                                               -- Wassermühle
                                               10 => 'J',
                                             
                                               -- Windmühle
                                               11 => 'K',
                                             
                                               -- Seehafen
                                               12 => 'L',
                                             
                                               -- Hochofen
                                               13 => 'M',
                                             
                                               -- Universität
                                               14 => 'N',
                                             
                                               -- Burg
                                               15 => 'O',
                                             
                                               -- Schwere Burg
                                               16 => 'P',
                                             
                                               -- Festungen
                                               17 => 'Q',
                                             
                                               -- Kohlekraftwerk
                                               18 => 'R',
                                             
                                               -- Fabrik
                                               19 => 'S',
                                             
                                               -- Krankenhaus
                                               20 => 'T',
                                             
                                               -- Flughafen
                                               21 => 'U',
                                             
                                               -- Atomkraftwerk
                                               22 => 'V',
                                             
                                               -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
                                               23 => 'W',
                                             
                                               -- Genklinik
                                               24 => 'X',
                                             
                                               -- Fusionskraftwerk
                                               25 => 'Y',
                                             
                                               -- NAMR Kraftwerk
                                               26 => 'Z',
                                                              
                                               others => StadtKonstanten.LeerGebäudeGrafik
                                              )
                                           );
   
   type KartenGrafikArray is array (KartenDatenbank.KartenListeArray'Range) of Wide_Wide_Character;
   KartenGrafik : KartenGrafikArray := (
                                         KartenGrundKonstanten.LeerGrund => KartenKonstanten.LeerKartenGrafik,
                                         
                                         -- Feld
                                         -- Normal
                                         KartenGrundKonstanten.EisKonstante       => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.WasserKonstante    => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.FlachlandKonstante => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.TundraKonstante    => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.WüsteKonstante     => KartenKonstanten.LeerKartenGrafik,
                                      
                                         -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                         KartenGrundKonstanten.HügelKonstante          => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.GebirgeKonstante        => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.WaldKonstante           => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.DschungelKonstante      => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.KüstengewässerKonstante => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.SumpfKonstante          => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.HügelMitKonstante       => KartenKonstanten.LeerKartenGrafik,
                                         -- Normal
      
      
      
                                         -- Unterwasser/Unterirdisch
                                         KartenGrundKonstanten.UnterwasserEisKonstante            => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.ErdeKonstante                      => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.ErdgesteinKonstante                => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.SandKonstante                      => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.UnterwasserWasserKonstante         => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.UnterwasserKüstengewässerKonstante => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.KorallenKonstante                  => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.UnterwasserWaldKonstante           => KartenKonstanten.LeerKartenGrafik,
                                         -- Unterwasser/Unterirdisch
      
      
                   
                                         -- Planeteninneres
                                         KartenGrundKonstanten.LavaKonstante         => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.GesteinKonstante      => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.PlanetenkernKonstante => KartenKonstanten.LeerKartenGrafik,
                                         -- Planeteninneres
      
      
      
                                         -- Luft/Weltraum
                                         KartenGrundKonstanten.WolkenKonstante  => KartenKonstanten.LeerKartenGrafik,
                                         KartenGrundKonstanten.WeltraumKonstante => KartenKonstanten.LeerKartenGrafik,
                                         -- Luft/Weltraum
                                         -- Feld
                                        
      
                                      
                                         -- Ressourcen
                                         KartenGrundKonstanten.KohleKonstante             => '♦',
                                         KartenGrundKonstanten.EisenKonstante             => '♦',
                                         KartenGrundKonstanten.ÖlKonstante                => '♦',
                                         KartenGrundKonstanten.FischKonstante             => '≈',
                                         KartenGrundKonstanten.WalKonstante               => '≈',
                                         KartenGrundKonstanten.HochwertigerBodenKonstante => '♦',
                                         KartenGrundKonstanten.GoldKonstante              => '♦',
                                         -- Ressourcen
      
      
      
                                         -- Flüsse
                                         -- Normal
                                         KartenGrundKonstanten.FlusskreuzungVierKonstante       => '╋',
                                         KartenGrundKonstanten.FlussWaagrechtKonstante          => '━',
                                         KartenGrundKonstanten.FlussSenkrechtKonstante          => '┃',
                                         KartenGrundKonstanten.FlusskurveUntenRechtsKonstante   => '┏',
                                         KartenGrundKonstanten.FlusskurveUntenLinksKonstante    => '┓',
                                         KartenGrundKonstanten.FlusskurveObenRechtsKonstante    => '┗',
                                         KartenGrundKonstanten.FlusskurveObenLinksKonstante     => '┛',
                                         KartenGrundKonstanten.FlusskreuzungDreiObenKonstante   => '┻',
                                         KartenGrundKonstanten.FlusskreuzungDreiUntenKonstante  => '┳',
                                         KartenGrundKonstanten.FlusskreuzungDreiRechtsKonstante => '┣',
                                         KartenGrundKonstanten.FlusskreuzungDreiLinksKonstante  => '┫',
                                         KartenGrundKonstanten.FlussendstückLinksKonstante      => '╺',
                                         KartenGrundKonstanten.FlussendstückRechtsKonstante     => '╸',
                                         KartenGrundKonstanten.FlussendstückUntenKonstante      => '╹',
                                         KartenGrundKonstanten.FlussendstückObenKonstante       => '╻',
                                         KartenGrundKonstanten.SeeKonstante                     => '▪',
                                         -- Normal
      
      
      
                                         -- Unterirdisch
                                         KartenGrundKonstanten.UnterirdischeFlusskreuzungVierKonstante       => '╋',
                                         KartenGrundKonstanten.UnterirdischerFlussWaagrechtKonstante         => '━',
                                         KartenGrundKonstanten.UnterirdischerFlussSenkrechtKonstante         => '┃',
                                         KartenGrundKonstanten.UnterirdischeFlusskurveUntenRechtsKonstante   => '┏',
                                         KartenGrundKonstanten.UnterirdischeFlusskurveUntenLinksKonstante    => '┓',
                                         KartenGrundKonstanten.UnterirdischeFlusskurveObenRechtsKonstante    => '┗',
                                         KartenGrundKonstanten.UnterirdischeFlusskurveObenLinksKonstante     => '┛',
                                         KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiObenKonstante   => '┻',
                                         KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiUntenKonstante  => '┳',
                                         KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiRechtsKonstante => '┣',
                                         KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiLinksKonstante  => '┫',
                                         KartenGrundKonstanten.UnterirdischesFlussendstückLinksKonstante     => '╺',
                                         KartenGrundKonstanten.UnterirdischesFlussendstückRechtsKonstante    => '╸',
                                         KartenGrundKonstanten.UnterirdischesFlussendstückUntenKonstante     => '╹',
                                         KartenGrundKonstanten.UnterirdischesFlussendstückObenKonstante      => '╻',
                                         KartenGrundKonstanten.UnterirdischerSeeKonstante                    => '▪',
                                         -- Unterirdisch
      
      
      
                                         -- Lava
                                         KartenGrundKonstanten.LavaflusskreuzungVierKonstante       => '╋',
                                         KartenGrundKonstanten.LavaflussWaagrechtKonstante          => '━',
                                         KartenGrundKonstanten.LavaflussSenkrechtKonstante          => '┃',
                                         KartenGrundKonstanten.LavaflusskurveUntenRechtsKonstante   => '┏',
                                         KartenGrundKonstanten.LavaflusskurveUntenLinksKonstante    => '┓',
                                         KartenGrundKonstanten.LavaflusskurveObenRechtsKonstante    => '┗',
                                         KartenGrundKonstanten.LavaflusskurveObenLinksKonstante     => '┛',
                                         KartenGrundKonstanten.LavaflusskreuzungDreiObenKonstante   => '┻',
                                         KartenGrundKonstanten.LavaflusskreuzungDreiUntenKonstante  => '┳',
                                         KartenGrundKonstanten.LavaflusskreuzungDreiRechtsKonstante => '┣',
                                         KartenGrundKonstanten.LavaflusskreuzungDreiLinksKonstante  => '┫',
                                         KartenGrundKonstanten.LavaflussendstückLinksKonstante      => '╺',
                                         KartenGrundKonstanten.LavaflussendstückRechtsKonstante     => '╸',
                                         KartenGrundKonstanten.LavaflussendstückUntenKonstante      => '╹',
                                         KartenGrundKonstanten.LavaflussendstückObenKonstante       => '╻',
                                         KartenGrundKonstanten.LavaseeKonstante                     => '▪'
                                         -- Lava
                                         -- Flüsse
                                        );
   
   type VerbesserungGrafikArray is array (VerbesserungenDatenbank.VerbesserungListeArray'Range) of Wide_Wide_Character;
   VerbesserungGrafik : VerbesserungGrafikArray := (
                                                    KartenVerbesserungKonstanten.LeerVerbesserung => KartenKonstanten.LeerKartenGrafik,
      
      
                                                    
                                                    -- Städte
                                                    KartenVerbesserungKonstanten.EigeneHauptstadtKonstante => '♣',
                                                    KartenVerbesserungKonstanten.EigeneStadtKonstante      => '♠',
                                                    KartenVerbesserungKonstanten.FremdeHauptstadtKonstante => '⌂',
                                                    KartenVerbesserungKonstanten.FremdeStadtKonstante      => '¤',
                                                    -- Städte
      
      
                                                  
                                                    -- Gebilde
                                                    KartenVerbesserungKonstanten.FarmKonstante    => 'F',
                                                    KartenVerbesserungKonstanten.MineKonstante    => 'M',
                                                    KartenVerbesserungKonstanten.FestungKonstante => 'B',
                                                    KartenVerbesserungKonstanten.SperreKonstante  => 'S',
                                                    -- Gebilde
      
      
                                                  
                                                    -- Wege
                                                    -- Straßen
                                                    KartenVerbesserungKonstanten.StraßenkreuzungVierKonstante       => '╬',
                                                    KartenVerbesserungKonstanten.StraßeWaagrechtKonstante           => '═',
                                                    KartenVerbesserungKonstanten.StraßeSenkrechtKonstante           => '║',
                                                    KartenVerbesserungKonstanten.StraßenkurveUntenRechtsKonstante   => '╔',
                                                    KartenVerbesserungKonstanten.StraßenkurveUntenLinksKonstante    => '╗',
                                                    KartenVerbesserungKonstanten.StraßenkurveObenRechtsKonstante    => '╚',
                                                    KartenVerbesserungKonstanten.StraßenkurveObenLinksKonstante     => '╝',
                                                    KartenVerbesserungKonstanten.StraßenkreuzungDreiObenKonstante   => '╩',
                                                    KartenVerbesserungKonstanten.StraßenkreuzungDreiUntenKonstante  => '╦',
                                                    KartenVerbesserungKonstanten.StraßenkreuzungDreiRechtsKonstante => '╠',
                                                    KartenVerbesserungKonstanten.StraßenkreuzungDreiLinksKonstante  => '╣',
                                                    KartenVerbesserungKonstanten.StraßenendstückLinksKonstante      => '╞',
                                                    KartenVerbesserungKonstanten.StraßenendstückRechtsKonstante     => '╡',
                                                    KartenVerbesserungKonstanten.StraßenendstückUntenKonstante      => '╨',
                                                    KartenVerbesserungKonstanten.StraßenendstückObenKonstante       => '╥',
                                                    KartenVerbesserungKonstanten.StraßeEinzelnKonstante             => '▫',
                                                    -- Straßen
      
      
      
                                                    -- Schienen
                                                    -- Schienen
      
      
                                                    
                                                    -- Tunnel
                                                    -- Tunnel
                                                    -- Wege
                                                    
                                                    others => KartenKonstanten.LeerKartenGrafik
                                                   );
   
end EingeleseneGrafikenKonsole;
