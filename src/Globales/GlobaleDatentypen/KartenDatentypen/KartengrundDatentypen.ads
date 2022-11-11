package KartengrundDatentypen is
   pragma Pure;

   type Basisgrund_Enum is (
                            Leer_Basisgrund_Enum,
                             
                            -- Weltraum
                            Weltraum_Enum,
                              
                            -- Himmel
                            Wolken_Enum,
                              
                            -- Oberfläche
                            Eis_Enum,
                            Wasser_Enum, Küstengewässer_Enum,
                            Flachland_Enum, Wüste_Enum, Hügel_Enum, Gebirge_Enum, Tundra_Enum,
                             
                            -- Unterfläche
                            Untereis_Enum,
                            Küstengrund_Enum, Meeresgrund_Enum,
                            Erde_Enum, Erdgestein_Enum, Sand_Enum, Gestein_Enum,
                              
                            -- Planetenkern
                            Lava_Enum, Planetenkern_Enum,
                            Ringwoodit_Enum, Majorit_Enum, Perowskit_Enum, Magnesiowüstit_Enum,
                              
                            -- Sonstiges
                            Vernichtet_Enum
                           );
   pragma Ordered (Basisgrund_Enum);
      
   subtype Basisgrund_Vorhanden_Enum is Basisgrund_Enum range Basisgrund_Enum'Val (Basisgrund_Enum'Pos (Basisgrund_Enum'First) + 1) .. Basisgrund_Enum'Last;
   
   -- Weltraum
   subtype Basisgrund_Weltraum_Enum is Basisgrund_Vorhanden_Enum range Weltraum_Enum .. Weltraum_Enum;
   
   -- Himmel
   subtype Basisgrund_Himmel_Enum is Basisgrund_Vorhanden_Enum range Wolken_Enum .. Wolken_Enum;
   
   -- Oberfläche
   subtype Basisgrund_Oberfläche_Enum is Basisgrund_Vorhanden_Enum range Eis_Enum .. Tundra_Enum;
   
   subtype Basisgrund_Oberfläche_Eiswasser_Enum is Basisgrund_Oberfläche_Enum range Eis_Enum .. Küstengewässer_Enum;
   subtype Basisgrund_Oberfläche_Wasser_Enum is Basisgrund_Oberfläche_Eiswasser_Enum range Wasser_Enum .. Küstengewässer_Enum;
   
   subtype Basisgrund_Oberfläche_Land_Enum is Basisgrund_Oberfläche_Enum range Flachland_Enum .. Tundra_Enum;
   
   -- Unterfläche
   subtype Basisgrund_Unterfläche_Enum is Basisgrund_Vorhanden_Enum range Untereis_Enum .. Gestein_Enum;
   
   subtype Basisgrund_Unterfläche_Eiswasser_Enum is Basisgrund_Unterfläche_Enum range Untereis_Enum .. Meeresgrund_Enum;
   subtype Basisgrund_Unterfläche_Wasser_Enum is Basisgrund_Unterfläche_Eiswasser_Enum range Küstengrund_Enum .. Meeresgrund_Enum;
   
   subtype Basisgrund_Unterfläche_Land_Enum is Basisgrund_Unterfläche_Enum range Erde_Enum .. Gestein_Enum;
   
   -- Planeteinneres
   subtype Basisgrund_Kernfläche_Enum is Basisgrund_Vorhanden_Enum range Lava_Enum .. Magnesiowüstit_Enum;
   subtype Basisgrund_Kernfläche_Flüssig_Enum is Basisgrund_Kernfläche_Enum range Lava_Enum .. Planetenkern_Enum;
   
   subtype Basisgrund_Kernfläche_Fest_Enum is Basisgrund_Kernfläche_Enum range Ringwoodit_Enum .. Magnesiowüstit_Enum;
   
   -- Sonstiges
   subtype Basisgrund_Sonstiges_Enum is Basisgrund_Vorhanden_Enum range Vernichtet_Enum .. Vernichtet_Enum;
   
   
   
   type Zusatzgrund_Enum is (
                             Leer_Zusatzgrund_Enum,
                             
                             -- Weltraum
                              
                             -- Himmel
                              
                             -- Oberfläche
                             Wald_Enum, Dschungel_Enum, Sumpf_Enum,
                             
                             -- Unterfläche
                             Korallen_Enum, Unterwald_Enum
                              
                             -- Planetenkern
                              
                             -- Sonstiges
                             
                            );
   pragma Ordered (Zusatzgrund_Enum);
   
   subtype Zusatzgrund_Vorhanden_Enum is Zusatzgrund_Enum range Zusatzgrund_Enum'Val (Zusatzgrund_Enum'Pos (Zusatzgrund_Enum'First) + 1) .. Zusatzgrund_Enum'Last;
   
   -- Weltraum
   
   
   -- Himmel
   
   
   -- Oberfläche
   subtype Zusatzgrund_Oberfläche_Enum is Zusatzgrund_Vorhanden_Enum range Wald_Enum .. Sumpf_Enum;
   
   -- Unterfläche
   subtype Zusatzgrund_Unterfläche_Enum is Zusatzgrund_Vorhanden_Enum range Korallen_Enum .. Unterwald_Enum;
   
   -- Planeteinneres
   
   
   -- Sonstiges
   
   
   
   
   -- Ressourcen für den Kern hinzufügen. äöü
   type Kartenressourcen_Enum is (
                                  Leer_Ressource_Enum,
                                   
                                  -- Wasserressourcen
                                  Fisch_Enum, Wal_Enum,
                                  Hochwertiges_Holz_Enum,
                                   
                                  -- Landressourcen
                                  Kohle_Enum, Eisen_Enum, Öl_Enum, Hochwertiger_Boden_Enum, Gold_Enum
                                     
                                  -- Kernressourcen
                                   
                                 );
   pragma Ordered (Kartenressourcen_Enum);
   
   subtype Kartenressourcen_Vorhanden_Enum is Kartenressourcen_Enum range Fisch_Enum .. Kartenressourcen_Enum'Last;
   
   subtype Kartenressourcen_Oberfläche_Enum is Kartenressourcen_Vorhanden_Enum range Fisch_Enum .. Gold_Enum;
   subtype Kartenressourcen_Oberfläche_Wasser_Enum is Kartenressourcen_Oberfläche_Enum range Fisch_Enum .. Wal_Enum;
   subtype Kartenressourcen_Oberfläche_Land_Enum is Kartenressourcen_Oberfläche_Enum range Hochwertiges_Holz_Enum .. Gold_Enum;
   
   subtype Kartenressourcen_Unterfläche_Enum is Kartenressourcen_Vorhanden_Enum range Fisch_Enum .. Gold_Enum;
   subtype Kartenressourcen_Unterfläche_Wasser_Enum is Kartenressourcen_Unterfläche_Enum range Fisch_Enum .. Hochwertiges_Holz_Enum;
   subtype Kartenressourcen_Unterfläche_Land_Enum is Kartenressourcen_Unterfläche_Enum range Kohle_Enum .. Gold_Enum;
   
   
   
   type Kartenfluss_Enum is (
                             Leer_Fluss_Enum,
                              
                             -- Fluss
                             Flusskreuzung_Vier_Enum, Fluss_Waagrecht_Enum, Fluss_Senkrecht_Enum, Flusskurve_Unten_Rechts_Enum, Flusskurve_Unten_Links_Enum, Flusskurve_Oben_Rechts_Enum, Flusskurve_Oben_Links_Enum,
                             Flusskreuzung_Drei_Oben_Enum, Flusskreuzung_Drei_Unten_Enum, Flusskreuzung_Drei_Rechts_Enum, Flusskreuzung_Drei_Links_Enum, Flussendstück_Links_Enum, Flussendstück_Rechts_Enum,
                             Flussendstück_Unten_Enum, Flussendstück_Oben_Enum, See_Enum,
                              
                             -- Unterirdischer Fluss
                             Unterirdische_Flusskreuzung_Vier_Enum, Unterirdischer_Fluss_Waagrecht_Enum, Unterirdischer_Fluss_Senkrecht_Enum, Unterirdische_Flusskurve_Unten_Rechts_Enum,
                             Unterirdische_Flusskurve_Unten_Links_Enum, Unterirdische_Flusskurve_Oben_Rechts_Enum, Unterirdische_Flusskurve_Oben_Links_Enum, Unterirdische_Flusskreuzung_Drei_Oben_Enum,
                             Unterirdische_Flusskreuzung_Drei_Unten_Enum, Unterirdische_Flusskreuzung_Drei_Rechts_Enum, Unterirdische_Flusskreuzung_Drei_Links_Enum, Unterirdisches_Flussendstück_Links_Enum,
                             Unterirdisches_Flussendstück_Rechts_Enum, Unterirdisches_Flussendstück_Unten_Enum, Unterirdisches_Flussendstück_Oben_Enum, Unterirdischer_See_Enum,
                              
                             -- Lavafluss
                             Lavaflusskreuzung_Vier_Enum, Lavafluss_Waagrecht_Enum, Lavafluss_Senkrecht_Enum, Lavaflusskurve_Unten_Rechts_Enum, Lavaflusskurve_Unten_Links_Enum, Lavaflusskurve_Oben_Rechts_Enum,
                             Lavaflusskurve_Oben_Links_Enum, Lavaflusskreuzung_Drei_Oben_Enum, Lavaflusskreuzung_Drei_Unten_Enum, Lavaflusskreuzung_Drei_Rechts_Enum, Lavaflusskreuzung_Drei_Links_Enum,
                             Lavaflussendstück_Links_Enum, Lavaflussendstück_Rechts_Enum, Lavaflussendstück_Unten_Enum, Lavaflussendstück_Oben_Enum, Lavasee_Enum
                            );
   pragma Ordered (Kartenfluss_Enum);
                              
   subtype Kartenfluss_Vorhanden_Enum is Kartenfluss_Enum range Flusskreuzung_Vier_Enum .. Kartenfluss_Enum'Last;
   
   subtype Kartenfluss_Oberfläche_Enum is Kartenfluss_Vorhanden_Enum range Flusskreuzung_Vier_Enum .. See_Enum;
   subtype Kartenfluss_Unterfläche_Enum is Kartenfluss_Vorhanden_Enum range Unterirdische_Flusskreuzung_Vier_Enum .. Unterirdischer_See_Enum;
   subtype Kartenfluss_Kern_Enum is Kartenfluss_Vorhanden_Enum range Lavaflusskreuzung_Vier_Enum .. Lavasee_Enum;

end KartengrundDatentypen;
